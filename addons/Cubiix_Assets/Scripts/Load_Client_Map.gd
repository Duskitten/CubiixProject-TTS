extends Node3D
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

var InitThread:Thread
var client_data
var client_string:String
signal FinishedLoad

func setup() -> void:
	InitThread = Thread.new()
	InitThread.start(Init_ThreadRun)
	
func Init_ThreadRun():
	client_data = load(client_string).instantiate()
	var Tick_Timer = 0
	var Tick_Prev = 0
	for i in client_data.get_children():
		client_data.remove_child(i)
		$Client.call_deferred("add_child",i)
	
	call_deferred("emit_signal","FinishedLoad")
