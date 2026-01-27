extends Node
var coreobj = null

var serverrunning = false

var serverinfo = {
	"port":25565,
	"servertext":"A Cubiix Server!",
	"servercolor":Color(0.0, 0.749, 0.847, 1.0)
}

var server = TCPServer.new()

func setup(core:Node):
	coreobj = core
	print("Checking Config")
	if Engine.is_editor_hint():
		var path = "~/.config/CubiixProject"
		
	else:
		var path = OS.get_executable_path()
		print(path)
	print("Starting Server")
	server.listen(serverinfo["port"])
	serverrunning = true
	print("Server Started")

func _process(delta: float) -> void:
	if serverrunning:
		server_process()

var tickprevious = 0
var ticktimer = 0
var tickcurrent = 0

var unsortedconnections = []

var newplayerpacket = {}
var nextplayerpacket = {}

var peertemplate = {
	"id":0,
	"peer":null,
	"room":"room_1",
	"disconnected":false
}

func server_process():
	var delta = Time.get_ticks_msec() - tickprevious
	tickprevious = Time.get_ticks_msec()
	ticktimer += delta
	
	var newclientcheck = server.take_connection()
	if newclientcheck:
		var peer = PacketPeerStream.new()
		peer.stream_peer = newclientcheck
		print("Connected!")
		var name = hash(peer)
		var peertemplate = peertemplate.duplicate(true)
		peertemplate["peer"] = peer
		peertemplate["id"] = hash
		unsortedconnections.append(peertemplate)
		newplayerpacket[name] = {"server:spawn_character_node":true}
		
	
	if ticktimer > 1000/20:
		tickcurrent += 1
		ticktimer = 0
		
		nextplayerpacket = newplayerpacket.duplicate(true)
		newplayerpacket = {}
		
		
		###This is the Reciever Pass
		###We want to grab the old packet to put in our list.
		for i in unsortedconnections:
			var peerobj = i["peer"].stream_peer
			peerobj.poll()
			if peerobj.get_status() == StreamPeerTCP.STATUS_CONNECTED:
				##Check for avaliable data
				if peerobj.get_available_bytes() > 0:
					var packetdata = peerobj.get_var(false)
					if !nextplayerpacket.has(i["room"]):
						nextplayerpacket[i["room"]] = {}
						nextplayerpacket[i["room"]][i["id"]] = packetdata
				elif peerobj.get_available_bytes() <= 0:
					pass
			elif peerobj.get_status() == StreamPeerTCP.STATUS_NONE || i["disconnected"]:
				if !nextplayerpacket.has(i["room"]):
					nextplayerpacket[i["room"]] = {}
					nextplayerpacket[i["room"]][i["id"]] = {"server:disconnected":true}
				i["peer"].stream_peer.disconnect_from_host()
				unsortedconnections.erase(i)
		
		###This is our Send Pass
		###We want to send the new dictionary this time.
		for i in unsortedconnections:
			var peerobj = i["peer"].stream_peer
			if peerobj.get_status() == StreamPeerTCP.STATUS_CONNECTED:
				##Remove current player in a temp cache
				if !nextplayerpacket.has(i["room"]):
						nextplayerpacket[i["room"]] = {}
				var CopyPass = nextplayerpacket[i["room"]].duplicate(true)
				CopyPass.erase(i["id"])
				peerobj.put_var(CopyPass)
			elif peerobj.get_status() == StreamPeerTCP.STATUS_NONE:
				i["disconnected"] = true
		
	
	
