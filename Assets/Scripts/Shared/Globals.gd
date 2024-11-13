extends Node
@onready var Core = get_node("/root/Main_Scene/CoreLoader")


enum Networking_Valid_Types {
	Ping,
	JWT_Attempt_Login,
	JWT_Return_Status,
	Player_Request_Info,
	Player_Spawn,
	Player_Char_Update,
	Player_Move,
	Player_Chat,
	Server_Chat,
	System_Chat
}

var LocalUser = {
	"UserID":0,
	"UserSecretCode":"",
	"JWT":""
}

var KillThreads = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if OS.has_feature("client") || OS.is_debug_build():
		pass
		
	if OS.has_feature("server"):
		pass
	

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		KillThreads = true
		Core.AssetData.thread_force_post()
		
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
