class_name ClientParseData
extends Node
var NG = NetworkingGlobal.new()

func parse_data(Client:Node,TCP:StreamPeerTCP,Data:Variant) -> void:
	print(Data)
	match Data["Command"]:
		NG.networkCommand.ping_init:
			if Client.ping_system_toggle:
				Client.Send_Data.send_data(Client,TCP,NG.networkCommand.ping_poll)
			else:
				Client.Send_Data.send_data(Client,TCP,NG.networkCommand.ping_init)
		NG.networkCommand.ping_poll:
			Client.disable_connect = true
			Client.server_info_holder = Data
			print(Time.get_ticks_msec() - Data["Data"]["CurrentTime"])
			Client.call_deferred("emit_signal","ServerPolled")
