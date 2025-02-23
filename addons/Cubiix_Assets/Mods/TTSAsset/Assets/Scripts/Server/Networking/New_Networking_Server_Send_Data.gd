class_name ServerSendData
extends Node
var NG = NetworkingGlobal.new()

func send_data(Server:Node,TCP:TCPServer,Peer:ServerPlayer,Command:int) -> void:
	var Packet = {
		"Command":Command,
		"Data":{}
	}
	
	match Command:
		NG.networkCommand.ping_init:
			Packet["Data"] = {
				"Msg":"Hello User! Who are you!"
			}

	Peer.Character_Storage_Data["peer_obj"].put_var(Packet)
