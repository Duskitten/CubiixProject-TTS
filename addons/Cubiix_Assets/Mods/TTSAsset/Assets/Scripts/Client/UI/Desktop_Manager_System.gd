extends Control

var lastmenu:String = ""

func _on_transition_button_pressed(extra_arg_0: String) -> void:
	if lastmenu != "":
		var newnode = get_node_or_null(lastmenu)
		if newnode != null:
			if newnode.get_meta("Open"):
				newnode.set_meta("Open",false)
				var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_parallel(true).set_trans(Tween.TRANS_QUAD)
				tween.tween_property(newnode, "scale", Vector2.ZERO, .2)
				tween.tween_property(newnode, "position", newnode.get_meta("Close_Pos"), .2)
			else:
				if lastmenu == extra_arg_0:
					newnode.set_meta("Open",true)
					var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_parallel(true).set_trans(Tween.TRANS_QUAD)
					tween.tween_property(newnode, "scale", Vector2(1,1), .2)
					tween.tween_property(newnode, "position", Vector2.ZERO, .2)

	if lastmenu != extra_arg_0:
		var newnode = get_node_or_null(extra_arg_0)
		if newnode != null:
			newnode.set_meta("Open",true)
			var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_parallel(true).set_trans(Tween.TRANS_QUAD)
			tween.tween_property(newnode, "scale", Vector2(1,1), .2)
			tween.tween_property(newnode, "position", Vector2.ZERO, .2)
		
	
	lastmenu = extra_arg_0
