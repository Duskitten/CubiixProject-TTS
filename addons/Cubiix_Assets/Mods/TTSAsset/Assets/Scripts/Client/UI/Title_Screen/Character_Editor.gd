extends Control
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
@onready var Anim = $AnimationPlayer
@onready var Side_A = $Side_A
@onready var Side_B = $Side_B
var Root:Node
func _ready() -> void:
	Root = find_parent("DragArea")
	internal_button_check(Side_A)
	internal_button_check(Side_B)
	
func internal_button_check(node:Node) -> void:
	for i in node.get_children():
		if i is BaseButton:
			match i.get_parent().name:
				"Palette":
					pass
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

func _on_back_button_pressed() -> void:
	Anim.play_backwards("Out")
	
func _on_generate_button_pressed(type:String,subtype:Node) -> void:
	match type:
		"Item":
			var extended:String
			match subtype.get_meta("type"):
				true:
					extended = "Acc_"
				false:
					extended = "Base_"
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

func set_new_value(WhatVar:String,WhatValue:String) -> void:
	#print(WhatVar, WhatValue)
	var character = Root.Temp_Character
	character.set(WhatVar,WhatValue)
	character.generate_character()
