extends Object

func server_parse(Server:Node, Player:ServerPlayer, Data:Variant) -> void:
	var Core = Server.Core
	match Data["Type"]:
		"Polling_Server":
			Server.Commands["TTS_PollUpdate"].server_compile(Server,Player)
		"PlayerConnecting":
			if Core.Globals.GameVersion == Data["ClientVersion"]:
				Player.call_deferred("validate_player",Data)
			else:
				Player.Character_Storage_Data["Disconnect"] = true
				Player.Current_Saved_Packet["TTS_ServerChatMessege"] = "Wrong Game Version, Current Game Version: "+Core.Globals.GameVersion

func server_compile(Server:Node, Player:ServerPlayer) -> void:
	Player.Current_Saved_Packet["TTS_Ping_Init"] = "Hello, Who Are You?"
	
func client_parse(Client:Node, Data:Variant) -> void:
	client_compile(Client)

func client_compile(Client:Node) -> void:
	var Core = Client.Core
	if Client.ping_system_toggle:
		Client.current_packet["TTS_Ping_Init"] = {
			"Type":"Polling_Server"
			}
	else:
		Client.current_packet["TTS_Ping_Init"] = {
			"Type":"PlayerConnecting",
			"ClientVersion":Core.Globals.GameVersion,
			"Username":Core.Globals.LocalUser["Username"],
			"SecretKey":Core.Globals.LocalUser["UserSecretCode"],
			"Auth_URL":Core.Globals.Data["Auth_URL"],
			"API_URL":Core.Globals.Data["API_URL"],
			}
