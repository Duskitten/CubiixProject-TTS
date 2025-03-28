extends Node

func server_parse(Server:Node, Player:ServerPlayer, Data:Variant) -> void:
	match Data:
		"Polling_Server":
			Server.Commands["TTS_PollUpdate"].server_compile(Server,Player)
		"PlayerConnecting":
			pass

func server_compile(Server:Node, Player:ServerPlayer) -> void:
	Player.Current_Saved_Packet["TTS_Ping_Init"] = "Hello, Who Are You?"
	
func client_parse(Client:Node, Data:Variant) -> void:
	client_compile(Client)

func client_compile(Client:Node) -> void:
	if Client.ping_system_toggle:
		Client.current_packet["TTS_Ping_Init"] = "Polling_Server"
	else:
		Client.current_packet["TTS_Ping_Init"] = "PlayerConnecting"
