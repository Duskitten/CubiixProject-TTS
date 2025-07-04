extends Panel

var options = [
	["Home", 8],
	["Play", -26],
	["Login", -60],
	["Settings", -94],
	["Quit", -128]
]
var Target_Option = ["Home",8]

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("down") && Target_Option[0] != "Quit":
		var value = options.pop_front()
		options.push_back(value)
		var tween = get_tree().create_tween()
		tween.set_parallel(true)
		tween.tween_property(get_node("VBoxContainer/"+value[0]), "label_settings:font_size", 24, .2)
		tween.tween_property(get_node("VBoxContainer/"+value[0]), "label_settings:font_color", Color("999999"), .1)
		Target_Option = options[0]
		tween.tween_property(get_node("VBoxContainer/"+Target_Option[0]), "label_settings:font_size", 32, .2)
		tween.tween_property(get_node("VBoxContainer/"+Target_Option[0]), "label_settings:font_color", Color("FFFFFF"), .1)
		tween.tween_property(get_node("VBoxContainer"), "position:y", Target_Option[1], .2)
			
	if Input.is_action_just_pressed("up") && Target_Option[0] != "Home":
		var tween = get_tree().create_tween()
		tween.set_parallel(true).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
		tween.tween_property(get_node("VBoxContainer/"+Target_Option[0]), "label_settings:font_size", 24, .2)
		tween.tween_property(get_node("VBoxContainer/"+Target_Option[0]), "label_settings:font_color", Color("999999"), .1)
		var value = options.pop_back()
		options.push_front(value)
		tween.tween_property(get_node("VBoxContainer/"+value[0]), "label_settings:font_size", 32, .2)
		tween.tween_property(get_node("VBoxContainer/"+value[0]), "label_settings:font_color", Color("FFFFFF"), .1)
		Target_Option = options[0]
		tween.tween_property(get_node("VBoxContainer"), "position:y", Target_Option[1], .2)
