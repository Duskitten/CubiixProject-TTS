extends Node

@onready var RTL:RichTextLabel = get_node("../RichTextLabel")
@onready var Line:LineEdit = get_node("../LineEdit")
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

var last_command = []
var command_pos = 0
var last_input = ""

func _ready() -> void:
	Core.Console = self
	new_debug("Cubiix Project : TTL Version " + Core.Globals.GameVersion, false)

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
				new_debug("Current Commands:")
				new_debug("commands: This Screen")
				new_debug("swap_map : For Map Switching, syntax \"swap_map mapid spawnlocation\"")
			"teleport":
				if split_normal.size() > 3:
					var xyz = Vector3(float(split_normal[1]),float(split_normal[2]),float(split_normal[3]))
	
	last_command.append(text)
	command_pos = last_command.size()

func _on_line_edit_gui_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_UP:
			if command_pos == last_command.size():
				last_input = Line.text
			
			if !last_command.is_empty() && command_pos > 0:
				command_pos -= 1
				Line.text = last_command[command_pos]
		if event.pressed and event.keycode == KEY_DOWN:
			if !last_command.is_empty() && command_pos < last_command.size():
				command_pos += 1
				if command_pos == last_command.size():
					Line.text = last_input
				else:
					Line.text = last_command[command_pos]

func new_debug(text:String, newline:bool = true) -> void:
	if newline:
		RTL.text += "\n"+text
	else:
		RTL.text += text
