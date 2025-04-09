extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print("Trying new scene")
	get_node("/root/Main_Scene").free()
	var newscene = ("res://Assets/Scenes/Client/main_scene.tscn")
	get_parent().add_child(newscene.instantiate())
	self.free()
