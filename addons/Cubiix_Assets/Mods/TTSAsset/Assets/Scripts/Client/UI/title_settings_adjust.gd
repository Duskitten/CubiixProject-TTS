extends Control
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

func _on_h_slider_value_changed(value: float,extra_arg_0: StringName, extra_arg_1:StringName) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(extra_arg_0),value)
	Core.Globals.Data[str(extra_arg_1)][str(extra_arg_0)] = value

func _ready() -> void:
	for i in get_children():
		var core = i.name
		for x in i.get_children():
			if x is BoxContainer:
				print(Core.Globals.Data[str(core)])
				x.get_node("HBoxContainer/HSlider").value = Core.Globals.Data[str(core)][str(x.name)]

func hide_all() -> void:
	for i in get_children():
		i.hide()

func _on_button_pressed(extra_arg_0:String) -> void:
	hide_all()
	get_node(extra_arg_0).show()
