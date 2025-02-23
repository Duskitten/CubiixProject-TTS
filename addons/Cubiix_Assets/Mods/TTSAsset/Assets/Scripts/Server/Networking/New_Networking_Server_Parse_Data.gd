class_name ServerParseData
extends Node
var NG = NetworkingGlobal.new()

func parse_data(Server:Node,TCP:TCPServer,Peer:ServerPlayer,Data:Variant) -> void:
	match Data["Command"]:
		NG.networkCommand.ping_init:
			print(Data)
		NG.networkCommand.ping_poll:
			##Send back the client the time it send us.
			Server.Send_Data.send_data(Server, TCP, Peer, NG.networkCommand.ping_poll, {"CurrentTime" : Data["Data"]["CurrentTime"]})
