extends Node
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
var NetworkThread = Thread.new()
var TCP = TCPServer.new()

var Template_Room = {
	"users":[]
}
var Peers = {}
var PeerHash = []

var OrganizedPeers = {
	
}


var Template_User = {
	"room":"",
	"uuid":"",
	"peer_obj":null,
	"validated":false,
	"base_position":Vector3.ZERO,
	"base_rotation":Vector3.ZERO,
	"model_rotation":Vector3.ZERO,
}
var Rooms = {}

var Template_Packet = {
	"UserID":"0",
	"Type":0,
	"Content":""}

var RoomSignals = ["_connected","_disconnected","_spawn_player"]

enum Networking_Valid_Types {
	Ping,
	Player_Move,
	Player_Request_Info
}

var Tick_Prev = 0
var Tick_Timer = 0
var Current_Tick = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var Json = JSON.new()
	print(OS.get_executable_path().get_base_dir()+"/server.json")
	var file = FileAccess.get_file_as_string(OS.get_executable_path().get_base_dir()+"/server.json")
	Json.parse(file)
	TCP.listen(Json.data["Port"])
	start_network()
	
func start_network():
	NetworkThread.start(network_process)

func network_process():
	var CurrentTick :int = 0
	var CurrentTime :int = Time.get_ticks_msec()
	NetworkThread.set_thread_safety_checks_enabled(false)
	gen_new_room("island_0")
	
	while true:
		var Delta = Time.get_ticks_msec() - Tick_Prev
		Tick_Prev = Time.get_ticks_msec()
		Tick_Timer += Delta
		
		var client = TCP.take_connection()
		if client:
			var peer = PacketPeerStream.new()
			peer.stream_peer = client
			var newPeer = Template_User.duplicate(true)
			newPeer["peer_obj"] = peer
			Peers[hash(newPeer["peer_obj"])] = newPeer.duplicate(true)
			print("We Will Wait For Response.")
			#send_data(newPeer["peer_obj"],{"Type":Core.Globals.Networking_Valid_Types.Player_Request_Info,"Content":"Hello, Who Are You?"})
		
		## So we need a plan of action here, the best way to handle this I think will be a call and response system.
		## Essentially, the server will keep ticking with an open ended input
		##
		## Server Intakes at realtime
		## Server sends snapshot command at tick speed
		## This would constitute any entities in the world, such as Players, Items, Enemies, etc
		## We need to pack this all into a single Dictionary to throw it across the network
		##
		## Client Returns Data after command (Position/Location/Rotations/Animations values etc)
		## We essentially want to capture the majority of the player's state in terms of the actual
		## Player Model, with sub commands for things like UI that can be returned at a later date
		## Clients will be in an open loop and have no concept of a tick as they're responding on a 
		## need-to-know basis
		## 
		## Then we just loop this I guess?
		
		
		####Everything within the tick counter is for the actual server to send out.
		if Tick_Timer > 1000/20:
			Current_Tick += 1
			Tick_Timer = 0
			var accumulated_server_positions = {} ##User > Position/Rotation/Ect Data

			for i in Peers.keys():
				var n = Peers[i]["peer_obj"]
				var peer = n.stream_peer
				if peer.get_status() == StreamPeerTCP.STATUS_CONNECTED:
					###This is where we'd like to send the player the entire tick.
					pass

		####Everything Past here is "Returned" data from clients
		for i in Peers.keys():
			var n = Peers[i]["peer_obj"]
			var peer = n.stream_peer
			peer.poll()
			if peer.get_status() == StreamPeerTCP.STATUS_CONNECTED:
				if Peers[i]["validated"]:
					#send_data(Core.Globals.Networking_Valid_Types.Player_Move,accumulated_server_positions[Peers[i]["room"]])
					if peer.get_available_bytes() > 0:
						parse_data(i,n,peer.get_var(false))
					
			elif peer.get_status() == StreamPeerTCP.STATUS_NONE:
				Peers.erase(i)

		if Core.Globals.KillThreads:
			break
		
	print("Killing Network Thread!")

func send_data(peer:PacketPeerStream, data:Dictionary):
	var Packet = Template_Packet.duplicate(true)
	Packet["Type"] = data["Type"]
	match data["Type"]:
		Networking_Valid_Types.Player_Request_Info:
			pass
		Networking_Valid_Types.Ping:
			pass
		Networking_Valid_Types.Player_Move:
			pass

	peer.put_var(Packet)



func parse_data(key:int, user:PacketPeerStream, data:Dictionary):
	match data["Type"]:
		Networking_Valid_Types.Ping:
			pass
		Networking_Valid_Types.Player_Request_Info:
			pass
		Networking_Valid_Types.Player_Move:
			pass

func _exit_tree() -> void:
	NetworkThread.wait_to_finish()

func gen_new_room(room:String) -> void:
	if Rooms.has(room):
		pass
	else:
		Rooms[room] = Template_Room.duplicate(true)
		for i in RoomSignals:
			add_user_signal(room+i)
