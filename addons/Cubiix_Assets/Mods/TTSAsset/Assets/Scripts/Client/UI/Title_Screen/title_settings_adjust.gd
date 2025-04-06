extends Control
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

func _on_h_slider_value_changed(value: float,extra_arg_0: StringName, extra_arg_1:StringName) -> void:
	if extra_arg_1 == &"Audio":
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index(extra_arg_0),int(value))
	elif extra_arg_0 == &"Anti-Aliasing":
		get_viewport().msaa_3d = clamp(int(value),0,3)
	if Core != null:
		Core.Globals.Data[str(extra_arg_1)][str(extra_arg_0)] = value
		Core.Globals.emit_signal("Setting_Changed")

func _ready() -> void:
	Core.Globals.Setting_Changed.connect(sync.bind())
	sync()
	await get_tree().process_frame
	Core.Globals.emit_signal("Setting_Changed")
	
func sync() -> void:
	for i in get_children():
		var core = i.name
		for x in i.get_children():
			if x is BoxContainer:
				if x.get_node_or_null("HBoxContainer/HSlider") != null:
					x.get_node("HBoxContainer/HSlider").value = Core.Globals.Data[str(core)][str(x.name)]
				if x.get_node_or_null("HBoxContainer/CheckButton") != null:
					x.get_node("HBoxContainer/CheckButton").button_pressed = Core.Globals.Data[str(core)][str(x.name)]


func hide_all() -> void:
	for i in get_children():
		i.hide()

func _on_button_pressed(extra_arg_0:String) -> void:
	hide_all()
	match extra_arg_0:
		"Audio":
			get_node("Audio/SFX/HBoxContainer/HSlider").value = Core.Globals.Data[str(extra_arg_0)]["SFX"]
			get_node("Audio/Music/HBoxContainer/HSlider").value = Core.Globals.Data[str(extra_arg_0)]["Music"]
			get_node("Audio/Notification/HBoxContainer/HSlider").value = Core.Globals.Data[str(extra_arg_0)]["Notification"]
			get_node("Audio/Ping/HBoxContainer/HSlider").value = Core.Globals.Data[str(extra_arg_0)]["Ping"]
		"Visuals":
			get_node("Visuals/Shadow_Depth/HBoxContainer/HSlider").value = Core.Globals.Data[str(extra_arg_0)]["Shadow_Depth"]
			get_node("Visuals/Anti-Aliasing/HBoxContainer/HSlider").value = Core.Globals.Data[str(extra_arg_0)]["Anti-Aliasing"]
			get_node("Visuals/FOV/HBoxContainer/HSlider").value = Core.Globals.Data[str(extra_arg_0)]["FOV"]
			get_node("Visuals/Bloom/HBoxContainer/CheckButton").button_pressed = Core.Globals.Data[str(extra_arg_0)]["Bloom"]
	get_node(extra_arg_0).show()

func _on_check_button_toggled(toggled_on: bool, extra_arg_0: StringName, extra_arg_1: StringName) -> void:
	if Core != null:
		Core.Globals.Data[str(extra_arg_1)][str(extra_arg_0)] = toggled_on
		Core.Globals.emit_signal("Setting_Changed")
