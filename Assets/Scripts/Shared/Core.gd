extends Node
var version = "V_B.01.00"

signal core_loaded

var SceneData
var Globals
var AssetData

var Client
var Server

func _ready():
	print(version)
	if OS.has_feature("client") || OS.is_debug_build():
		SceneData = load("res://Assets/Scripts/Client/Scene/Scene_Data.gd").new()
		Globals = load("res://Assets/Scripts/Shared/Globals.gd").new()
		AssetData = load("res://Assets/Scripts/Client/Character/Asset_Data.gd").new()
		Client = load("res://Assets/Scripts/Client/Networking/Network_Client.gd").new()
		add_child(SceneData)
		add_child(Globals)
		add_child(AssetData)
		add_child(Client)
		SceneData.Swap_Scene("Hexstaria")
		
	if OS.has_feature("server"):
		Globals = load("res://Assets/Scripts/Shared/Globals.gd").new()
		add_child(Globals)
		Server = load("res://Assets/Scripts/Server/Network_Server.gd").new()
		add_child(Server)
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