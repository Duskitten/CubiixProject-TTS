extends Panel

var options = {}

var options_reset = {
	"Base":[
		["Home", 8, "","Top"],
		["Play", -26,"",""],
		["Quit", -60,"","Bottom"]
	],
	"Home":[
		["Devlog", 8,"Base","Top"],
		["Social", -26,"Base",""],
		["Settings", -60,"Base","Bottom"],
	],
	"Play":[
		["Login", 8,"Base","Top"],
		["Character Editor", -26,"Base",""],
		["StarMapper", -60,"Base",""],
		["Inventory", -94,"Base","Bottom"],
	]
}

var TargetList = "Base"
@onready var Target_Container = $HBoxContainer/Base/VBoxContainer
var Target_Option = ["Home", 8, "","Top"]

func _ready() -> void:
	options = options_reset.duplicate(true)
	for i in $HBoxContainer.get_children():
		i.custom_minimum_size.x = i.get_node("VBoxContainer").size.x

func _process(delta: float) -> void:
	if find_parent("Slide_UI").visible:
		if Input.is_action_just_pressed("dp_down") && Target_Option[3] != "Bottom":
			var value = options[TargetList].pop_front()
			options[TargetList].push_back(value)
			var tween = get_tree().create_tween()
			tween.set_parallel(true).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
			
			if $HBoxContainer.find_child(Target_Option[0],false):
				var newpopup = $HBoxContainer.find_child(Target_Option[0],false)
				tween.tween_property(newpopup, "modulate", Color("FFFFFF",0), .2)
				newpopup.hide()
			tween.tween_property(Target_Container.get_node(value[0]), "label_settings:font_size", 24, .2)
			tween.tween_property(Target_Container.get_node(value[0]), "label_settings:font_color", Color("9a9a9a",0.5), .1)
			tween.tween_property(get_parent().get_node("Screens/"+value[0]), "modulate", Color("FFFFFF",0), .1)
			Target_Option = options[TargetList][0]
			tween.tween_property(Target_Container.get_node(Target_Option[0]), "label_settings:font_size", 32, .2)
			tween.tween_property(Target_Container.get_node(Target_Option[0]), "label_settings:font_color", Color("FFFFFF"), .1)
			tween.tween_property(Target_Container, "position:y", Target_Option[1], .2)
			tween.tween_property(get_parent().get_node("Screens/"+Target_Option[0]), "modulate", Color("FFFFFF",1), .1)
			print(Target_Option)
			if $HBoxContainer.find_child(Target_Option[0],false):
				var newpopup = $HBoxContainer.find_child(Target_Option[0],false)
				newpopup.show()
				tween.tween_property(newpopup, "modulate", Color("FFFFFF",1), .2)
		
		if Input.is_action_just_pressed("dp_up") && Target_Option[3] != "Top":
			var tween = get_tree().create_tween()
			tween.set_parallel(true).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
			tween.tween_property(Target_Container.get_node(Target_Option[0]), "label_settings:font_size", 24, .2)
			tween.tween_property(Target_Container.get_node(Target_Option[0]), "label_settings:font_color", Color("9a9a9a",0.5), .1)
			tween.tween_property(get_parent().get_node("Screens/"+Target_Option[0]), "modulate", Color("FFFFFF",0), .1)
			if $HBoxContainer.find_child(Target_Option[0],false):
				var newpopup = $HBoxContainer.find_child(Target_Option[0],false)
				tween.tween_property(newpopup, "modulate", Color("FFFFFF",0), .2)
				newpopup.hide()
				
			var value = options[TargetList].pop_back()
			options[TargetList].push_front(value)
			
			
			tween.tween_property(Target_Container.get_node(value[0]), "label_settings:font_size", 32, .2)
			tween.tween_property(Target_Container.get_node(value[0]), "label_settings:font_color", Color("FFFFFF"), .1)
			tween.tween_property(get_parent().get_node("Screens/"+value[0]), "modulate", Color("FFFFFF",1), .1)
			Target_Option = options[TargetList][0]
			if $HBoxContainer.find_child(Target_Option[0],false):
				var newpopup = $HBoxContainer.find_child(Target_Option[0],false)
				newpopup.show()
				tween.tween_property(newpopup, "modulate", Color("FFFFFF",1), .2)
			tween.tween_property(Target_Container, "position:y", Target_Option[1], .2)
		if Input.is_action_just_pressed("dp_right"):
			if options.has(Target_Option[0]):
				var tween = get_tree().create_tween()
				tween.set_parallel(true).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
				tween.tween_property($HBoxContainer, "position:x", -Target_Container.size.x + 15, .2)
				
				options[Target_Option[0]] = options_reset.duplicate(true)[Target_Option[0]]
				TargetList = Target_Option[0]
				Target_Container = get_node("HBoxContainer/"+Target_Option[0]+"/VBoxContainer")
				
				Target_Option = options[TargetList][0]
				
				tween.tween_property(Target_Container.get_node(Target_Option[0]), "label_settings:font_size", 32, .2)
				tween.tween_property(Target_Container.get_node(Target_Option[0]), "label_settings:font_color", Color("FFFFFF"), .1)
				
		if Input.is_action_just_pressed("dp_left"):
			if options.has(Target_Option[2]):
				var tween = get_tree().create_tween()
				tween.set_parallel(true).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
				tween.tween_property(Target_Container, "position:y", 8, .2)
				tween.tween_property($HBoxContainer, "position:x", 15, .2)
				tween.tween_property(Target_Container.get_node(Target_Option[0]), "label_settings:font_size", 24, .2)
				tween.tween_property(Target_Container.get_node(Target_Option[0]), "label_settings:font_color", Color("9a9a9a",0.5), .1)
				print(Target_Option)
				Target_Container = get_node("HBoxContainer/"+Target_Option[2]+"/VBoxContainer")
				TargetList = Target_Option[2]
				Target_Option = options[TargetList][0]
				
				
			
				
				
