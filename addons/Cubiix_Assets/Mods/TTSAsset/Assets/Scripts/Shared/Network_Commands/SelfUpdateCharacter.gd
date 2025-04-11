extends Object

func server_parse(Server:Node, Player:ServerPlayer, Data:Variant) -> void:
	Player.validate_character_update(Data)

func server_compile(Server:Node, Player:ServerPlayer) -> void:
	Player.Current_Saved_Packet["TTS_SelfUpdateCharacter"] = {
		"Character":Player.Character_Storage_Data["DB_Version_Data"]["gamedata_VB_01_00"]["Character"],
		"Accessories":Player.Character_Storage_Data["DB_Version_Data"]["gamedata_VB_01_00"]["Accessories"]
	}
	
	
func client_parse(Client:Node, Data:Variant) -> void:
	var Hub = Client.Core.Persistant_Core.Player.Hub
	Client.Core.AssetData.Tools.generate_character_from_string(JSON.stringify(Data["Character"]),Hub)
	Client.Core.AssetData.Tools.generate_accessories_from_string(JSON.stringify(Data["Accessories"]),Hub)
	Hub.generate_character()
	Client.Core.Persistant_Core.TemplateChar.update_self_and_character()
	
func client_compile(Client:Node) -> void:
	var character = JSON.parse_string(Client.Core.AssetData.Tools.export_character(Client.Core.Persistant_Core.TemplateChar.character))
	var accessories = JSON.parse_string(Client.Core.AssetData.Tools.export_accessories(Client.Core.Persistant_Core.TemplateChar.character))
	Client.current_packet["TTS_SelfUpdateCharacter"] = {
		"Character":character,
		"Accessories":accessories
	}
	
