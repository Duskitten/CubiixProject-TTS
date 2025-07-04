extends Control
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

func _process(delta: float) -> void:
	if self.visible && !Core.Globals.DisablePlayerInput:
		Core.Globals.DisablePlayerInput = true
	elif !self.visible && Core.Globals.DisablePlayerInput:
		Core.Globals.DisablePlayerInput = false
