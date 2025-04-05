extends Control
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
@onready var Template_Log = $TextureRect/Control/Template_Log
@onready var Template_Button = $TextureRect/VBoxContainer/ScrollContainer/VBoxContainer/Template_Button

var logdata = {
	
}

func _ready() -> void:
	for i in Core.AssetData.assets_tagged["Log_Entry"]:
		print(i)
		var LogData = Core.AssetData.find_log(i)
		logdata[i] = LogData
		var button = Template_Button.duplicate(true)
		button.get_node("Button").pressed.connect(switch_to_log.bind(i))
		button.get_node("Button").text = i
		$TextureRect/VBoxContainer/ScrollContainer/VBoxContainer.add_child(button)
		button.show()
		

func switch_to_log(i:String):
	Template_Log.show()
	Template_Log.get_node("Title").text = i
	Template_Log.get_node("HBoxContainer/Author").text = logdata[i]["Author"]
	Template_Log.get_node("HBoxContainer/Date").text  = logdata[i]["Date"]
	Template_Log.get_node("RichTextLabel").text  = logdata[i]["Description"]
