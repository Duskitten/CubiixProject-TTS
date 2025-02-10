extends Node3D
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

func _ready() -> void:
	Core.Persistant_Core.AudioHost = self
