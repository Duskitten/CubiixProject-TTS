extends Node
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
var Scenes = {
	"Title":[
		"res://Assets/Scenes/Client/Maps/Titlescreen.tscn", 
		"TitleScreen",
		"...",
		"res://Assets/Textures/UI/Map_Screenshots/screenshot_showcase.png"],
	"Showcase":[
		"res://Assets/Scenes/Client/Maps/Showcase.tscn", 
		"Showcase", 
		"  Where New Things Are Tested!", 
		"res://Assets/Textures/UI/Map_Screenshots/screenshot_showcase.png"
		],
	"Hexstaria":[
		"res://Assets/Scenes/Shared/Maps/Hexstaria.tscn", 
		"Hexstaria", 
		"  Home of the Cubiix", 
		"res://Assets/Textures/UI/Map_Screenshots/screenshot_hexstaria_village.png",
		{"Spawn_Docks":[Vector3(77.373,0.668,173.588),Vector3(0,deg_to_rad(180),0)]}
		]
}

var InitThread:Thread
signal FinishedLoad
func runsetup(CoreNode) -> void:
	Core = CoreNode
	InitThread = Thread.new()
	InitThread.start(Init_ThreadRun)

func Init_ThreadRun():
	var assetcount = Scenes.keys().size()
	var currentAsset = 0
	for i in Scenes.keys():
		currentAsset += 1
		Scenes[i][0] = load(Scenes[i][0]).instantiate()
		Scenes[i][3] = load(Scenes[i][3])
		Core.call_deferred("Update_LogoText","Loading Maps: "+str(currentAsset)+"/"+str(assetcount))
		await Core.get_tree().process_frame

	call_deferred("Init_Finish")

func Init_Finish():
	InitThread.wait_to_finish()
	emit_signal("FinishedLoad")

func Swap_Scene(To_Scene:String,PassThrough:Dictionary = {}, SkipFade:bool = false, SpawnLocation:String = "") -> void:
	Core.Persistant_Core.Transitioner.get_node("TextureRect/RichTextLabel").text = "[center][font_size=40] [b]"+Scenes[To_Scene][1]+"[/b][/font_size]\n"+Scenes[To_Scene][2]
	Core.Persistant_Core.Transitioner.get_node("TextureRect").texture = Scenes[To_Scene][3]
	if !SkipFade:
		Core.Persistant_Core.Transitioner_AnimationPlayer.play_backwards("FadeOut")
		await Core.Persistant_Core.Transitioner_AnimationPlayer.animation_finished
	if get_tree().root.get_node("Main_Scene/Current_Scene").get_child_count() > 0:
		get_tree().root.get_node("Main_Scene/Current_Scene").remove_child(get_tree().root.get_node("Main_Scene/Current_Scene").get_child(0))
		
	var load_scene = Scenes[To_Scene][0]
	
	if SpawnLocation != "":
		Core.Persistant_Core.SpawnAt(Scenes[To_Scene][4][SpawnLocation][0], Scenes[To_Scene][4][SpawnLocation][1])
	else:
		Core.Persistant_Core.SpawnAt(Vector3.ZERO, Vector3.ZERO)
	
	get_tree().root.get_node("Main_Scene/Current_Scene").add_child(load_scene)
	await load_scene.FinishedLoad
	Core.Persistant_Core.Transitioner_AnimationPlayer.play("FadeOut")
