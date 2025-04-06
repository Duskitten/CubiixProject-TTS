extends Node


func server_compile(Server:Node, Player:ServerPlayer) -> void:
	var Core = Server.Core
	Player.Current_Saved_Packet["TTS_PollUpdate"] = {
		"CurrentPlayers":Server.Real_Connections.keys().size(),
		"MaxPlayers":Core.Globals.Data["MaxPlayers"],
		"ServerName":Core.Globals.Data["ServerName"],
		"ServerColor":Core.Globals.Data["ServerColor"]
	}
	
func client_parse(Client:Node, Data:Variant) -> void:
	Client.server_info_holder = Data
	Client.call_deferred("disable_connection")
