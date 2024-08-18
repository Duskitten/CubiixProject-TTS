extends Node
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
var NetworkThread = Thread.new()
var TCP = StreamPeerTCP.new()
var Template_Packet = {
	"UserID":"",
	"Type":0,
	"Content":{}
}

var Local_Player = null

var Tick_Prev = 0
var Tick_Timer = 0
var Current_Tick = 0
var FirstPass = true
var TrueConnect = false
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
	var CurrentTick :int = 0
	var CurrentTime :int = Time.get_ticks_msec()
	NetworkThread.set_thread_safety_checks_enabled(false)
	while true:
		if Core.Globals.KillThreads:
				break
		var Delta = Time.get_ticks_msec() - Tick_Prev
		Tick_Prev = Time.get_ticks_msec()
		Tick_Timer += Delta
		
		if Tick_Timer > 1000/60:
			Current_Tick += 1
			Tick_Timer = 0
			if TCP.get_status() == StreamPeerTCP.STATUS_CONNECTED:
				TCP.poll()
				if TCP.get_available_bytes() > 0:
					parse_data(TCP.get_var(false))
				#send_data({"Test":"Hello from client"})
				if !TrueConnect:
					if FirstPass:
						send_data({"Type":Core.Globals.Networking_Valid_Types.Ping})
						FirstPass = false
				elif TrueConnect:
					if FirstPass:
						send_data({"Type":Core.Globals.Networking_Valid_Types.Player_Request_Info})
						FirstPass = false
					if Local_Player != null && Local_Player.queue_network_moved:
						Local_Player.queue_network_moved = false
						send_data({"Type":Core.Globals.Networking_Valid_Types.Player_Move})
	
			elif TCP.get_status() == StreamPeerTCP.STATUS_CONNECTING:
				TCP.poll()
				if TCP.get_available_bytes() > 0:
					parse_data(TCP.get_var(false))
				
			elif TCP.get_status() == StreamPeerTCP.STATUS_NONE:
				break
			
	TCP.disconnect_from_host()
	print("Killing Network Thread!")

func send_data(data:Dictionary):
	#print("Sending Data!")
	var Packet = Template_Packet.duplicate()
	Packet["Type"] = data["Type"]
	Packet["UserID"] = Core.Globals.LocalUser["UserID"]
	match data["Type"]:
		Core.Globals.Networking_Valid_Types.Ping:
			Packet["Content"]["Ping"] = Time.get_unix_time_from_system()
			print(Time.get_unix_time_from_system())
		Core.Globals.Networking_Valid_Types.Player_Move:
			Packet["Content"] = {
				"Player_Position":Local_Player.global_position,
				"Player_Rotation":Local_Player.global_rotation,
				"Player_Model_Rotation":Local_Player.get_node("Hub").global_rotation
				}
		Core.Globals.Networking_Valid_Types.Player_Request_Info:
			print("Hello?")
			Packet["Content"] = {
				"UserID": Core.Globals.LocalUser["UserID"],
				"JWT": Core.Globals.LocalUser["JWT"]
				}
	
	TCP.put_var(Packet)
	
func parse_data(data:Dictionary):
	match data["Type"]:
		Core.Globals.Networking_Valid_Types.Ping:
			print(round(data["Content"]),"MS Ping")
			TCP.disconnect_from_host()
			#
		#Core.Globals.Networking_Valid_Types.Player_Request_Info:
			##print(data)
			#send_data({"Type":Core.Globals.Networking_Valid_Types.Player_Request_Info})

func _exit_tree() -> void:
	NetworkThread.wait_to_finish()
