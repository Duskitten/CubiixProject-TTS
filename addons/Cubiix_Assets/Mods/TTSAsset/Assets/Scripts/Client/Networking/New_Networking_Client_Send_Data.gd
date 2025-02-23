class_name ClientSendData
extends Node
var NG = NetworkingGlobal.new()

func send_data(Client:Node,TCP:StreamPeerTCP,Command:int) -> void:
	var Packet = {
		"Command":Command,
		"Data":{}
	}
	
	match Command:
		NG.networkCommand.ping_init:
			Packet["Data"] = {
				"Msg":"Hello Server!"
			}

	TCP.put_var(Packet)
