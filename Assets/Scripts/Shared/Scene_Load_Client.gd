extends Node3D

var InitThread:Thread
var client_data
signal FinishedLoad

func _ready() -> void:
	InitThread = Thread.new()
	InitThread.start(Init_ThreadRun)
	
func Init_ThreadRun():
	client_data = load("res://Assets/Scenes/Client/Maps/"+self.name+"_Client.tscn").instantiate()
	var Tick_Timer = 0
	var Tick_Prev = 0
	for i in client_data.get_children():
		client_data.remove_child(i)
		$Client_Only.call_deferred("add_child",i)
	
	call_deferred("emit_signal","FinishedLoad")
