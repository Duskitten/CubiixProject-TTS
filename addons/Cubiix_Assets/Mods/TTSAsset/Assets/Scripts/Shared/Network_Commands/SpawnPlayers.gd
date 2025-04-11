extends Object

func server_parse(Server:Node, Player:ServerPlayer, Data:Variant) -> void:
	pass

func server_compile(Server:Node, Player:ServerPlayer, NewPlayer:ServerPlayer) -> void:
	var NewPlayerDetails:Dictionary = {
		"Position":NewPlayer.Character_Storage_Data["Position"],
		"Rotation":NewPlayer.Character_Storage_Data["Rotation"],
		"Model_Rotation":NewPlayer.Character_Storage_Data["Model_Rotation"],
		"Current_Animation":NewPlayer.Character_Storage_Data["Current_Animation"],
		"Character_Character":NewPlayer.Character_Storage_Data["DB_Version_Data"]["gamedata_VB_01_00"]["Character"],
		"Character_Accessories":NewPlayer.Character_Storage_Data["DB_Version_Data"]["gamedata_VB_01_00"]["Accessories"],
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
		newPlayer.hide()
		newPlayer.name = i["PhoneID"]
		newPlayer.Load_Script_ID = ([
			"TTSAssets/Network_Character_Controller"
		] as Array[String])
		newPlayer.Load_Script_Passthrough = ([
			{}
		] as Array[Dictionary])
		newPlayer.Animation_Path = "TTSAssets/TTS_Player_Anims"
		newPlayer.Assets_Path = "/root/Main_Scene/CoreLoader/AssetData"
		newPlayer.Character_String = JSON.stringify(i["Character_Character"])
		newPlayer.Accessory_String = JSON.stringify(i["Character_Accessories"])
		Client.NetworkPlayers.call_deferred("add_child", newPlayer)
		await newPlayer.ScriptLoaded
		var netcontroller = newPlayer.get_node("Network_Character_Controller")
		netcontroller.stored_value = {
			"Position":i["Position"],
			"Rotation":i["Rotation"],
			"Model_Rotation":i["Model_Rotation"],
			"Current_Animation":i["Current_Animation"]
		}
		newPlayer.global_position = i["Position"]
		newPlayer.global_rotation = i["Rotation"]
		newPlayer.get_node("Hub").rotation = i["Model_Rotation"]
		newPlayer.show()
	
func client_compile(Client:Node) -> void:
	pass
