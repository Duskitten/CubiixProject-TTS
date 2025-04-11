extends Object

func server_parse(Server:Node, Player:ServerPlayer, Data:Variant) -> void:
	pass

func server_compile(Server:Node, Player:ServerPlayer, NewPlayer:ServerPlayer) -> void:
	var NewPlayerDetails:Dictionary = {
		"PhoneID":NewPlayer.Character_Storage_Data["DB_Data"]["PhoneID"]
	}
	if Player.Current_Saved_Packet.has("TTS_DespawnPlayers"):
		Player.Current_Saved_Packet["TTS_DespawnPlayers"].append(NewPlayerDetails)
	else:
		Player.Current_Saved_Packet["TTS_DespawnPlayers"] = []
		Player.Current_Saved_Packet["TTS_DespawnPlayers"].append(NewPlayerDetails)
	
func client_parse(Client:Node, Data:Variant) -> void:
	#print(Data)
	for i in Data:
		var character = Client.NetworkPlayers.get_node_or_null(i["PhoneID"])
		if character != null:
			Client.NetworkPlayers.call_deferred("remove_child", character)
			character.queue_free()
	
func client_compile(Client:Node) -> void:
	pass
