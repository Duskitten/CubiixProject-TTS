extends Control


func _on_button_pressed(extra_arg_0: String) -> void:
	get_node(extra_arg_0).visible = !get_node(extra_arg_0).visible
