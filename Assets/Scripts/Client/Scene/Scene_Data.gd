extends Node
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
var Scenes = {
	"Title":["res://Assets/Scenes/Client/Maps/Titlescreen.tscn", "TitleScreen","..."],
	"Showcase":["res://Assets/Scenes/Client/Maps/Showcase.tscn", "Showcase", " Where New Things Are Tested!", "res://Assets/Textures/UI/Map_Screenshots/screenshot_showcase.png"],
	"Hexstaria":["res://Assets/Scenes/Client/Maps/Hexstaria.tscn", "Hexstaria", " Home of the Cubiix", "res://Assets/Textures/UI/Map_Screenshots/screenshot_hexstaria_village.png"]
}


func Swap_Scene(To_Scene:String,PassThrough:Dictionary = {}, SkipFade:bool = false) -> void:
	Core.Persistant_Core.Transitioner.get_node("TextureRect/RichTextLabel").text = "[center][font_size=40] [b]"+Scenes[To_Scene][1]+"[/b][/font_size]\n"+Scenes[To_Scene][2]
	Core.Persistant_Core.Transitioner.get_node("TextureRect").texture = load(Scenes[To_Scene][3])
	if !SkipFade:
		Core.Persistant_Core.Transitioner_AnimationPlayer.play_backwards("FadeOut")
		await Core.Persistant_Core.Transitioner_AnimationPlayer.animation_finished
	if get_tree().root.get_node("Main_Scene/Current_Scene").get_child_count() > 0:
		get_tree().root.get_node("Main_Scene/Current_Scene").get_child(0).queue_free()
		
	var load_scene = load(Scenes[To_Scene][0]).instantiate()
	
	get_tree().root.get_node("Main_Scene/Current_Scene").add_child(load_scene)
	await get_tree().create_timer(2).timeout 
	Core.Persistant_Core.Transitioner_AnimationPlayer.play("FadeOut")
