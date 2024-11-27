extends Node
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
var NetworkThread = Thread.new()
var TCP = StreamPeerTCP.new()
var Template_Packet = {
	"UserID":"",
	"Type":0,
	"Content":{}
}

enum Networking_Valid_Types {
	Ping,
	Player_Move,
	Player_Request_Info
}

var Local_Player = null
# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#
	#
func connect_to_server(ip:String,port:String):
	TCP.connect_to_host(ip,int(port))
	start_network()
	#Core.SceneData.Swap_Scene("Showcase")

func start_network():
	NetworkThread.start(network_process)

func network_process():
	NetworkThread.set_thread_safety_checks_enabled(false)
	while true:
		if Core.Globals.KillThreads:
				break

		if TCP.get_status() == StreamPeerTCP.STATUS_CONNECTED:
			TCP.poll()
			if TCP.get_available_bytes() > 0:
				parse_data(TCP.get_var(false))

		elif TCP.get_status() == StreamPeerTCP.STATUS_CONNECTING:
			TCP.poll()
			if TCP.get_available_bytes() > 0:
				parse_data(TCP.get_var(false))
			
		elif TCP.get_status() == StreamPeerTCP.STATUS_NONE:
			break

	TCP.disconnect_from_host()

func send_data(data:Dictionary):
	#print("Sending Data!")
	var Packet = Template_Packet.duplicate()
	Packet["Type"] = data["Type"]
	Packet["UserID"] = Core.Globals.LocalUser["UserID"]
	match data["Type"]:
		Networking_Valid_Types.Ping:
			Packet["Content"] = {}
		Networking_Valid_Types.Player_Move:
			Packet["Content"] = {}
		Networking_Valid_Types.Player_Request_Info:
			Packet["Content"] = {}
	
	TCP.put_var(Packet)
	
func parse_data(data:Dictionary):
	match data["Type"]:
		Networking_Valid_Types.Ping:
			print(round(data["Content"]),"MS Ping")
			TCP.disconnect_from_host()

func _exit_tree() -> void:
	NetworkThread.wait_to_finish()
