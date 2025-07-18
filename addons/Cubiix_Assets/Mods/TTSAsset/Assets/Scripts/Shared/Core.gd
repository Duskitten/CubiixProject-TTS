extends Node

signal core_loaded

var SceneData
var Globals
var AssetData
var Dialogue_Handler
var Persistant_Core
var UI_Scaler
var Character_Gen
var Console
var ServerList_Updater
var OfflineMenu
var TransitionController
var LoginData

var Client
var Server

func _ready():
	Update_LogoText("Booting MindVirus Engine...")
	await get_tree().create_timer(1).timeout
	Update_LogoText("Finding Client...")
	await get_tree().create_timer(1).timeout
	Update_LogoText("Initiating Asset Load...")
	await get_tree().create_timer(1).timeout
	Update_LogoText("Loading Asset Data...")
	AssetData = load("res://addons/Cubiix_Assets/Scripts/Asset_Manager.gd").new()
	AssetData.name = "AssetData"
	
	if OS.has_feature("client"): #|| OS.is_debug_build():
		AssetData.runsetup()
		await AssetData.FinishedLoad
		SceneData = load("res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Scripts/Shared/Scene_Loader.gd").new()
		Globals = load("res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Scripts/Shared/Globals.gd").new()
		Client = load("res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Scripts/Client/Networking/New_Networking_Client.gd").new()
		Dialogue_Handler = load("res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Scripts/Client/UI/DialogueBank.gd").new()
		Persistant_Core = load("res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Objects/Client/Persistant_Core.tscn").instantiate()
		UI_Scaler = load("res://scripts/adjust.gd").new()
		add_child(AssetData)
		add_child(SceneData)
		add_child(Globals)
		add_child(Client)
		add_child(UI_Scaler)
		add_child(Dialogue_Handler)
		get_parent().call_deferred("add_child", Persistant_Core)
		await Persistant_Core.ready
		
		Update_LogoText("Load O.K. ...")
		await get_tree().create_timer(1).timeout
		Update_LogoText("Good Luck Have Fun! :3")
		await get_tree().create_timer(1).timeout
		get_node("../CanvasLayer/Loading").hide()
		#print("Haoi")
		#SceneData.call_deferred("Swap_Scene","Showcase",{},true,"")
		SceneData.call_deferred("load_scene","TTSAssets/Hexstaria_V2",{},true,"Docks")
		#SceneData.call_deferred("load_scene","TTSAssets/Player_TestGround",{},true,"Docks")
		#Persistant_Core.Hexii_UI_Transition("Enter","Hexii_Ui_Tablet_TitleScreen_Anim","Exit","", false)
		#Persistant_Core.Hexii_UI_Transition("Enter","Hexii_Ui_ChatScreen_Anim","Exit","Hexii_Ui_NullScreen_Anim", true)
		
	if OS.has_feature("server"):
		AssetData.runsetup(true)
		AssetData.name = "AssetData"
		await AssetData.FinishedLoad
		
		Globals = load("res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Scripts/Shared/Globals.gd").new()
		add_child(AssetData)
		add_child(Globals)
		await get_tree().create_timer(1).timeout
		Server = load("res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Scripts/Server/Networking/New_Networking_Server.gd").new()
		add_child(Server)
		
		#print(Globals.GameVersion)

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

func enable_singleplayer():
	Persistant_Core.show_play_screen()
