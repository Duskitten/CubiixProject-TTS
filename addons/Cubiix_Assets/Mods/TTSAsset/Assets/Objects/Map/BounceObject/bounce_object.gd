class_name BounceObject extends Area3D

@export var bounce_power :float = 1.0

func _ready() -> void:
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	set_collision_layer_value(2, true)
	set_collision_mask_value(2, true)
	
	body_entered.connect(_on_bouncepad_has_been_activated)

func _on_bouncepad_has_been_activated(body) -> void:
	
	if body.get_node_or_null("Character_Controller"):
		var char_con = body.get_node("Character_Controller")
		var MoveMarker = body.get_node("MoveMarker")
		char_con.gravity_control = (MoveMarker.global_transform.basis.y * 1) * bounce_power
