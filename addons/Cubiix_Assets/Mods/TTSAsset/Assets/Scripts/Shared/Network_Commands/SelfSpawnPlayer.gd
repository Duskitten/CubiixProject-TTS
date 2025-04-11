extends Object

func server_parse(Server:Node, Player:ServerPlayer, Data:Variant) -> void:
	pass

func server_compile(Server:Node, Player:ServerPlayer) -> void:
	Player.Current_Saved_Packet["TTS_SelfSpawnPlayer"] = {
		"Messeges":Server.Room_Manager.Rooms[Player.Character_Storage_Data["Current_Room"]]["LastChatLog"],
		"PhoneID":Player.Character_Storage_Data["DB_Data"]["PhoneID"]
	}
	
func client_parse(Client:Node, Data:Variant) -> void:
	for i in Data["Messeges"]:
		Client.ChatManager.append_new_messege(Client.ChatManager.ChatTypes.PLAYER,i)
	
	await Client.get_tree().create_timer(1).timeout
	Client.Core.TransitionController._on_texture_button_pressed("Offline", true, "Login")
	Client.Core.OfflineMenu.setup_online()
	
func client_compile(Client:Node) -> void:
	pass
