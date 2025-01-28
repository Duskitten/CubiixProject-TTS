extends VBoxContainer
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

func _on_h_slider_value_changed(value: float, extra_arg_0: StringName) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(extra_arg_0),value)
	Core.Globals.Data["Visuals"][str(extra_arg_0)] = value

func _ready() -> void:
	for i in get_children():
		if i is BoxContainer:
			i.get_node("HBoxContainer/HSlider").value = Core.Globals.Data["Visuals"][i.name]
