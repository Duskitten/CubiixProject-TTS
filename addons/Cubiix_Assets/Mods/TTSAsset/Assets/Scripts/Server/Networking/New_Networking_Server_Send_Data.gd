class_name ServerSendData
extends Node
var NG = NetworkingGlobal.new()

func send_data(TCP:TCPServer,Peer:ServerPlayer,Command:int) -> void:
	var Packet = {
		"Command":Command,
		"Data":{}
	}
	
	match Command:
		NG.networkCommand_TCP.ping_init:
			##Lets see who this new user is!
			pass
