extends HBoxContainer


var new_tween:Tween
var old_tween:Tween
func _on_texture_button_mouse_entered(extra_arg_0: String) -> void:
	if old_tween != null:
		old_tween.kill()
	
	new_tween = get_tree().create_tween().set_parallel(true)
	
	print(extra_arg_0)
	for node in get_children():
		if node.name == extra_arg_0:
			new_tween.tween_property(node.get_node("VBoxContainer/Control"),"scale", Vector2(1.25,1.25), .5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
			
			#node.get_node("VBoxContainer/Control").scale = Vector2(1.2,1.2)
		else:
			new_tween.tween_property(node.get_node("VBoxContainer/Control"),"scale", Vector2(0.8,0.8), .5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
			#node.get_node("VBoxContainer/Control").scale = Vector2(0.8,0.8)
	old_tween = new_tween
	
func _on_texture_button_mouse_exited(extra_arg_0: String) -> void:
	if old_tween != null:
		old_tween.kill()
	
	new_tween = get_tree().create_tween().set_parallel(true)
	
	for node in get_children():
		new_tween.tween_property(node.get_node("VBoxContainer/Control"),"scale", Vector2(1.0,1.0), .5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
		#node.get_node("VBoxContainer/Control").scale = Vector2(1.0,1.0)
	
	old_tween = new_tween
