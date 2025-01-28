extends VBoxContainer

var type = ""

func _ready() -> void:
	type = get_parent().get_parent().name
	for i in get_children():
		i.get_node("TextureButton").mouse_entered.connect(hovered.bind(i.get_node("TextureButton/TextureRect/TextureRect2")))
		i.get_node("TextureButton").mouse_exited.connect(unhovered.bind(i.get_node("TextureButton/TextureRect/TextureRect2")))

func hovered(node:Node) -> void:
	var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO).set_parallel(true)
	
	tween.tween_property(node, "position", Vector2(12,90), .5)

	tween.play()

func unhovered(node:Node) -> void:
	var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SPRING).set_parallel(true)
	
	tween.tween_property(node, "position", Vector2(12,124), .5)

	tween.play()
