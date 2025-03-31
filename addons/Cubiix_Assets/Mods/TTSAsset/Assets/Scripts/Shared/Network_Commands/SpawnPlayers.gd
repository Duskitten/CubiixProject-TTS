extends Node

func server_parse(Data:Variant, Server:Node, Player:ServerPlayer) -> void:
	pass

func server_compile(Server:Node, Player:ServerPlayer, NewPlayer:ServerPlayer) -> void:
	var NewPlayerDetails:Dictionary = {
		"Position":NewPlayer.Character_Storage_Data["Position"],
		"Rotation":NewPlayer.Character_Storage_Data["Rotation"],
		"Model_Rotation":NewPlayer.Character_Storage_Data["Model_Rotation"],
		"Core_Character":NewPlayer.Character_Storage_Data["Core_Character"],
		"PhoneID":NewPlayer.Character_Storage_Data["DB_Data"]["PhoneID"]
	}
	if Player.Current_Saved_Packet.has("TTS_SpawnPlayers"):
		Player.Current_Saved_Packet["TTS_SpawnPlayers"].append(NewPlayerDetails)
	else:
		Player.Current_Saved_Packet["TTS_SpawnPlayers"] = []
		Player.Current_Saved_Packet["TTS_SpawnPlayers"].append(NewPlayerDetails)
	
func client_parse(Client:Node, Data:Variant) -> void:
	pass
	print(Data)
	
func client_compile(Client:Node) -> void:
	pass
