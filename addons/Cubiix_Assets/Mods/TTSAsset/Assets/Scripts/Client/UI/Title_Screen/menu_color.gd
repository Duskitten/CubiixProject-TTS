extends Control


func _on_button_toggled(toggled_on: bool, extra_arg_0: String) -> void:
	if toggled_on:
		var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
		
		tween.tween_property(get_node("ScrollContainer2/VBoxContainer/"+extra_arg_0),"custom_minimum_size", Vector2(0,300), .2)
	else:
		var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
		
		tween.tween_property(get_node("ScrollContainer2/VBoxContainer/"+extra_arg_0),"custom_minimum_size", Vector2(0,0), .2)

func setup() -> void:
	$ScrollContainer2/VBoxContainer/Body_Color_1/HBoxContainer/VBoxContainer.setup()
	$ScrollContainer2/VBoxContainer/Body_Color_2/HBoxContainer/VBoxContainer.setup()
	$ScrollContainer2/VBoxContainer/Eye_Color_1/HBoxContainer/VBoxContainer.setup()
	$ScrollContainer2/VBoxContainer/Eye_Color_2/HBoxContainer/VBoxContainer.setup()
