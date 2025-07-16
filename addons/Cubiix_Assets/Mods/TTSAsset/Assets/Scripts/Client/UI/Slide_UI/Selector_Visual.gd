extends Panel

var options = {}
var HasControl = true
var options_reset = {
	"Base":[
		["Home", 0, "","Top"],
		["Play", 0,"",""],
		["Settings", 0,"",""],
		["Quit", 0,"Base","Bottom"]
	],
	"Home":[
		["Devlog", 0,"Base","Top"],
		["Discord", 0,"Base",""],
		["Updates", 0,"Base","Bottom"],
	],
	"Play":[
		["Login", 0,"Base","Top"],
		["Character Editor", 0,"Base",""],
		["StarMapper", 0,"Base",""],
		["Inventory", 0,"Base",""],
		["Inbox", 0,"Base","Bottom"],
	],
	"Settings":[
		["Audio", 0,"Base","Top"],
		["Visuals", 0,"Base",""],
		["Input", 0,"Base",""],
		["Accessibility", 0,"Base",""],
		["Theme", 0,"Base",""],
		["Other", 0,"Base","Bottom"],
	]
}

var TargetList = "Base"
@onready var Target_Container = $HBoxContainer/Base/VBoxContainer
var Target_Option = ["Home", 8, "","Top"]
var InMenu = false

func _ready() -> void:
	
	
	for i in options_reset.keys():
		for x in options_reset[i].size():
			var pos = (8 + (x * -34))
			options_reset[i][x][1] = pos
			
	options = options_reset.duplicate(true)
	for i in $HBoxContainer.get_children():
		i.custom_minimum_size.x = i.get_node("VBoxContainer").size.x + 20
	for i in $"../Screens".get_children():
		i.modulate = Color("FFFFFF",0)
		i.hide()
	$"../Screens/Home".modulate = Color("FFFFFF",1)
	$"../Screens/Home".show()

func _process(delta: float) -> void:
	if find_parent("Slide_UI").visible && HasControl:
		if Input.is_action_just_pressed("dp_down") && Target_Option[3] != "Bottom":
			var value = options[TargetList].pop_front()
			options[TargetList].push_back(value)
			var tween = get_tree().create_tween()
			tween.set_parallel(true).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO)
			
			if $HBoxContainer.find_child(Target_Option[0],false) != null:
				var newpopup = $HBoxContainer.find_child(Target_Option[0],false)
				tween.tween_property(newpopup, "modulate", Color("FFFFFF",0), .2)
				newpopup.hide()
			if $"../Screens".find_child(Target_Option[0],false) != null:
				var newpopup =  $"../Screens".find_child(Target_Option[0],false)
				tween.tween_property(newpopup, "modulate", Color("FFFFFF",0), .2)
				newpopup.hide()
			tween.tween_property(Target_Container.get_node(value[0]), "label_settings:font_size", 24, .2)
			tween.tween_property(Target_Container.get_node(value[0]), "label_settings:font_color", Color("9a9a9a",0.5), .1)
			#tween.tween_property(get_parent().get_node("Screens/"+value[0]), "modulate", Color("FFFFFF",0), .1)
			Target_Option = options[TargetList][0]
			tween.tween_property(Target_Container.get_node(Target_Option[0]), "label_settings:font_size", 32, .2)
			tween.tween_property(Target_Container.get_node(Target_Option[0]), "label_settings:font_color", Color("FFFFFF"), .1)
			print(Target_Option)
			tween.tween_property(Target_Container, "position:y", Target_Option[1], .2)
			#tween.tween_property(get_parent().get_node("Screens/"+Target_Option[0]), "modulate", Color("FFFFFF",1), .1)
			#print(Target_Option)
			#print("oofer!")
			if $HBoxContainer.find_child(Target_Option[0],false) != null:
				var newpopup = $HBoxContainer.find_child(Target_Option[0],false)
				newpopup.show()
				tween.tween_property(newpopup, "modulate", Color("FFFFFF",1), .2)
			if $"../Screens".find_child(Target_Option[0],false) != null:
				var newpopup =  $"../Screens".find_child(Target_Option[0],false)
				newpopup.show()
				tween.tween_property(newpopup, "modulate", Color("FFFFFF",1), .2)
		
		if Input.is_action_just_pressed("dp_up") && Target_Option[3] != "Top":
			var tween = get_tree().create_tween()
			tween.set_parallel(true).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO)
			tween.tween_property(Target_Container.get_node(Target_Option[0]), "label_settings:font_size", 24, .2)
			tween.tween_property(Target_Container.get_node(Target_Option[0]), "label_settings:font_color", Color("9a9a9a",0.5), .1)
			#tween.tween_property(get_parent().get_node("Screens/"+Target_Option[0]), "modulate", Color("FFFFFF",0), .1)
			if $HBoxContainer.find_child(Target_Option[0],false) != null:
				var newpopup = $HBoxContainer.find_child(Target_Option[0],false)
				tween.tween_property(newpopup, "modulate", Color("FFFFFF",0), .2)
				newpopup.hide()
			if $"../Screens".find_child(Target_Option[0],false) != null:
					var newpopup =  $"../Screens".find_child(Target_Option[0],false)
					tween.tween_property(newpopup, "modulate", Color("FFFFFF",0), .2)
					newpopup.hide()
				
			var value = options[TargetList].pop_back()
			options[TargetList].push_front(value)
			tween.tween_property(Target_Container.get_node(value[0]), "label_settings:font_size", 32, .2)
			tween.tween_property(Target_Container.get_node(value[0]), "label_settings:font_color", Color("FFFFFF"), .1)
			#tween.tween_property(get_parent().get_node("Screens/"+value[0]), "modulate", Color("FFFFFF",1), .1)
			Target_Option = options[TargetList][0]
			if $HBoxContainer.find_child(Target_Option[0],false) != null:
				var newpopup = $HBoxContainer.find_child(Target_Option[0],false)
				newpopup.show()
				tween.tween_property(newpopup, "modulate", Color("FFFFFF",1), .2)
			if $"../Screens".find_child(Target_Option[0],false) != null:
					var newpopup =  $"../Screens".find_child(Target_Option[0],false)
					newpopup.show()
					tween.tween_property(newpopup, "modulate", Color("FFFFFF",1), .2)
			
			tween.tween_property(Target_Container, "position:y", Target_Option[1], .2)
		if Input.is_action_just_pressed("dp_right"):
			if Target_Option[2] == "Base":
				match Target_Option[0]:
					"Home":
						pass
					"Discord":
						OS.shell_open("https://discord.gg/UgEq5VxNQ4")
					"Quit":
						print("Quit!")
						get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
						get_tree().quit()
					_:
						var newpopup = $"../Screens".find_child(Target_Option[0],false)
						if newpopup != null:
							var tween = get_tree().create_tween()
							tween.set_parallel(true).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO)
							tween.tween_property(Target_Container.get_node(Target_Option[0]), "label_settings:font_size", 96, .3)
							for i in Target_Container.get_children():
								if i != Target_Container.get_node(Target_Option[0]):
									tween.tween_property(i, "modulate", Color("FFFFFF",0), .3)
							
							await get_tree().process_frame
							newpopup.HasControl = true
							HasControl = false
							InMenu = true
			
			elif options.has(Target_Option[0]):
				var tween = get_tree().create_tween()
				tween.set_parallel(true).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO)
		
				tween.tween_property($HBoxContainer, "position:x", -Target_Container.size.x - 5, .2)
				if $"../Screens".find_child(Target_Option[0],false) != null:
					var newpopup =  $"../Screens".find_child(Target_Option[0],false)
					tween.tween_property(newpopup, "modulate", Color("FFFFFF",0), .2)
					newpopup.hide()
				options[Target_Option[0]] = options_reset.duplicate(true)[Target_Option[0]]
				TargetList = Target_Option[0]
				Target_Container = get_node("HBoxContainer/"+Target_Option[0]+"/VBoxContainer")
				
				Target_Option = options[TargetList][0]
				#print(Target_Option)
				if $"../Screens".find_child(Target_Option[0],false) != null:
					var newpopup =  $"../Screens".find_child(Target_Option[0],false)
					newpopup.show()
					tween.tween_property(newpopup, "modulate", Color("FFFFFF",1), .2)
				tween.tween_property(Target_Container.get_node(Target_Option[0]), "label_settings:font_size", 32, .2)
				tween.tween_property(Target_Container.get_node(Target_Option[0]), "label_settings:font_color", Color("FFFFFF"), .1)
		
		if Input.is_action_just_pressed("dp_left"):
			if options.has(Target_Option[2]):
				var tween = get_tree().create_tween()
				tween.set_parallel(true).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO)
				if $"../Screens".find_child(Target_Option[0],false) != null:
					var newpopup =  $"../Screens".find_child(Target_Option[0],false)
					tween.tween_property(newpopup, "modulate", Color("FFFFFF",0), .2)
					newpopup.hide()
				
				tween.tween_property(Target_Container, "position:y", 8, .2)
				tween.tween_property($HBoxContainer, "position:x", 15, .2)
				tween.tween_property(Target_Container.get_node(Target_Option[0]), "label_settings:font_size", 24, .2)
				tween.tween_property(Target_Container.get_node(Target_Option[0]), "label_settings:font_color", Color("9a9a9a",0.5), .1)
			#	print(Target_Option)
				Target_Container = get_node("HBoxContainer/"+Target_Option[2]+"/VBoxContainer")
				TargetList = Target_Option[2]
				Target_Option = options[TargetList][0]
				if $"../Screens".find_child(Target_Option[0],false) != null:
					var newpopup =  $"../Screens".find_child(Target_Option[0],false)
					newpopup.show()
					tween.tween_property(newpopup, "modulate", Color("FFFFFF",1), .2)
	
				
	if Input.is_action_just_pressed("dp_back") && InMenu:
		var newpopup = $"../Screens".find_child(Target_Option[0],false)
		if newpopup != null:
			newpopup.HasControl = false
			HasControl = true
			InMenu = false
			var tween = get_tree().create_tween()
			tween.set_parallel(true).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO)
			tween.tween_property(Target_Container.get_node(Target_Option[0]), "label_settings:font_size", 32, .3)
			for i in Target_Container.get_children():
				if i != Target_Container.get_node(Target_Option[0]):
					tween.tween_property(i, "modulate", Color("FFFFFF",1), .3)
