extends Node
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

func _process(delta: float) -> void:
	get_parent().directional_shadow_mode = clamp(int(Core.Globals.Data["Visuals"]["Shadow_Depth"]),0,3)
	if int(Core.Globals.Data["Visuals"]["Shadow_Depth"]) < 0:
		get_parent().shadow_enabled = false
	else:
		get_parent().shadow_enabled = true
