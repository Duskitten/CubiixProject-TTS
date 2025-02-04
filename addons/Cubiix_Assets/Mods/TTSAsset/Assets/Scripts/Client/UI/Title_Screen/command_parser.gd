extends Node

@onready var RTL:RichTextLabel = get_node("../RichTextLabel")
@onready var Line:LineEdit = get_node("../LineEdit")
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

func _ready() -> void:
	RTL.text += "Cubiix Project : TTL Version " + Core.Globals.GameVersion

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("CMD"):
		get_parent().visible = !get_parent().visible

func _on_line_edit_text_submitted(new_text: String) -> void:
	Line.text = ""
	RTL.text += "\n> "+new_text
	command_parser(new_text)

func command_parser(text:String) -> void:
	var lowered = text.to_lower()
	var split_lowered = lowered.split(" ")
	var split_normal = text.split(" ")
	
	if split_lowered.size() > 0:
		match split_lowered[0]:
			"swap_map":
				if split_normal.size() > 2:
					Core.SceneData.call_deferred("load_scene",split_normal[1],{},true,split_normal[2])
				elif split_normal.size() > 1:
					Core.SceneData.call_deferred("load_scene",split_normal[1],{},true,"")
			"commands":
				RTL.text += "\n Current Commands:"
				RTL.text += "\n commands: This Screen"
				RTL.text += "\n swap_map : For Map Switching, syntax \"swap_map mapid spawnlocation\""
