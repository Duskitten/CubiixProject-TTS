extends Node
var coreobj = null

var serverrunning = false

var serverinfo = {
	"port":25565,
	"servertext":"A Cubiix Server!",
	"servercolor":Color(0.0, 0.749, 0.847, 1.0)
}

var peertemplate = {
	"id":0,
	"peer":null,
	"room":"lobby",
	"disconnected":false
}

var current_player_packet = {}
var next_player_packet = {}

var unsortedconnections = []
var server = TCPServer.new()

func setup(core:Node):
	coreobj = core
	print("Starting Cubiix Server...")
	server.listen(serverinfo["port"])
	serverrunning = true
	print("Server Started...")

func _process(delta: float) -> void:
	if serverrunning:
		server_process()

var tickprevious = 0
var ticktimer = 0
var tickcurrent = 0

func server_process():
	var delta = Time.get_ticks_msec() - tickprevious
	tickprevious = Time.get_ticks_msec()
	ticktimer += delta
	if ticktimer > 1000/20:
		next_player_packet = {}
		tickcurrent += 1
		ticktimer = 0
		###This is the Reciever Pass
		###We want to grab the old packet to put in our list.
		for i in unsortedconnections:
			var peerobj = i["peer"].stream_peer
			peerobj.poll()
			if peerobj.get_status() == StreamPeerTCP.STATUS_CONNECTED:
				##Check for avaliable data
				if peerobj.get_available_bytes() > 0:
					var packetdata = peerobj.get_var(false)
					if !next_player_packet.has(i["room"]):
						next_player_packet[i["room"]] = {}
						next_player_packet[i["room"]][i["id"]] = packetdata
						
				elif peerobj.get_available_bytes() <= 0:
					pass
			elif peerobj.get_status() == StreamPeerTCP.STATUS_NONE || i["disconnected"]:
				if !next_player_packet.has(i["room"]):
					next_player_packet[i["room"]] = {}
					next_player_packet[i["room"]][i["id"]] = {"disconnected":true}
				i["peer"].stream_peer.disconnect_from_host()
				unsortedconnections.erase(i)
		
		###This is our Send Pass
		###We want to send the new dictionary this time.
		for i in unsortedconnections:
			var peerobj = i["peer"].stream_peer
			if peerobj.get_status() == StreamPeerTCP.STATUS_CONNECTED:
				##Remove current player in a temp cache
				var CopyPass = next_player_packet[i["room"]].duplicate(true)
				CopyPass.erase(peerobj["id"])
				peerobj.put_var(CopyPass)
				
			elif peerobj.get_status() == StreamPeerTCP.STATUS_NONE:
				i["disconnected"] = true
		
	
	###This is where we set up the new players that join
	var newclientcheck = server.take_connection()
	if newclientcheck:
		var peer = PacketPeerStream.new()
		peer.stream_peer = newclientcheck
		var name = hash(peer)
		var peertemplate = peertemplate.duplicate(true)
		unsortedconnections.append(peertemplate)
