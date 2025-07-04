extends Control

var base_resolution = Vector2(372,354)
var texture_rect_base_resolution = Vector2(392,406)

func _ready() -> void:
	resized.connect(change_child.bind())
	
func change_child() -> void:
	var res = $Panel/TextureRect.size/texture_rect_base_resolution
	print(res)
	#$Panel/TextureRect/Panel.size = $Panel/TextureRect.size
	if $Panel/TextureRect.size.x < $Panel/TextureRect.size.y:
		$Panel/TextureRect/Panel.scale = Vector2(res.x, res.x)
		#$Panel/TextureRect/Panel.size = base_resolution * res.x
		#$Panel/TextureRect/Panel.size.x = $Panel/TextureRect.size.x - 15
		#$Panel/TextureRect/Panel.size.y = $Panel/TextureRect.size.x - 15
		print("A is true")
		$Panel/TextureRect/Panel.position = (($Panel/TextureRect.size / 2) + (-$Panel/TextureRect/Panel.size / 2)) + (Vector2(0,-12) * res.x)
	else:
		$Panel/TextureRect/Panel.scale = Vector2(res.y, res.y)
		#$Panel/TextureRect/Panel.size = base_resolution * res.y
		#$Panel/TextureRect/Panel.size.y = $Panel/TextureRect.size.y - 45
		#$Panel/TextureRect/Panel.size.x = $Panel/TextureRect.size.y - 45
		print("B is true")
		$Panel/TextureRect/Panel.position = ($Panel/TextureRect.size / 2) + (-$Panel/TextureRect/Panel.size / 2) + (Vector2(0,-12) * res.y)
