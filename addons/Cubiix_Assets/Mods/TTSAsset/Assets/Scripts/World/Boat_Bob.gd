extends StaticBody3D

func _physics_process(delta: float) -> void:
	self.position.y += sin(Time.get_ticks_msec()/200)/1100
	


func _on_visible_on_screen_enabler_3d_screen_entered() -> void:
	$Skim_Boat.show()

func _on_visible_on_screen_enabler_3d_screen_exited() -> void:
	$Skim_Boat.hide()
