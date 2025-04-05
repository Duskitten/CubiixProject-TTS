extends Control
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
var lastmenu:String = ""
@onready var Character_Template = $"In-Game_Controller/Player/TextureRect/Center/Polygon2D/SubViewportContainer/SubViewport/Character_Editor/Rotator/CubiixModel/Hub"

func _ready() -> void:
	Core.OfflineMenu = self

func setup_online():
	$HBoxContainer/OfflineBack.hide()
	$HBoxContainer/OnlineBack.show()

func _on_transition_button_pressed(extra_arg_0: String) -> void:
	if lastmenu != "":
		var newnode = get_node_or_null(lastmenu)
		if newnode != null:
			if newnode.get_meta("Open"):
				newnode.set_meta("Open",false)
				var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_parallel(true).set_trans(Tween.TRANS_QUAD)
				tween.tween_property(newnode, "scale", Vector2.ZERO, .2)
				tween.tween_property(newnode, "position", newnode.get_meta("Close_Pos"), .2)
				tween.tween_callback(func():newnode.hide()).set_delay(.2)
			else:
				if lastmenu == extra_arg_0:
					newnode.set_meta("Open",true)
					newnode.show()
					var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_parallel(true).set_trans(Tween.TRANS_QUAD)
					tween.tween_property(newnode, "scale", Vector2(1,1), .2)
					tween.tween_property(newnode, "position", Vector2.ZERO, .2)

	if lastmenu != extra_arg_0:
		var newnode = get_node_or_null(extra_arg_0)
		if newnode != null:
			newnode.show()
			newnode.set_meta("Open",true)
			var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_parallel(true).set_trans(Tween.TRANS_QUAD)
			tween.tween_property(newnode, "scale", Vector2(1,1), .2)
			tween.tween_property(newnode, "position", Vector2.ZERO, .2)
			
		
	
	lastmenu = extra_arg_0

func _on_online_back_pressed() -> void:
	$HBoxContainer/OfflineBack.show()
	$HBoxContainer/OnlineBack.hide()
	Core.Client.disable_connect = true
	await Core.Client.ClientDisconnected
	Core.Client.disable_connect = false
	Core.ServerList_Updater.LoginController.get_node("Joining").hide()
	Core.ServerList_Updater.LoginController.get_node("ServerList").show()
