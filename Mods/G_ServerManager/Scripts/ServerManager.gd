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
var nextplayerpacket = {}
var packetholder = {}

var peertemplate = {
	"id":0,
	"peer":null,
}

func server_process():
	var delta = Time.get_ticks_msec() - tickprevious
	tickprevious = Time.get_ticks_msec()
	ticktimer += delta
	
	var newclientcheck = server.take_connection()
	if newclientcheck:
		var peer = PacketPeerStream.new()
		peer.stream_peer = newclientcheck
		peer.stream_peer.put_var({"G_TTSAssets:networktest":{}})
		print("Connected!")
		var name = int(hash(peer))
		var template = peertemplate.duplicate(true)
		template["peer"] = peer
		template["id"] = hash
		unsortedconnections.append(template)
		
	
	if ticktimer > 1000/20:
		tickcurrent += 1
		ticktimer = 0
		nextplayerpacket.clear()
		packetholder.clear()
		###This is the Reciever Pass
		###We want to grab the old packet to put in our list.
		for i in unsortedconnections:
			var peerobj = i["peer"].stream_peer
			peerobj.poll()
			if peerobj.get_status() == StreamPeerTCP.STATUS_CONNECTED:
				##Check for avaliable data
				if peerobj.get_available_bytes() > 0:
					var packetdata = peerobj.get_var(false)
					var roomid = ""
					if packetdata.has("G_TTSAssets:playerupdate"):
						roomid = packetdata["G_TTSAssets:playerupdate"]["room"]
					elif packetdata.has("G_TTSAssets:playerjoin"):
						roomid = packetdata["G_TTSAssets:playerjoin"]["room"]

					if roomid != "":
						if !nextplayerpacket.has(roomid):
							nextplayerpacket[roomid] = {}
						nextplayerpacket[roomid][i["id"]] = packetdata
						packetholder[i["id"]] = packetdata
						
						
			elif peerobj.get_status() == StreamPeerTCP.STATUS_NONE:
				pass
		
		###This is our Send Pass
		###We want to send the new dictionary this time.
		for i in unsortedconnections:
			var peerobj = i["peer"].stream_peer
			if peerobj.get_status() == StreamPeerTCP.STATUS_CONNECTED:
				var roomid = ""
				if packetholder.has(i["id"]):
					if packetholder[i["id"]].has("G_TTSAssets:playerupdate"):
						roomid = packetholder[i["id"]]["G_TTSAssets:playerupdate"]["room"]
					elif packetholder[i["id"]].has("G_TTSAssets:playerjoin"):
						roomid = packetholder[i["id"]]["G_TTSAssets:playerjoin"]["room"]
					
					if roomid != "":
						var duplicatedict = nextplayerpacket[roomid].duplicate(true)
						duplicatedict.erase(i["id"])
						peerobj.put_var(duplicatedict)
				
				
			elif peerobj.get_status() == StreamPeerTCP.STATUS_NONE:
				pass
	
