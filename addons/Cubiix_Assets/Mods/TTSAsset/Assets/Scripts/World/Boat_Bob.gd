extends StaticBody3D

@onready var Core = get_node("/root/Main_Scene/CoreLoader")

func _physics_process(delta: float) -> void:
	self.position.y += sin(Core.Globals.Physics_Time)/1100
	


func _on_visible_on_screen_enabler_3d_screen_entered() -> void:
	$Skim_Boat.show()

func _on_visible_on_screen_enabler_3d_screen_exited() -> void:
	$Skim_Boat.hide()
