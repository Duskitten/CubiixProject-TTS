extends Control
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
@onready var textbox = $VBoxContainer/TextureRect/VBoxContainer/Text

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Core.Globals.Update_Triggered.connect(UpdatePrompt.bind())

func UpdatePrompt() -> void:
	textbox.text = "Would you like to update to version {versionID}?".format({"versionID":Core.Globals.NewGameVersion})

func _on_confirm_pressed() -> void:
	self.hide()
	$"../Downloading".trigger_update()
	$"../Downloading".show()
