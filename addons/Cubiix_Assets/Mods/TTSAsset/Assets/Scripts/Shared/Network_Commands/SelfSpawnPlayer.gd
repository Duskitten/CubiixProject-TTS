extends Node

func server_parse(Server:Node, Player:ServerPlayer, Data:Variant) -> void:
	pass

func server_compile(Server:Node, Player:ServerPlayer) -> void:
	Player.Current_Saved_Packet["TTS_SelfSpawnPlayer"] = {
		"Messeges":Server.Room_Manager.Rooms[Player.Character_Storage_Data["Current_Room"]]["LastChatLog"],
		"PhoneID":Player.Character_Storage_Data["DB_Data"]["PhoneID"]
	}
	
func client_parse(Client:Node, Data:Variant) -> void:
	print("oioioi",Data)
	for i in Data["Messeges"]:
		Client.ChatManager.append_new_messege(Client.ChatManager.ChatTypes.PLAYER,i)
	
func client_compile(Client:Node) -> void:
	pass
