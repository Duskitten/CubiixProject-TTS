extends Node3D
var preventHiding = false

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		preventHiding = true
		body.target_camera_position = $Paternoster/area_3d/Marker3D


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("Player"):
		preventHiding = false
		body.target_camera_position = null
