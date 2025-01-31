extends Node3D

var coin_rotation_speed :int = 5

func _physics_process(delta: float) -> void:
	$CoinSprite.rotation.y += coin_rotation_speed * delta
	
	if $RayCast3D.is_colliding():
		$Shadow.global_position.y = $RayCast3D.get_collision_point().y + 0.01


func _on_collection_detection_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		# Fire a collection event
		
		self.disconnect("body_entered", _on_collection_detection_body_entered)
		coin_rotation_speed = 10
		var tween = get_tree().create_tween()
		tween.tween_property($CoinSprite, "position:y", 0.2, 0.2).set_ease(Tween.EASE_IN)
		tween.tween_property($CoinSprite, "position:y", 0, 0.2).set_ease(Tween.EASE_OUT)
		
		await tween.finished
		queue_free()
