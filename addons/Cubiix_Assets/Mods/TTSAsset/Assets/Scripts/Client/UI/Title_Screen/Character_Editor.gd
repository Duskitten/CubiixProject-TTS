extends Control
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
@onready var Anim = $AnimationPlayer
@onready var Side_A = $Side_A
@onready var Side_B = $Side_B
var Root:Node

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

var Target_Node:String = ""

func _ready() -> void:
	Root = find_parent("DragArea")
	internal_button_check(Side_A)
	internal_button_check(Side_B)
	var character = Root.Temp_Character
	Base_Eyes = character.get("Base_Eyes")
	
func internal_button_check(node:Node) -> void:
	for i in node.get_children():
		if i is BaseButton:
			match i.get_parent().name:
				"Palette":
					i.pressed.connect(_on_forward_button_pressed.bind())
					i.pressed.connect(_on_generate_button_pressed.bind("Palette",i.get_parent()))
				"Who":
					pass
				"Loader":
					pass
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
		$"Side_In-Menu/Menu_Color".revert()
		character.set(Target_Node,self.get(Target_Node))
		character.generate_character()
	else:
		self.set(Target_Node,character.get(Target_Node))
		Core.AssetData.Tools.clone_character_with_accessories(character,Core.Persistant_Core.Player.get_node("Hub"))
		
func _on_generate_button_pressed(type:String,subtype:Node) -> void:
	match type:
		"Item":
			$"Side_In-Menu/Menu_Color".hide()
			$"Side_In-Menu/Menu_Slider".show()
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
					dupe_template.get_node("TextureButton/TextureRect").texture = load("res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Tablet_Assets/Card_Assets/Template_Card.png")
				dupe_template.get_node("TextureButton").pressed.connect(set_new_value.bind(extended+str(subtype.name),i))
				container.add_child(dupe_template)
				container.move_child(dupe_template,0)
				dupe_template.show()
			await get_tree().process_frame
			container.setup()
		"Palette":
			$"Side_In-Menu/Menu_Color".show()
			$"Side_In-Menu/Menu_Slider".hide()
			$"Side_In-Menu/Menu_Color".setup()
			
func set_new_value(WhatVar:String,WhatValue:String) -> void:
	#print(WhatVar, WhatValue)
	var character = Root.Temp_Character
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
