extends Control
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
@onready var Server_Template = $Template_Server

var currentTemplate:Control = null

func setup() -> void:
	$List/VBoxContainer.disable = true
	for i in Core.Globals.Data["SavedServers"]:
		currentTemplate = Server_Template.duplicate()
		currentTemplate.set_meta("ip",i[0])
		currentTemplate.set_meta("port",i[1])
		currentTemplate.get_node("HBoxContainer/VBoxContainer/IP").text = i[0] +":"+i[1]
		$List/VBoxContainer/VBoxContainer.add_child(currentTemplate)
		currentTemplate.show()
	$List/VBoxContainer.disable = false
	$List/VBoxContainer.updatevalues()
	
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
	Core.Globals.Data["SavedServers"].append([$Add_Screen/TextureRect/VBoxContainer/IP.text,$Add_Screen/TextureRect/VBoxContainer/Port.text])
	currentTemplate.show()
