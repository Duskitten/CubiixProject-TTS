extends Control

@onready var Server_Template = $Template_Server

var currentTemplate:Control = null

func _on_add_button_pressed() -> void:
	currentTemplate = Server_Template.duplicate()
	$Add_Screen/TextureRect/VBoxContainer/IP.text = ""
	$Add_Screen/TextureRect/VBoxContainer/Port.text = ""
	$Add_Screen.show()
	$List.hide()

func _on_Edit_Back_pressed() -> void:
	$Add_Screen.hide()
	$List.show()
	currentTemplate.queue_free()

func _on_edit_add_pressed() -> void:
	$Add_Screen.hide()
	$List.show()
	currentTemplate.set_meta("ip",$Add_Screen/TextureRect/VBoxContainer/IP.text)
	currentTemplate.set_meta("port",$Add_Screen/TextureRect/VBoxContainer/Port.text)
	currentTemplate.get_node("HBoxContainer/VBoxContainer/IP").text = $Add_Screen/TextureRect/VBoxContainer/IP.text +":"+$Add_Screen/TextureRect/VBoxContainer/Port.text
	$List/VBoxContainer/VBoxContainer.add_child(currentTemplate)
	currentTemplate.show()
