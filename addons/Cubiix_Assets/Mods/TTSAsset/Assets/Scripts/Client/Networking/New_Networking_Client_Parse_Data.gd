class_name ClientParseData
extends Node
var NG = NetworkingGlobal.new()

func parse_data(Client:Node,TCP:StreamPeerTCP,Data:Variant) -> void:
	print(Data)
	match Data["Command"]:
		NG.networkCommand.ping_init:
			Client.Send_Data.send_data(Client,TCP,NG.networkCommand.ping_init)
