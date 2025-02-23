class_name ServerParseData
extends Node
var NG = NetworkingGlobal.new()

func parse_data(Server:Node,TCP:TCPServer,Peer:ServerPlayer,Data:Variant) -> void:
	match Data["Command"]:
		NG.networkCommand.ping_init:
			print(Data)
