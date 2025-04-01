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
	for i in Data:
		var newPlayer = load("res://addons/Cubiix_Assets/Scenes/Cubiix_Character.tscn").instantiate()
		newPlayer.name = i["PhoneID"]
		newPlayer.Load_Script_ID = ([
			"TTSAssets/Network_Character_Controller"
		] as Array[String])
		newPlayer.Load_Script_Passthrough = ([
			{}
		] as Array[Dictionary])
		newPlayer.Animation_Path = "TTSAssets/TTS_Player_Anims"
		newPlayer.Assets_Path = "/root/Main_Scene/CoreLoader/AssetData"
		newPlayer.Character_String = i["Core_Character"]["Character"]
		newPlayer.Accessory_String = i["Core_Character"]["Accessories"]
		Client.NetworkPlayers.call_deferred("add_child", newPlayer)
	
func client_compile(Client:Node) -> void:
	pass
