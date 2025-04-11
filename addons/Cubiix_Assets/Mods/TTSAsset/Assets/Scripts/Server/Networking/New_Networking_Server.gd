extends Node
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
var NetworkThread = Thread.new()
var TCP = TCPServer.new()

## These are part of the tick system so we can keep track of time
var Tick_Prev = 0
var Tick_Timer = 0
var Current_Tick = 0

## This will be a list of all the currently connected peers, unsorted, we will set up unique identifiers later.
var Peer_Connections = {}

## This will be a list of all the "real" players in the server after they auth and such.
var Real_Connections = {}

@onready var Room_Manager:RoomManager = RoomManager.new()
@onready var Database_Manager:DatabaseManager = DatabaseManager.new()

var Commands = {}

func _ready() -> void:
	Room_Manager.Server = self
	add_child(Room_Manager)
	add_child(Database_Manager)
	
	
	for i in Core.AssetData.assets_tagged["Network_Command"]:
		#print(i)
		var commanddata = Core.AssetData.find_command(i)
		#print(commanddata)
		var command = load(commanddata["Path"]).new()
		#command.name = commanddata["Name"]
		Commands[commanddata["Name"]] = command
		
	TCP.listen(Core.Globals.Data["Port"])
	start_network()
	
func start_network():
	NetworkThread.start(network_process)

func network_process():
	var CurrentTick :int = 0
	var CurrentTime :int = Time.get_ticks_msec()
	print("Server running on port: " + str(int(Core.Globals.Data["Port"])))
	while true:
		var Delta = Time.get_ticks_msec() - Tick_Prev
		Tick_Prev = Time.get_ticks_msec()
		Tick_Timer += Delta
		
		if Tick_Timer > 1000/20:
			Current_Tick += 1
			Tick_Timer = 0
			
			for i in Peer_Connections.keys():
				var n = Peer_Connections[i].Character_Storage_Data["peer_obj"]
				var peer = n.stream_peer
				peer.poll()

				var newPeer = Peer_Connections[i]
				
				
				if newPeer.Character_Storage_Data["Validated"]:
					Commands["TTS_MovementUpdate"].server_compile(self,newPeer)

				if peer.get_status() == StreamPeerTCP.STATUS_CONNECTED:
					##send_data(Core.Globals.Networking_Valid_Types.Player_Move,accumulated_server_positions[Peers[i]["room"]])
					if peer.get_available_bytes() > 0:
						if !Peer_Connections[i].DisconnectTimer.is_stopped():
							Peer_Connections[i].call_deferred("stop_timer")
						var Data = peer.get_var(false)
						if Data is Dictionary && !Data.is_empty():
							call_deferred("SendToParser",Peer_Connections[i], Data)
					elif peer.get_available_bytes() <= 0:
						if Peer_Connections[i].DisconnectTimer.is_stopped():
							Peer_Connections[i].call_deferred("start_timer")
						#Parse_Data.call_deferred("parse_data",self,TCP,Peer_Connections[i],)
				elif peer.get_status() == StreamPeerTCP.STATUS_NONE:
					var who = Peer_Connections[i]
					if Peer_Connections[i].Character_Storage_Data["Current_Room"] != "":
						Room_Manager.notify_disconnect(Peer_Connections[i].Character_Storage_Data["Current_Room"],who)
						Peer_Connections[i].save_player()
					if Real_Connections.has(Peer_Connections[i].Character_Storage_Data["DB_Data"]["PhoneID"]):
						Real_Connections.erase(Peer_Connections[i].Character_Storage_Data["DB_Data"]["PhoneID"])
					Peer_Connections[i].queue_free()
					Peer_Connections.erase(i)

			for i in Peer_Connections.keys():
				var n = Peer_Connections[i].Character_Storage_Data["peer_obj"]
				var peer = n.stream_peer
				var newPeer = Peer_Connections[i]
				
				newPeer.Character_Storage_Data["peer_obj"].put_var(newPeer.Current_Saved_Packet)
				#print(newPeer.Current_Saved_Packet)
				if newPeer.Character_Storage_Data["Disconnect"]:
					newPeer.Character_Storage_Data["peer_obj"].stream_peer.disconnect_from_host()
				else:
					newPeer.Current_Saved_Packet = {"TTS_Ping":true}
				
		var New_Client_TCP = TCP.take_connection()
		if New_Client_TCP:
			var peer = PacketPeerStream.new()
			peer.stream_peer = New_Client_TCP
			var newPeer = ServerPlayer.new()
			newPeer.Character_Storage_Data["peer_obj"] = peer
			newPeer.Character_Storage_Data["Player_OBJ_ID"] = hash(peer)
			newPeer.Server = self
			call_deferred("add_child",newPeer)
			Peer_Connections[hash(peer)] = newPeer
			Commands["TTS_Ping_Init"].server_compile(self,newPeer)

func SendToParser(Peer:ServerPlayer,Data) -> void:
	#print(Data)
	for i in Data.keys():
		Commands[i].server_parse(self, Peer, Data[i])
