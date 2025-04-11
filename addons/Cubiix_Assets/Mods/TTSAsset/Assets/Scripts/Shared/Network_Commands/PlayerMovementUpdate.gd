extends Object

func server_parse(Server:Node, Player:ServerPlayer, Data:Variant) -> void:
	pass

func server_compile(Server:Node, Player:ServerPlayer, NewPlayer:ServerPlayer) -> void:
	var NewPlayerDetails:Dictionary = {
		"Position":NewPlayer.Character_Storage_Data["Position"],
		"Rotation":NewPlayer.Character_Storage_Data["Rotation"],
		"Model_Rotation":NewPlayer.Character_Storage_Data["Model_Rotation"],
		"Current_Animation":NewPlayer.Character_Storage_Data["Current_Animation"],
		"PhoneID":NewPlayer.Character_Storage_Data["DB_Data"]["PhoneID"]
	}
	if Player.Current_Saved_Packet.has("TTS_PlayerMovementUpdate"):
		Player.Current_Saved_Packet["TTS_PlayerMovementUpdate"].append(NewPlayerDetails)
	else:
		Player.Current_Saved_Packet["TTS_PlayerMovementUpdate"] = []
		Player.Current_Saved_Packet["TTS_PlayerMovementUpdate"].append(NewPlayerDetails)

	
func client_parse(Client:Node, Data:Variant) -> void:
	for i in Data:
		var player = Client.NetworkPlayers.get_node_or_null(i["PhoneID"])
		if player != null:
			var charactercontroller = player.get_node_or_null("Network_Character_Controller")
			if charactercontroller != null:
				charactercontroller.stored_value["Position"]=i["Position"]
				charactercontroller.stored_value["Rotation"]=i["Rotation"]
				charactercontroller.stored_value["Model_Rotation"]=i["Model_Rotation"]
				charactercontroller.stored_value["Current_Animation"]=i["Current_Animation"]
		
func client_compile(Client:Node) -> void:
	pass
