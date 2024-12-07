extends Node
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
var NetworkThread = Thread.new()
var TCP = TCPServer.new()

var Peers = {}
var PeerHash = []

var OrganizedPeers = {
	
}

var Rooms = {}

var Template_Packet = {
	"Username":"Server",
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
	TCP.listen(Core.Globals.Data["Port"])
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
			var newPeer = ServerPlayer.new()
			newPeer.Character_Storage_Data["peer_obj"] = peer
			Peers[hash(newPeer.Character_Storage_Data["peer_obj"])] = newPeer
			
			print("We Will Wait For Response.")
			send_data(peer,Networking_Valid_Types.Ping,{"Q":"Hello, Who Are You?"})
		
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
				var n = Peers[i].Character_Storage_Data["peer_obj"]
				var peer = n.stream_peer
				if peer.get_status() == StreamPeerTCP.STATUS_CONNECTED:
					###This is where we'd like to send the player the entire tick.
					pass

		####Everything Past here is "Returned" data from clients
		for i in Peers.keys():
			var n = Peers[i].Character_Storage_Data["peer_obj"]
			var peer = n.stream_peer
			peer.poll()
			
		#	print(peer.get_status())
			
			if peer.get_status() == StreamPeerTCP.STATUS_CONNECTED:
				#send_data(Core.Globals.Networking_Valid_Types.Player_Move,accumulated_server_positions[Peers[i]["room"]])
				if peer.get_available_bytes() > 0:
					parse_data(i,n,peer.get_var(false),Peers[i],i)
					
			elif peer.get_status() == StreamPeerTCP.STATUS_NONE:
				print("Removing!")
				Peers.erase(i)

		if Core.Globals.KillThreads:
			break
		
	print("Killing Network Thread!")

func send_data(peer:PacketPeerStream, id:Networking_Valid_Types, data:Dictionary):
	var Packet = Template_Packet.duplicate(true)
	Packet["Type"] = id
	Packet["Content"] = data
	peer.put_var(Packet)

func parse_data(key:int, user:PacketPeerStream, data:Dictionary, userobj:ServerPlayer, peerid:int):
	match data["Type"]:
		Networking_Valid_Types.Ping:
			match data["Content"]["A"]:
				"Pinging":
					print("recieved ping!")
					send_data(user,Networking_Valid_Types.Ping,{
						"A":"Time",
						"Time":float(data["Content"]["Time"]),
						"MaxPlayers":int(Core.Globals.Data["MaxPlayers"]),
						"CurrentPlayers":int(OrganizedPeers.size()),
						"ServerName":str(Core.Globals.Data["ServerName"]),
						"ServerColor":str(Core.Globals.Data["ServerColor"])
						})
				"Connect":
					###This is when we want a player to join!
					if data["Content"]["URL"].to_lower() == "localhost":
						print("Error: User Attempted to join using localhost domain.")
						userobj.queue_free()
						Peers.erase(peerid)
					else:
						userobj.Character_Storage_Data["Player_OBJ_IDName"] = str(hash(data["Content"]["Username"]+"@"+data["Content"]["URL"]))
						userobj.name = userobj.Character_Storage_Data["Player_OBJ_IDName"]
						#Player_To_Room(userobj,"island_0")
						validate_player(
							userobj,
							data["Content"]["Username"],
							data["Content"]["UserSecretCode"],
							data["Content"]["URL"]
							)
						print(data["Content"])
						print("Recieved connection ping!")

func _exit_tree() -> void:
	NetworkThread.wait_to_finish()

func gen_new_room(room:String) -> void:
	if Rooms.has(room):
		print("Error: This Room ID Exists.")
	else:
		Rooms[room] = ServerRoom.new()
		call_deferred("add_child",Rooms[room])
		for i in RoomSignals:
			Rooms[room].add_user_signal(i)

func Player_To_Room(userobj:ServerPlayer,room:String) -> void:
	Rooms[room].call_deferred("add_child",userobj)
	userobj.Character_Storage_Data["Current_Room"] = room

func Player_RemoveFrom_Room(userobj:ServerPlayer,room:String) -> void:
	Rooms[room].call_deferred("remove_child",userobj)
	userobj.Character_Storage_Data["Current_Room"] = ""

			

func validate_player(playernode:ServerPlayer,username:String, secret:String, url:String) -> void:
	print("attempting to validate player")
	var API_Validate = HTTPRequest.new()
	API_Validate.request_completed.connect(api_validate_completed.bind(playernode,API_Validate))
	call_deferred("add_child",API_Validate)
	print(username)
	print(secret)
	await API_Validate.ready
	API_Validate.request("https://api."+url+"/user/validateUser",["userID: \""+username+"\"","userSecretCode: \""+secret+"\"",
	"Content-Type: application/json"]
	,HTTPClient.METHOD_GET,"")

func api_validate_completed(result, response_code, headers, body, playernode:ServerPlayer, httpnode:HTTPRequest):
	httpnode.queue_free()
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	print(response)
	print("api Completed!")
	if response != null:
		if response["status"] == 0:
			pass
		else:
			pass
	else:
		pass
