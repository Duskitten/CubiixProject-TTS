extends Node
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
var Scenes = {
	"Title":"res://Assets/Scenes/Client/Maps/Titlescreen.tscn",
	"Showcase":"res://Assets/Scenes/Client/Maps/Showcase.tscn",
	"Hexstaria":"res://Assets/Scenes/Client/Maps/Hexstaria.tscn"
}

func Swap_Scene(To_Scene:String,PassThrough:Dictionary = {}, SkipFade:bool = false) -> void:
	if !SkipFade:
		Core.Persistant_Core.Transitioner_AnimationPlayer.play_backwards("FadeOut")
		await Core.Persistant_Core.Transitioner_AnimationPlayer.animation_finished
	if get_tree().root.get_node("Main_Scene/Current_Scene").get_child_count() > 0:
		get_tree().root.get_node("Main_Scene/Current_Scene").get_child(0).queue_free()
		
	var load_scene = load(Scenes[To_Scene]).instantiate()
	
	get_tree().root.get_node("Main_Scene/Current_Scene").add_child(load_scene)
	await get_tree().create_timer(2).timeout 
	Core.Persistant_Core.Transitioner_AnimationPlayer.play("FadeOut")
