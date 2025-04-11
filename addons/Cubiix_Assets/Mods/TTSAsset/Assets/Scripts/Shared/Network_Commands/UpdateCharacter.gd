extends Object

func server_parse(Server:Node, Player:ServerPlayer, Data:Variant) -> void:
	pass

func server_compile(Server:Node, Player:ServerPlayer,NewPlayer:ServerPlayer) -> void:
	var NewPlayerDetails = {
		"Character":NewPlayer.Character_Storage_Data["DB_Version_Data"]["gamedata_VB_01_00"]["Character"],
		"Accessories":NewPlayer.Character_Storage_Data["DB_Version_Data"]["gamedata_VB_01_00"]["Accessories"],
		"PhoneID":NewPlayer.Character_Storage_Data["DB_Data"]["PhoneID"]
	}
	
	if Player.Current_Saved_Packet.has("TTS_UpdateCharacter"):
		Player.Current_Saved_Packet["TTS_UpdateCharacter"].append(NewPlayerDetails)
	else:
		Player.Current_Saved_Packet["TTS_UpdateCharacter"] = []
		Player.Current_Saved_Packet["TTS_UpdateCharacter"].append(NewPlayerDetails)
	
func client_parse(Client:Node, Data:Variant) -> void:
	for i in Data:
		var player = Client.NetworkPlayers.get_node_or_null(i["PhoneID"])
		if player != null:
			var Hub = player.Hub
			Client.Core.AssetData.Tools.generate_character_from_string(JSON.stringify(i["Character"]),Hub)
			Client.Core.AssetData.Tools.generate_accessories_from_string(JSON.stringify(i["Accessories"]),Hub)
			Hub.generate_character()
	
func client_compile(Client:Node) -> void:
	pass
