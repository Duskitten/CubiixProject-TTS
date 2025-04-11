extends Object

func server_parse(Server:Node, Player:ServerPlayer, Data:Variant) -> void:

	for i in Data:
		if (i as String).begins_with("/"):
			var commandParser = CommandParser.new()
			var commandRunner = CommandRunner.new()
			var Command = commandParser.parse_data(i)
			commandRunner.parse_command(Server, Player, Command)
	
		else:
			if !Server.Core.Globals.Data["MutedUserIDs"].has(Player.Character_Storage_Data["DB_Data"]["PhoneID"]):
				var TextDictionary = {
					"Messege":i,
					"SenderPhone":Player.Character_Storage_Data["DB_Data"]["PhoneID"],
					"SenderName":Player.Character_Storage_Data["DB_Version_Data"]["gamedata_VB_01_00"]["Character"]["N"],
					"Elevations":[Player.Character_Storage_Data["DB_Data"]["IsMod"],Player.Character_Storage_Data["DB_Data"]["IsAdmin"]]
				}
				Server.Room_Manager.update_chat(Player.Character_Storage_Data["Current_Room"], Player, TextDictionary)
				Server.Room_Manager.Rooms[Player.Character_Storage_Data["Current_Room"]]["LastChatLog"].append(TextDictionary)
				if Server.Room_Manager.Rooms[Player.Character_Storage_Data["Current_Room"]]["LastChatLog"].size() > 15:
					Server.Room_Manager.Rooms[Player.Character_Storage_Data["Current_Room"]]["LastChatLog"].pop_front()
			else:
				Server.Commands["TTS_ServerChatMessege"].server_compile(Server,Player,{"Messege":"You are muted."})

func server_compile(Server:Node, Player:ServerPlayer, Messege:Dictionary) -> void:
	if Player.Current_Saved_Packet.has("TTS_ChatMessege"):
		Player.Current_Saved_Packet["TTS_ChatMessege"].append(Messege)
	else:
		Player.Current_Saved_Packet["TTS_ChatMessege"] = []
		Player.Current_Saved_Packet["TTS_ChatMessege"].append(Messege)
	
func client_parse(Client:Node, Data:Variant) -> void:
	for i in Data:
		Client.ChatManager.append_new_messege(Client.ChatManager.ChatTypes.PLAYER,i)
	
func client_compile(Client:Node, Messege:String) -> void:
	if Client.TCP.get_status() == StreamPeerTCP.STATUS_CONNECTED:
		if Client.current_packet.has("TTS_ChatMessege"):
			Client.current_packet["TTS_ChatMessege"].append(Messege)
		else:
			Client.current_packet["TTS_ChatMessege"] = []
			Client.current_packet["TTS_ChatMessege"].append(Messege)

	
