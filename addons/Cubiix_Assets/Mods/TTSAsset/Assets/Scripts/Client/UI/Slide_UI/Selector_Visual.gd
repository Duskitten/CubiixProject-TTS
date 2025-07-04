extends Panel

var options = [
	["Home", 8],
	["Play", -26],
	["Login", -60],
	["Social", -94],
	["Settings", -128],
	["Quit", -162]
]
var Target_Option = ["Home",8]

func _process(delta: float) -> void:
	if find_parent("Slide_UI").visible:
		if Input.is_action_just_pressed("dp_down") && Target_Option[0] != "Quit":
			var value = options.pop_front()
			options.push_back(value)
			var tween = get_tree().create_tween()
			tween.set_parallel(true).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
			tween.tween_property(get_node("VBoxContainer/"+value[0]), "label_settings:font_size", 24, .2)
			tween.tween_property(get_node("VBoxContainer/"+value[0]), "label_settings:font_color", Color("999999"), .1)
			tween.tween_property(get_parent().get_node("Screens/"+value[0]), "modulate", Color("FFFFFF",0), .1)
			Target_Option = options[0]
			tween.tween_property(get_node("VBoxContainer/"+Target_Option[0]), "label_settings:font_size", 32, .2)
			tween.tween_property(get_node("VBoxContainer/"+Target_Option[0]), "label_settings:font_color", Color("FFFFFF"), .1)
			tween.tween_property(get_node("VBoxContainer"), "position:y", Target_Option[1], .2)
			tween.tween_property(get_parent().get_node("Screens/"+Target_Option[0]), "modulate", Color("FFFFFF",1), .1)
		
		if Input.is_action_just_pressed("dp_up") && Target_Option[0] != "Home":
			var tween = get_tree().create_tween()
			tween.set_parallel(true).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
			tween.tween_property(get_node("VBoxContainer/"+Target_Option[0]), "label_settings:font_size", 24, .2)
			tween.tween_property(get_node("VBoxContainer/"+Target_Option[0]), "label_settings:font_color", Color("999999"), .1)
			tween.tween_property(get_parent().get_node("Screens/"+Target_Option[0]), "modulate", Color("FFFFFF",0), .1)
		
			var value = options.pop_back()
			options.push_front(value)
			tween.tween_property(get_node("VBoxContainer/"+value[0]), "label_settings:font_size", 32, .2)
			tween.tween_property(get_node("VBoxContainer/"+value[0]), "label_settings:font_color", Color("FFFFFF"), .1)
			tween.tween_property(get_parent().get_node("Screens/"+value[0]), "modulate", Color("FFFFFF",1), .1)
			Target_Option = options[0]
			tween.tween_property(get_node("VBoxContainer"), "position:y", Target_Option[1], .2)
