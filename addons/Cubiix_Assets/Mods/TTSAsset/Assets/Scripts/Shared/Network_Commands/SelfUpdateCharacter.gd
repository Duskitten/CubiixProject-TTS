extends Node

func server_parse(Server:Node, Player:ServerPlayer, Data:Variant) -> void:
	pass

func server_compile(Server:Node, Player:ServerPlayer) -> void:
	Player.Current_Saved_Packet["TTS_SelfUpdateCharacter"] = {
		"Character":Player.Character_Storage_Data["DB_Version_Data"]["gamedata_VB_01_00"]["Character"],
		"Accessories":Player.Character_Storage_Data["DB_Version_Data"]["gamedata_VB_01_00"]["Accessories"]
	}
	
func client_parse(Client:Node, Data:Variant) -> void:
	print(Data)
	var Hub = Client.Core.Persistant_Core.Player.Hub
	Client.Core.AssetData.Tools.generate_character_from_string(JSON.stringify(Data["Character"]),Hub)
	Client.Core.AssetData.Tools.generate_accessories_from_string(JSON.stringify(Data["Accessories"]),Hub)
	Hub.generate_character()
	Client.Core.Persistant_Core.TemplateChar.update_self_and_character()
	
func client_compile(Client:Node) -> void:
	pass
