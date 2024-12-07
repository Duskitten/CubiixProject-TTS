extends Node
var version = "V_B.01.00"

signal core_loaded

var SceneData
var Globals
var AssetData
var Dialogue_Handler
var Persistant_Core

var Client
var Server

func _ready():
	print(version)
	if OS.has_feature("client"): #|| OS.is_debug_build():
		Update_LogoText("Booting MindVirus Engine...")
		await get_tree().create_timer(1).timeout
		Update_LogoText("Finding Client...")
		await get_tree().create_timer(1).timeout
		Update_LogoText("Initiating Asset Load...")
		await get_tree().create_timer(1).timeout
		SceneData = load("res://Assets/Scripts/Client/Scene/Scene_Data.gd").new()
		SceneData.runsetup(self)
		await SceneData.FinishedLoad
		Globals = load("res://Assets/Scripts/Shared/Globals.gd").new()
		AssetData = load("res://Assets/Scripts/Client/Character/Asset_Data.gd").new()
		AssetData.runsetup(self)
		await AssetData.FinishedLoad
		Client = load("res://Assets/Scripts/Client/Networking/Network_Client.gd").new()
		Dialogue_Handler = load("res://Assets/Scripts/Client/UI/DialogueBank.gd").new()
		Persistant_Core = load("res://Assets/Scenes/Client/Persistant_Core.tscn").instantiate()
		add_child(SceneData)
		add_child(Globals)
		add_child(AssetData)
		add_child(Client)
		add_child(Dialogue_Handler)
		
		get_parent().call_deferred("add_child", Persistant_Core)
		await Persistant_Core.ready
		
		Update_LogoText("Load O.K. ...")
		await get_tree().create_timer(1).timeout
		Update_LogoText("Good Luck Have Fun! :3")
		await get_tree().create_timer(1).timeout
		get_node("../CanvasLayer/Loading").hide()
		print("Haoi")
		#SceneData.call_deferred("Swap_Scene","Showcase",{},true,"")
		SceneData.call_deferred("Swap_Scene","Hexstaria",{},true,"Spawn_Docks")
		Persistant_Core.Hexii_UI_Transition("Enter","Hexii_Ui_Tablet_TitleScreen_Anim","Exit","", false)
		Persistant_Core.Hexii_UI_Transition("Enter","Hexii_Ui_ChatScreen_Anim","Exit","Hexii_Ui_NullScreen_Anim", true)
		
	if OS.has_feature("server"):
		Globals = load("res://Assets/Scripts/Shared/Globals.gd").new()
		add_child(Globals)
		await get_tree().create_timer(1).timeout
		Server = load("res://Assets/Scripts/Server/Network_Server.gd").new()
		add_child(Server)
		
		
func Update_LogoText(text:String) -> void:
	get_node("../CanvasLayer/Loading/TextureRect/Label").text = text
	#Create an HTTP request node and connect its completion signal.
	#var http_request = HTTPRequest.new()
	#add_child(http_request)
	##http_request.request_completed.connect(self._http_request_completed)
#
	## Perform the HTTP request. The URL below returns a PNG image as of writing.
	#var error = http_request.request("https://cubiixproject.xyz/game/version.json")
	#if error != OK:
		#push_error("An error occurred in the HTTP request.")
		#
	#await get_tree().create_timer(1).timeout

	#var success = ProjectSettings.load_resource_pack(OS.get_executable_path().get_base_dir()+"/updoot_test.pck",true)
	#print(success)
	#if success:
		#Globals.KillThreads = true
		#get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
		#await get_tree().create_timer(0.1).timeout
		#get_parent().get_parent().add_child(load("res://Assets/Scenes/Client/transfer_scene.tscn").instantiate())
# Called when the HTTP request is completed.
func _http_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	pass
