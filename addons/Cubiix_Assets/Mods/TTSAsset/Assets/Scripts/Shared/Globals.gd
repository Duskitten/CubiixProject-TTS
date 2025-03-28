extends Node
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

var GameVersion = "V_B.01.01"

signal Setting_Changed

var LocalUser = {
	"URL":"",
	"UserSecretCode":"",
	"Username":"",
}

var save_template = {
	"LastChar_Save":"",
	"Audio":{
		"Master":0,
		"Music":0,
		"SFX":0,
		"Notification":0,
		"Ping":0,
	},
	"Visuals":{
		"Shadow_Depth":0,
		"Anti-Aliasing":0,
		"Bloom":false,
		"FOV":75
	}
}

var server_template = {
	"Port":5599,
	"MaxPlayers":40,
	"ServerName":"TestServer",
	"ServerColor":"#999634"
	}

var Data:Dictionary = {}

var KillThreads:bool = false
var UI_Hovered:Array = []
var All_UI:Array = []
var Sorted_UI:Node = null

var DisablePlayerInput:bool = false
var Physics_Time:float

func _physics_process(delta: float) -> void:
	Physics_Time += delta

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if OS.has_feature("client"):
		var Json = JSON.new()
		var IsFile = FileAccess.file_exists(OS.get_executable_path().get_base_dir()+"/client.json")
		print(IsFile)
		if !IsFile:
			var NewFile = FileAccess.open(OS.get_executable_path().get_base_dir()+"/client.json",FileAccess.WRITE)
			NewFile.store_string(JSON.stringify(save_template))
			NewFile.close()

		var JsonFile = FileAccess.get_file_as_string(OS.get_executable_path().get_base_dir()+"/client.json")
		Json.parse(JsonFile)
		Data = Json.data
		
		###For continuity/Updating purposes
		data_failsafe_check(save_template)

		_setup_audio(Data["Audio"])
		

	if OS.has_feature("server"):
		var Json = JSON.new()
		#print(OS.get_executable_path().get_base_dir()+"/server.json")
		var IsFile = FileAccess.file_exists(OS.get_executable_path().get_base_dir()+"/server.json")
		if !IsFile:
			var NewFile = FileAccess.open(OS.get_executable_path().get_base_dir()+"/server.json",FileAccess.WRITE)
			NewFile.store_string(JSON.stringify(server_template))
			NewFile.close()

		var JsonFile = FileAccess.get_file_as_string(OS.get_executable_path().get_base_dir()+"/server.json")
		Json.parse(JsonFile)
		Data = Json.data
		
		data_failsafe_check(server_template)

func data_failsafe_check(pathobj) -> void:
	for i in pathobj.keys():
		if pathobj[i] is Dictionary:
			for n in pathobj[i].keys():
				if !Data[i].has(n):
					Data[i][n] = pathobj[i][n]
			data_failsafe_check(pathobj[i])

func _setup_audio(data:Dictionary) -> void:
	for i in data.keys():
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index(i),data[i])

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		KillThreads = true
		Core.AssetData.thread_force_post()
		if OS.has_feature("client"):
			
			#Core.Persistant_Core
			var NewFile = FileAccess.open(OS.get_executable_path().get_base_dir()+"/client.json",FileAccess.WRITE)
			NewFile.store_string(JSON.stringify(Data))
			NewFile.close()
		if OS.has_feature("server"):
			var NewFile = FileAccess.open(OS.get_executable_path().get_base_dir()+"/server.json",FileAccess.WRITE)
			NewFile.store_string(JSON.stringify(Data))
			NewFile.close()
	
func sort_ui() -> Node:
	var targeted_ui = null
	if UI_Hovered.size() > 1:
		for x in UI_Hovered:
			for y in UI_Hovered:
				if y != x:
					if y.get_index() > x.get_index():
						targeted_ui = y
						break
	else:
		targeted_ui = UI_Hovered[0]
		targeted_ui.get_parent().move_child(targeted_ui,targeted_ui.get_parent().get_child_count()-1)
	
	return targeted_ui
