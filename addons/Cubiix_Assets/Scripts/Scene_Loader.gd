extends Node
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

func load_scene(SceneID:String,PassThrough:Dictionary={}, SkipFade:bool = false, SpawnLocation:String = "") -> void:
	var SceneData = Core.AssetData.find_map(SceneID)
	print(SceneData)
	if SceneData.has("Preview_Image") && SceneData.has("Name") && SceneData.has("Description"):
		Core.Persistant_Core.Transitioner.get_node("TextureRect/RichTextLabel").text = "[center][font_size=40] [b]"+SceneData["Name"]+"[/b][/font_size]\n"+SceneData["Description"]
		Core.Persistant_Core.Transitioner.get_node("TextureRect").texture = load(SceneData["Preview_Image"])
		
		if !SkipFade:
			Core.Persistant_Core.Transitioner_AnimationPlayer.play_backwards("FadeOut")
			await Core.Persistant_Core.Transitioner_AnimationPlayer.animation_finished
		if get_tree().root.get_node("Main_Scene/Current_Scene").get_child_count() > 0:
			get_tree().root.get_node("Main_Scene/Current_Scene").remove_child(get_tree().root.get_node("Main_Scene/Current_Scene").get_child(0))
			
		var load_scene = load(SceneData["Server_Path"]).instantiate()
		print(SceneData["Client_Path"])
		load_scene.client_string = SceneData["Client_Path"]
		
		
		get_tree().root.get_node("Main_Scene/Current_Scene").add_child(load_scene)
		load_scene.setup()
		await load_scene.FinishedLoad
		if SpawnLocation != "" && SceneData["SpawnLocations"].has(SpawnLocation):
			Core.Persistant_Core.SpawnAt(SceneData["SpawnLocations"][SpawnLocation][0], SceneData["SpawnLocations"][SpawnLocation][1])
		else:
			Core.Persistant_Core.SpawnAt(Vector3.ZERO, Vector3.ZERO)
		Core.Persistant_Core.Transitioner_AnimationPlayer.play("FadeOut")
		
	else:
		print("Error: Invalid Map Data")
