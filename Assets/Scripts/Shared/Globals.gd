extends Node
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

var LocalUser = {
	"URL":"",
	"UserSecretCode":"",
	"Username":"",
}

var KillThreads = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if OS.has_feature("client"):
		pass
		
	if OS.has_feature("server"):
		pass
	

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		KillThreads = true
		if OS.has_feature("client"):
			Core.AssetData.thread_force_post()
		
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
