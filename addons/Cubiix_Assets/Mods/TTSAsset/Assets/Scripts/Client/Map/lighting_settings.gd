extends Node
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

func _process(delta: float) -> void:
	if get_parent().directional_shadow_mode != Core.Globals.Data["Visuals"]["Shadow_Depth"]:
		get_parent().directional_shadow_mode = clamp(int(Core.Globals.Data["Visuals"]["Shadow_Depth"]),0,3)
		if Core.Globals.Data["Visuals"]["Shadow_Depth"] == -1:
			get_parent().shadow_enabled = false
		else:
			get_parent().shadow_enabled = true
