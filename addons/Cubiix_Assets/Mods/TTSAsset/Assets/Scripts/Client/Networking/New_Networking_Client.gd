extends Node
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
var NetworkThread = Thread.new()
var TCP = StreamPeerTCP.new()
var NG = NetworkingGlobal.new()
var Parse_Data = ClientParseData.new()
var Send_Data = ClientSendData.new()

var connect_timer:Timer = Timer.new()
var disable_connect = false

func _ready() -> void:
	add_child(connect_timer)
	connect_timer.wait_time = 3
	connect_timer.timeout.connect(disable_connection)

func connect_to_server(ip:String,port:String) -> void:
	TCP.connect_to_host(ip,int(port))
	connect_timer.start()
	start_network()
	
func start_network():
	NetworkThread.start(network_process)
	
	while true:
		if Core.Globals.KillThreads:
				break
		
		TCP.poll()
		match TCP.get_status():
			StreamPeerTCP.STATUS_CONNECTED:
				connect_timer.call_deferred("stop")
				if TCP.get_available_bytes() > 0:
					Parse_Data.parse_data(TCP.get_var(false))

			StreamPeerTCP.STATUS_CONNECTING:
				if TCP.get_available_bytes() > 0:
					Parse_Data.parse_data(TCP.get_var(false))
				if disable_connect:
					break
				
			StreamPeerTCP.STATUS_NONE:
				connect_timer.call_deferred("stop")
				break
	TCP.disconnect_from_host()
	
func network_process():
	while true:
		if Core.Globals.KillThreads:
				break

func _exit_tree() -> void:
	NetworkThread.wait_to_finish()
	
func disable_connection():
	connect_timer.call_deferred("stop")
	disable_connect = true
