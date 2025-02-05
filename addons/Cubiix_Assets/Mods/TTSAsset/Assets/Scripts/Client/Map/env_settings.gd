extends Node
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

func _process(delta: float) -> void:
	if get_parent().environment.glow_enabled != Core.Globals.Data["Visuals"]["Bloom"]:
		get_parent().environment.glow_enabled = Core.Globals.Data["Visuals"]["Bloom"]
