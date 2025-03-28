extends Node
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

func _ready() -> void:
	Core.Globals.Setting_Changed.connect(update_setting.bind())
	update_setting()

func update_setting() -> void:
	get_parent().fov = clampf(float(Core.Globals.Data["Visuals"]["FOV"]),60,130)
