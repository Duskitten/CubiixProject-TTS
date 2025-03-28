extends Node
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

func _ready() -> void:
	Core.Globals.Setting_Changed.connect(update_setting.bind())
	update_setting()

func update_setting() -> void:
	get_parent().directional_shadow_mode = clamp(int(Core.Globals.Data["Visuals"]["Shadow_Depth"]),0,3)
	if int(Core.Globals.Data["Visuals"]["Shadow_Depth"]) == -1:
		get_parent().shadow_enabled = false
	else:
		get_parent().shadow_enabled = true
