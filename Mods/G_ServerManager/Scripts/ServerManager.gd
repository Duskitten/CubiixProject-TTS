extends Node
var coreobj = null

var serverinfo = {
	"port":25565,
	"servertext":"A Cubiix Server!",
	"servercolor":Color(0.0, 0.749, 0.847, 1.0)
}

var currentrooms = {
	"lobby":[]
}

var unsortedconnections = []
var server = TCPServer.new()

func setup(core:Node):
	coreobj = core
	print("Starting Cubiix Server...")
	server.listen(serverinfo["port"])
	print("Server Started...")
