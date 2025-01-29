extends Control
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
@onready var Anim = $AnimationPlayer
@onready var Side_A = $Side_A
@onready var Side_B = $Side_B
func _ready() -> void:
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
					i.pressed.connect(_on_generate_button_pressed.bind("Item",str(i.get_parent().name)))
		internal_button_check(i)
			

func _on_forward_button_pressed() -> void:
	Anim.play("Out")

func _on_back_button_pressed() -> void:
	Anim.play_backwards("Out")
	
func _on_generate_button_pressed(type:String,subtype:String) -> void:
	match type:
		"Item":
			var template_controller = $"Side_In-Menu/Menu_Slider/ScrollContainer/VBoxContainer/HBoxContainer/Template_Controller"
			var container = $"Side_In-Menu/Menu_Slider/ScrollContainer/VBoxContainer/HBoxContainer/VBoxContainer"
			for i in container.get_children():
				i.queue_free()
			for i in Core.AssetData.assets_tagged[subtype]:
				var asset = Core.AssetData.find_asset(i)
				var dupe_template = template_controller.duplicate()
				dupe_template.get_node("TextureButton/TextureRect/Label").text = asset["Name"]
				container.add_child(dupe_template)
				container.move_child(dupe_template,0)
				dupe_template.show()
			container.setup()
