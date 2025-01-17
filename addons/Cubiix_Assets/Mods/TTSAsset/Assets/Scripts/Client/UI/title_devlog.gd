extends Control
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
@onready var Template_Log = $TextureRect/Control/Template_Log
@onready var Template_Button = $TextureRect/VBoxContainer/ScrollContainer/VBoxContainer/Template_Button

func _ready() -> void:
	print(Core.AssetData.assets_tagged["Log_Entry"])
	
