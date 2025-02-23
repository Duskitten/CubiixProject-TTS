class_name ClientSendData
extends Node
var NG = NetworkingGlobal.new()

func send_data(Client:Node,TCP:StreamPeerTCP,Command:int, PassthroughData:Dictionary = {}) -> void:
	var Packet = {
		"Command":Command,
		"Data":{}
	}
	
	match Command:
		## This is for initial testing purposes
		NG.networkCommand.ping_init:
			Packet["Data"] = {
				"Msg":"Hello Server!"
			}
		
		## This will be for when we want to simply poll the server for info
		## And not create a perminant connection.
		NG.networkCommand.ping_poll:
			Packet["Data"] = {
				"CurrentTime":Time.get_ticks_msec()
			}

	TCP.put_var(Packet)
