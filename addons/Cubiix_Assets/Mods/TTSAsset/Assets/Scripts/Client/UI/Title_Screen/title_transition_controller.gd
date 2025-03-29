extends Control


var old_tween_a:Tween
var old_tween_b:Tween

var old_screen_a:String
var old_screen_b:String

func _ready() -> void:
	for i in get_children():
		i.hide()
	$Title.show()
	
	

func _on_texture_button_pressed(Screen_A: String, Reverse: bool, Screen_B: String) -> void:
	match Screen_A:
		"Social":
			OS.shell_open("https://cubiixproject.xyz/") 
		_:
			if old_screen_b == Screen_A:
				if old_tween_b != null:
					old_tween_b.kill()
			if old_screen_a == Screen_B:
				if old_tween_a != null:
					old_tween_a.kill()
			
			var old_tween_a = get_tree().create_tween()
			var old_tween_b = get_tree().create_tween()
			
			if Reverse:
				get_node(Screen_A).position = Vector2(454,0)
				get_node(Screen_A).show()
				old_tween_a.tween_property(get_node(Screen_A),"position", Vector2(0,0), .5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
				old_tween_b.tween_property(get_node(Screen_B),"position", Vector2(-454,0), .5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
			else:
				get_node(Screen_A).position = Vector2(-454,0)
				get_node(Screen_A).show()
				old_tween_a.tween_property(get_node(Screen_A),"position", Vector2(0,0), .5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
				old_tween_b.tween_property(get_node(Screen_B),"position", Vector2(454,0), .5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
			
			old_screen_a = Screen_A
			old_screen_b = Screen_B
