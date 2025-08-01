extends Control
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
@export var ControllerID = 0

func _process(delta: float) -> void:
	if self.visible && !Core.Globals.DisablePlayerInput:
		Core.Globals.DisablePlayerInput = true
	elif !self.visible && Core.Globals.DisablePlayerInput:
		Core.Globals.DisablePlayerInput = false
	
	if Core.Globals.local_inputs[ControllerID].Current_Input["Menu_Button_Just_Pressed"]:
		if self.visible:
			var tween = get_tree().create_tween()
			tween.set_parallel(true).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
			tween.tween_property(self, "modulate", Color("FFFFFF",0), .2)
			tween.tween_property(self, "position:x", -self.size.x/2, .2)
			tween.tween_callback(func():self.hide()).set_delay(.2)

		else:
			self.show()
			var tween = get_tree().create_tween()
			tween.set_parallel(true).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
			tween.tween_property(self, "modulate", Color("FFFFFF",1), .2)
			tween.tween_property(self, "position:x", 0, .2)
