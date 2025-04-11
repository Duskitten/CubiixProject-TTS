extends Object

func server_parse(Server:Node, Player:ServerPlayer, Data:Variant) -> void:
	pass

func server_compile(Server:Node, Player:ServerPlayer, Messege:Dictionary) -> void:
	if Player.Current_Saved_Packet.has("TTS_ServerChatMessege"):
		Player.Current_Saved_Packet["TTS_ServerChatMessege"].append(Messege)
	else:
		Player.Current_Saved_Packet["TTS_ServerChatMessege"] = []
		Player.Current_Saved_Packet["TTS_ServerChatMessege"].append(Messege)
	
func client_parse(Client:Node, Data:Variant) -> void:
	for i in Data:
		Client.ChatManager.append_new_messege(Client.ChatManager.ChatTypes.SYSTEM,i)
	
func client_compile(Client:Node, Messege:String) -> void:
	pass

	
