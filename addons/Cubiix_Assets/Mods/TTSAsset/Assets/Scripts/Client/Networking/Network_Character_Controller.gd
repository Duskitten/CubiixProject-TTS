extends Node

var stored_value = {
	"Position":Vector3.ZERO,
	"Rotation":Vector3.ZERO,
	"Model_Rotation":Vector3.ZERO,
	"Current_Animation":""
}

func update_character(value:Dictionary) -> void:
	stored_value = value

func _physics_process(delta: float) -> void:
	get_parent().global_position = lerp(get_parent().global_position,stored_value["Position"],0.3)
	get_parent().global_rotation = Vector3(lerp_angle(get_parent().global_rotation.x,stored_value["Rotation"].x,0.3),lerp_angle(get_parent().global_rotation.y,stored_value["Rotation"].y,0.3),lerp_angle(get_parent().global_rotation.z,stored_value["Rotation"].z,0.3))
	get_parent().Hub.rotation = Vector3(lerp_angle(get_parent().Hub.rotation.x,stored_value["Model_Rotation"].x,0.3),lerp_angle(get_parent().Hub.rotation.y,stored_value["Model_Rotation"].y,0.3),lerp_angle(get_parent().Hub.rotation.z,stored_value["Model_Rotation"].z,0.3))
	get_parent().Hub.update_animation([stored_value["Current_Animation"], 0.1])
