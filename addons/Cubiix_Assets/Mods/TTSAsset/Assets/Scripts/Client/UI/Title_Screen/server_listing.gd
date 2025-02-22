extends Control

@onready var Server_Template = $Template_Server

var currentTemplate:Control = null

func _on_add_button_pressed() -> void:
	currentTemplate = Server_Template.duplicate()
	$Add_Screen.show()
	$List.hide()

func _on_Edit_Back_pressed() -> void:
	$Add_Screen.hide()
	$List.show()
	currentTemplate.queue_free()

func _on_edit_add_pressed() -> void:
	$Add_Screen.hide()
	$List.show()
	$List/VBoxContainer.add_child(currentTemplate)
	$List/VBoxContainer.move_child(currentTemplate,$List/VBoxContainer.get_child_count()-2)
	currentTemplate.show()
