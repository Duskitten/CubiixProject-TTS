extends Node
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

func _ready() -> void:
	await get_tree().create_timer(0.1)
	Core.Globals.Setting_Changed.connect(update_setting.bind())

func update_setting() -> void:
	#print("Test")
	get_parent().environment.glow_enabled = Core.Globals.Data["Visuals"]["Bloom"]
