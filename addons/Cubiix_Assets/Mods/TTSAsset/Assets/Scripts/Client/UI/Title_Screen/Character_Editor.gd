extends Control
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
@onready var Anim = $AnimationPlayer
@onready var Side_A = $Side_A
@onready var Side_B = $Side_B
var Root:Node


@export var Shader_Color : Array[Color]
@export var Shader_Emission : Array[Color]
@export_range(0,1) var Shader_Metallic : Array[float]
@export_range(0,1) var Shader_Roughness : Array[float]
@export_range(0,1) var Shader_Emission_Strength : Array[float]
@export_range(0,1) var Shader_Alpha : Array[float]

var Base_Eyes:String  = ""
var Base_Ears:String  = ""
var Base_Extras:String  = ""
var Base_Tails:String  = ""
var Base_Wings:String  = ""
var Acc_Head:String  = ""
var Acc_Face:String  = ""
var Acc_Chest:String  = ""
var Acc_Back:String  = ""
var Acc_L_Hand:String  = ""
var Acc_R_Hand:String  = ""
var Acc_L_Hip:String  = ""
var Acc_R_Hip:String  = ""

var Name:String  = ""
var Pronouns_A:String  = ""
var Pronouns_B:String  = ""
var Pronouns_C:String = ""
var Faction:int = 0

var Scale:float = 1
var character

var Keylist = {
	"Body":{"Body1":0,"Body2":2,"Eye1":1,"Eye2":3},
	"Head":[4,6,5,7],
	"Face":[8,10,9,11],
	"Chest":[12,14,13,15],
	"Back":[16,18,17,19],
	"L_Hand":[20,22,21,23],
	"R_Hand":[24,26,25,27],
	"L_Hip":[28,30,29,31],
	"R_Hip":[32,34,33,35],
}

var Target_Node:String = ""

var LastActiveScreen:String  = ""

func _ready() -> void:
	
	Core.Persistant_Core.TemplateChar = self
	Root = find_parent("DragArea")
	character = Root.Temp_Character
	internal_button_check(Side_A)
	internal_button_check(Side_B)
	
	Shader_Color.resize(36)
	Shader_Emission.resize(36)
	Shader_Metallic.resize(36)
	Shader_Metallic.fill(0.0)
	Shader_Roughness.resize(36)
	Shader_Roughness.fill(1.0)
	Shader_Emission_Strength.resize(36)
	Shader_Alpha.resize(36)
	Shader_Alpha.fill(1.0)
	
	await get_tree().create_timer(0.1).timeout
	Core.AssetData.Tools.clone_character_with_accessories(character,self)

func update_self_and_character():
	Core.AssetData.Tools.clone_character_with_accessories(Core.Persistant_Core.Player.Hub,self)
	Core.AssetData.Tools.clone_character_with_accessories(self,character)


func internal_button_check(node:Node) -> void:
	for i in node.get_children():
		if i is BaseButton:
			match i.get_parent().name:
				"Palette":
					i.pressed.connect(_on_forward_button_pressed.bind())
					i.pressed.connect(_on_generate_button_pressed.bind("Palette",i.get_parent()))
				"Who":
					i.pressed.connect(_on_forward_button_pressed.bind())
					i.pressed.connect(_on_generate_button_pressed.bind("Details",i.get_parent()))
				"Loader":
					i.pressed.connect(_on_forward_button_pressed.bind())
					i.pressed.connect(_on_generate_button_pressed.bind("Code",i.get_parent()))
				_:
					i.pressed.connect(_on_forward_button_pressed.bind())
					i.pressed.connect(_on_generate_button_pressed.bind("Item",i.get_parent()))
		internal_button_check(i)
			

func _on_forward_button_pressed() -> void:
	Anim.play("Out")
	set_back()

func _on_back_button_pressed(notkeep:bool = true) -> void:
	var character = Root.Temp_Character
	Anim.play_backwards("Out")
	hide_both()
	if notkeep:
		if LastActiveScreen == "Palette":
			$"Side_In-Menu/Menu_Color".revert()
		elif LastActiveScreen == "Code" || LastActiveScreen == "Details":
			Core.AssetData.Tools.clone_character_with_accessories(self, character)
		else:
			if self.get(Target_Node) != "":
				character.set(Target_Node,self.get(Target_Node))
				character.generate_character()
	else:
		if LastActiveScreen == "Code" || LastActiveScreen == "Details":
			Core.AssetData.Tools.clone_character_with_accessories(character, self)
		self.set(Target_Node,character.get(Target_Node))
		Core.AssetData.Tools.clone_character_with_accessories(character,Core.Persistant_Core.Player.get_node("Hub"))
		
func _on_generate_button_pressed(type:String,subtype:Node) -> void:
	LastActiveScreen = type
	match type:
		"Item":
			$"Side_In-Menu/Menu_Color".hide()
			$"Side_In-Menu/Menu_Details".hide()
			$"Side_In-Menu/Menu_Slider".show()
			$"Side_In-Menu/Menu_Code".hide()
			var extended:String
			match subtype.get_meta("type"):
				true:
					extended = "Acc_"
				false:
					extended = "Base_"
			Target_Node = extended+str(subtype.name)
			var template_controller = $"Side_In-Menu/Menu_Slider/ScrollContainer/VBoxContainer/HBoxContainer/Template_Controller"
			var container = $"Side_In-Menu/Menu_Slider/ScrollContainer/VBoxContainer/HBoxContainer/VBoxContainer"
			for i in container.get_children():
				i.queue_free()

			for i in Core.AssetData.assets_tagged[str(subtype.name)]:
				var asset = Core.AssetData.find_asset(i)
				var dupe_template = template_controller.duplicate()
				dupe_template.get_node("TextureButton/TextureRect/Label").text = asset["Name"]
				
				var image = load(asset["Image_Preview"])
				print(image == null)
				if image != null:
					dupe_template.get_node("TextureButton/TextureRect").texture = image
				else:
					dupe_template.get_node("TextureButton/TextureRect").texture = ResourceLoader.load("res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Tablet_Assets/Card_Assets/Template_Card.png","",ResourceLoader.CACHE_MODE_REPLACE)
				dupe_template.get_node("TextureButton").pressed.connect(set_new_value.bind(extended+str(subtype.name),i))
				container.add_child(dupe_template)
				container.move_child(dupe_template,0)
				dupe_template.show()
			await get_tree().process_frame
			container.setup()
		"Palette":
			$"Side_In-Menu/Menu_Color".show()
			$"Side_In-Menu/Menu_Slider".hide()
			$"Side_In-Menu/Menu_Code".hide()
			$"Side_In-Menu/Menu_Details".hide()
			$"Side_In-Menu/Menu_Color".setup()
		"Code":
			$"Side_In-Menu/Menu_Color".hide()
			$"Side_In-Menu/Menu_Slider".hide()
			$"Side_In-Menu/Menu_Details".hide()
			$"Side_In-Menu/Menu_Code".show()
		"Details":
			$"Side_In-Menu/Menu_Color".hide()
			$"Side_In-Menu/Menu_Slider".hide()
			$"Side_In-Menu/Menu_Details".show()
			$"Side_In-Menu/Menu_Code".hide()
			$"Side_In-Menu/Menu_Details".setup()
			
func set_new_value(WhatVar:String,WhatValue:String) -> void:
	#print(WhatVar, WhatValue)
	character.set(WhatVar,WhatValue)
	character.generate_character()
	set_edited()

func set_back() -> void:
	get_node("Center/Edited").hide()
	get_node("Center/Back").show()

func set_edited() -> void:
	get_node("Center/Edited").show()
	get_node("Center/Back").hide()
	
func hide_both() -> void:
	get_node("Center/Edited").hide()
	get_node("Center/Back").hide()

func generate_character() -> void:
	pass
