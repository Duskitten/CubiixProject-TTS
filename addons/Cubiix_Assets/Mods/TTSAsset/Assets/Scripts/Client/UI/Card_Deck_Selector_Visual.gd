extends VBoxContainer

var rootnode:Node

func setup() -> void:
	if rootnode == null:
		rootnode = find_parent("DragArea")
	
	
	for i in get_children():
		i.get_node("TextureButton").mouse_entered.connect(hovered.bind(i.get_node("TextureButton/TextureRect")))
		i.get_node("TextureButton").mouse_exited.connect(unhovered.bind(i.get_node("TextureButton/TextureRect")))
		i.get_node("TextureButton").mouse_entered.connect(rootnode.disable_drag.bind())
		i.get_node("TextureButton").mouse_exited.connect(rootnode.enable_drag.bind())
		
		
func hovered(node:Node) -> void:
		var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO).set_parallel(true)
		tween.tween_property(node, "position", Vector2(-50,-100), .5)
		tween.tween_property(node, "rotation", deg_to_rad(-30), .5)
		tween.play()

func unhovered(node:Node) -> void:
		var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO).set_parallel(true)
		
		tween.tween_property(node, "position", Vector2(0,0), .5)
		tween.tween_property(node, "rotation", deg_to_rad(0), .5)

		tween.play()
