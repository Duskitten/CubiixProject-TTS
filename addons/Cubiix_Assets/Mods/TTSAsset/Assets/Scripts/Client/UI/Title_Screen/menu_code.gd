extends Control
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
var Root:Node

func _ready() -> void:
	Root = find_parent("DragArea")
	
func _on_export_pressed() -> void:
	var character = Root.Temp_Character
	$ScrollContainer2/VBoxContainer/TextEdit.text = Core.AssetData.Tools.export_character(character)

func _on_import_pressed() -> void:
	var json = JSON.new()
	if json.parse_string($ScrollContainer2/VBoxContainer/TextEdit.text) != null:
		find_parent("TextureRect").set_edited()
		var character = Root.Temp_Character
		Core.AssetData.Tools.generate_character_from_string($ScrollContainer2/VBoxContainer/TextEdit.text,character)
