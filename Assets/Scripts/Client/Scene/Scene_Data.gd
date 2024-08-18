extends Node

var Scenes = {
	"Title":"res://Assets/Scenes/Client/Maps/Titlescreen.tscn",
	"Showcase":"res://Assets/Scenes/Client/Maps/Showcase.tscn",
	"Hexstaria":"res://Assets/Scenes/Client/Maps/Hexstaria.tscn"
}

func Swap_Scene(To_Scene:String,PassThrough:Dictionary = {}) -> void:
	if get_tree().root.get_node("Main_Scene/Current_Scene").get_child_count() > 0:
		get_tree().root.get_node("Main_Scene/Current_Scene").get_child(0).queue_free()
		
	var load_scene = load(Scenes[To_Scene]).instantiate()
	
	get_tree().root.get_node("Main_Scene/Current_Scene").add_child(load_scene)
