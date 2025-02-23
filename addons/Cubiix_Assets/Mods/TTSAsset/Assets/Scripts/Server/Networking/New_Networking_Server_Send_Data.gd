class_name ServerSendData
extends Node
var NG = NetworkingGlobal.new()


func send_data(Server:Node,TCP:TCPServer,Peer:ServerPlayer,Command:int, PassthroughData:Dictionary = {}) -> void:
	var Packet = {
		"Command":Command,
		"Data":{}
	}
	
	match Command:
		NG.networkCommand.ping_init:
			Packet["Data"] = {
				"Msg":"Hello User! Who are you!"
			}
		NG.networkCommand.ping_poll:
			Packet["Data"] = PassthroughData
			Packet["Data"]["ServerName"] = str(Server.Core.Globals.Data["ServerName"])
			Packet["Data"]["MaxPlayers"] = str(Server.Core.Globals.Data["MaxPlayers"])
			Packet["Data"]["CurrentPlayers"] = Server.Real_Connections.keys().size()

	Peer.Character_Storage_Data["peer_obj"].put_var(Packet)
