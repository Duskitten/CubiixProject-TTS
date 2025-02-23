extends Node
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
var NetworkThread = Thread.new()
var TCP = TCPServer.new()
var Send_Data = ServerSendData.new()
var Parse_Data = ServerParseData.new()
var NG = NetworkingGlobal.new()

## These are part of the tick system so we can keep track of time
var Tick_Prev = 0
var Tick_Timer = 0
var Current_Tick = 0

## This will be a list of all the currently connected peers, unsorted, we will set up unique identifiers later.
var Peer_Connections = {}

func _ready() -> void:
	TCP.listen(Core.Globals.Data["Port"])
	start_network()
	
func start_network():
	NetworkThread.start(network_process)

func network_process():
	var CurrentTick :int = 0
	var CurrentTime :int = Time.get_ticks_msec()
	print("Server running on port: " + str(Core.Globals.Data["Port"]))
	while true:
		var Delta = Time.get_ticks_msec() - Tick_Prev
		Tick_Prev = Time.get_ticks_msec()
		Tick_Timer += Delta
		
		if Tick_Timer > 1000/20:
			Current_Tick += 1
			Tick_Timer = 0
			
			
		
		
		var New_Client_TCP = TCP.take_connection()
		if New_Client_TCP:
			var peer = PacketPeerStream.new()
			peer.stream_peer = New_Client_TCP
			var newPeer = ServerPlayer.new()
			newPeer.Character_Storage_Data["peer_obj"] = peer
			Peer_Connections[hash(peer)] = newPeer
			print("A User has made a new connection.")
			print("We will wait for a response.")
			Send_Data.send_data(self,TCP,newPeer,NG.networkCommand.ping_init)
		
		for i in Peer_Connections.keys():
			var n = Peer_Connections[i].Character_Storage_Data["peer_obj"]
			var peer = n.stream_peer
			peer.poll()
			
		#	print(peer.get_status())
			
			if peer.get_status() == StreamPeerTCP.STATUS_CONNECTED:
				#send_data(Core.Globals.Networking_Valid_Types.Player_Move,accumulated_server_positions[Peers[i]["room"]])
				if peer.get_available_bytes() > 0:
					Parse_Data.call_deferred("parse_data",self,TCP,Peer_Connections[i],peer.get_var(false))
