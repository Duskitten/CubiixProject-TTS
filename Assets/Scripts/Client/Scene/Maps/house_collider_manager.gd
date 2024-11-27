extends Node3D


func _ready() -> void:
	for i in get_children():
		i.body_entered.connect(_on_area_3d_body_entered.bind(i.name))

func _on_area_3d_body_entered(body: Node3D, cam_target: String) -> void:
	if body.is_in_group("Player"):
		print("Haoi")
		body.target_camera_position = get_node(cam_target+"/Marker3D")


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("Player"):
		body.target_camera_position = null
