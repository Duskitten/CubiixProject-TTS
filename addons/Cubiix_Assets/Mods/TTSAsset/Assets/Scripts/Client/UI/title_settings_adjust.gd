extends Control
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

func _on_h_slider_value_changed(value: float,extra_arg_0: StringName, extra_arg_1:StringName) -> void:
	if extra_arg_1 == &"Audio":
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index(extra_arg_0),int(value))
	elif extra_arg_0 == &"Anti-Aliasing":
		get_viewport().msaa_3d = int(value)
	if Core != null:
		Core.Globals.Data[str(extra_arg_1)][str(extra_arg_0)] = value

func _ready() -> void:
	for i in get_children():
		var core = i.name
		for x in i.get_children():
			if x is BoxContainer:
				x.get_node("HBoxContainer/HSlider").value = Core.Globals.Data[str(core)][str(x.name)]

func hide_all() -> void:
	for i in get_children():
		i.hide()

func _on_button_pressed(extra_arg_0:String) -> void:
	hide_all()
	match extra_arg_0:
		"Audio":
			get_node("Audio/SFX/HBoxContainer/HSlider").value = Core.Globals.Data[str(extra_arg_0)]["SFX"]
			get_node("Audio/Master/HBoxContainer/HSlider").value = Core.Globals.Data[str(extra_arg_0)]["Master"]
			get_node("Audio/Music/HBoxContainer/HSlider").value = Core.Globals.Data[str(extra_arg_0)]["Music"]
			get_node("Audio/Notification/HBoxContainer/HSlider").value = Core.Globals.Data[str(extra_arg_0)]["Notification"]
			get_node("Audio/Ping/HBoxContainer/HSlider").value = Core.Globals.Data[str(extra_arg_0)]["Ping"]
		"Visuals":
			get_node("Visuals/Shadow_Depth/HBoxContainer/HSlider").value = Core.Globals.Data[str(extra_arg_0)]["Shadow_Depth"]
			get_node("Visuals/Anti-Aliasing/HBoxContainer/HSlider").value = Core.Globals.Data[str(extra_arg_0)]["Anti-Aliasing"]
	get_node(extra_arg_0).show()
