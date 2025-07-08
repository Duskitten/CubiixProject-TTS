extends Control
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

var HasControl = false
var ArrayPosition = 0

func _ready() -> void:
	for i in Core.AssetData.assets_tagged["Log_Entry"].size():
		var x = Core.AssetData.assets_tagged["Log_Entry"][i]
		if x.contains(Core.Globals.GameVersion):
			populate_new_log(Core.AssetData.find_log(x),x)
			ArrayPosition = i
			break

func populate_new_log(logdata:Dictionary, title:String) -> void:
	$Panel/HBoxContainer/Label3.text = title
	$Panel3/HBoxContainer2/Label3.text = logdata["Date"]
	$Panel2/VBoxContainer/HBoxContainer/RichTextLabel.text = logdata["Description"]
	

func _process(delta: float) -> void:
	if HasControl:
		if Input.is_action_just_pressed("dp_right"):
			ArrayPosition += 1
			var coresize = Core.AssetData.assets_tagged["Log_Entry"].size() - 1
			if ArrayPosition > coresize:
				ArrayPosition = 0
			var log = Core.AssetData.assets_tagged["Log_Entry"][ArrayPosition]
			populate_new_log(Core.AssetData.find_log(log),log)
		if Input.is_action_just_pressed("dp_left"):
			ArrayPosition -= 1
			var coresize = Core.AssetData.assets_tagged["Log_Entry"].size() - 1
			if ArrayPosition < 0:
				ArrayPosition = coresize
			var log = Core.AssetData.assets_tagged["Log_Entry"][ArrayPosition]
			populate_new_log(Core.AssetData.find_log(log),log)
		if Input.is_action_pressed("dp_up"):
			$Panel2/VBoxContainer/HBoxContainer/RichTextLabel.get_child(0,true).value -= 3
		if Input.is_action_pressed("dp_down"):
			$Panel2/VBoxContainer/HBoxContainer/RichTextLabel.get_child(0,true).value += 3
