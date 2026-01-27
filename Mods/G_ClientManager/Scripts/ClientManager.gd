extends Node

var coreobj = null

var client:StreamPeerTCP = StreamPeerTCP.new()
var attemptedconnect = false

var currentpacket = {}

func setup(core:Node):
	coreobj = core
	connect_to_server("localhost", 25565)

func connect_to_server(host:String, port:int):
	client.connect_to_host(host,port)
	attemptedconnect = true

func _process(delta: float) -> void:
	if attemptedconnect:
		client.poll()
		if client.get_status() == StreamPeerTCP.STATUS_CONNECTED:
			if client.get_available_bytes() > 0:
				var data = client.get_var(false)
				##Now we send back that we got a response!
				client.put_var(currentpacket,false)
				currentpacket = {}
		elif client.get_status() == StreamPeerTCP.STATUS_NONE:
			attemptedconnect = false
			client.disconnect_from_host()
			currentpacket = {}

func append_new_packetdata(dataname:String,data:Dictionary):
	currentpacket[dataname] = data
