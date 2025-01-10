extends SubViewport

var MouseInside = false
var Intzoom = 0

func _process(delta: float) -> void:
	if (get_parent() as SubViewportContainer).get_global_rect().has_point(get_parent().get_viewport().get_mouse_position()):
		if Input.is_action_just_pressed("mouse_left"):
			MouseInside = true
		
		if Input.is_action_just_released("scroll_up"):
			$Character_Editor/Y/X/Z/Camera3D.fov -= 1.0
			$Character_Editor/Y/X/Z/Camera3D.fov = clampf($Character_Editor/Y/X/Z/Camera3D.fov,30.2,48.0 )
		if Input.is_action_just_released("scroll_down"):
			$Character_Editor/Y/X/Z/Camera3D.fov += 1.0
			$Character_Editor/Y/X/Z/Camera3D.fov = clampf($Character_Editor/Y/X/Z/Camera3D.fov,30.2,48.0 )
	
	if Input.is_action_just_released("mouse_left") && MouseInside:
		MouseInside = false
		
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if MouseInside:
			$Character_Editor/Cubiix_Base/Hub.rotation.y -= event["relative"].x / 200
			#$Character_Editor/Y/X.rotation.x -= event["relative"].y / 200
			#$Character_Editor/Y/X.rotation_degrees.x = clamp($Character_Editor/Y/X.rotation_degrees.x,-85,0)
