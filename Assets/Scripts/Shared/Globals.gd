extends Node
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

var LocalUser = {
	"URL":"",
	"UserSecretCode":"",
	"Username":"",
}

var save_template ="""{
	\"LastChar_Save\":"",
	\"Master_Volume\":0,
	\"Music_Volume\":0,
	\"SFX_Volume\":0,
	\"Notification_Volume\":0,
	\"ChatPing_Volume\":0,
}"""

var server_template ="""{
	\"Port\":5599,
	\"MaxPlayers\":40,
	\"ServerName\":\"TestServer\",
	\"ServerColor\":\"#999634\"
}"""

var Data:Dictionary = {}

var KillThreads = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if OS.has_feature("client"):
		var Json = JSON.new()
		var IsFile = FileAccess.file_exists(OS.get_executable_path().get_base_dir()+"/client.json")
		print(IsFile)
		if !IsFile:
			var NewFile = FileAccess.open(OS.get_executable_path().get_base_dir()+"/client.json",FileAccess.WRITE)
			NewFile.store_string(save_template)
			NewFile.close()

		var JsonFile = FileAccess.get_file_as_string(OS.get_executable_path().get_base_dir()+"/client.json")
		Json.parse(JsonFile)
		Data = Json.data
		
	if OS.has_feature("server"):
		var Json = JSON.new()
		#print(OS.get_executable_path().get_base_dir()+"/server.json")
		var IsFile = FileAccess.file_exists(OS.get_executable_path().get_base_dir()+"/server.json")
		if !IsFile:
			var NewFile = FileAccess.open(OS.get_executable_path().get_base_dir()+"/server.json",FileAccess.WRITE)
			NewFile.store_string(server_template)
			NewFile.close()

		var JsonFile = FileAccess.get_file_as_string(OS.get_executable_path().get_base_dir()+"/server.json")
		Json.parse(JsonFile)
		Data = Json.data
	

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		KillThreads = true
		if OS.has_feature("client"):
			Core.AssetData.thread_force_post()
		
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
