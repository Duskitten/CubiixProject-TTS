class_name CommandRunner
extends Node


func parse_command(Server:Node, Player:ServerPlayer, command:Array) -> void:
	if command.size() > 1:
		var response = {}
		match command[1].to_lower():
			"admin":
				if command.size() == 3:
					if Player.Player.Character_Storage_Data["DB_Data"]["IsOwner"]:
						pass
					else:
						response = {"Messege":"Error: Insufficient Privileges"}
				else:
					response = {"Messege":"Error: command is\n/admin [user#]"}
			"mod":
				if command.size() == 3:
					if Player.Player.Character_Storage_Data["DB_Data"]["IsAdmin"] || Player.Player.Character_Storage_Data["DB_Data"]["IsOwner"]:
						pass
					else:
						response = {"Messege":"Error: Insufficient Privileges"}
				else:
					response = {"Messege":"Error: command is\n/mod [user#]"}
			"kick":
				if command.size() == 3:
					if Player.Player.Character_Storage_Data["DB_Data"]["IsAdmin"] || Player.Player.Character_Storage_Data["DB_Data"]["IsOwner"] || Player.Player.Character_Storage_Data["DB_Data"]["IsMod"]:
						pass
					else:
						response = {"Messege":"Error: Insufficient Privileges"}
				else:
					response = {"Messege":"Error: command is\n/kick [user#]"}
			"ban":
				if command.size() == 3:
					if Player.Player.Character_Storage_Data["DB_Data"]["IsAdmin"] || Player.Player.Character_Storage_Data["DB_Data"]["IsOwner"]:
						pass
					else:
						response = {"Messege":"Error: Insufficient Privileges"}
				else:
					response = {"Messege":"Error: command is\n/ban [user#]"}
			"tp_to":
				if command.size() == 3:
					if Player.Player.Character_Storage_Data["DB_Data"]["IsAdmin"] || Player.Player.Character_Storage_Data["DB_Data"]["IsOwner"] || Player.Player.Character_Storage_Data["DB_Data"]["IsMod"]:
						pass
					else:
						response = {"Messege":"Error: Insufficient Privileges"}
				else:
					response = {"Messege":"Error: command is\n/tp_to [user#]"}
			"tp_here":
				if command.size() == 3:
					if Player.Player.Character_Storage_Data["DB_Data"]["IsAdmin"] || Player.Player.Character_Storage_Data["DB_Data"]["IsOwner"] || Player.Player.Character_Storage_Data["DB_Data"]["IsMod"]:
						pass
					else:
						response = {"Messege":"Error: Insufficient Privileges"}
				else:
					response = {"Messege":"Error: command is\n/tp_here [user#]"}
			"mute":
				if command.size() == 3:
					if Player.Player.Character_Storage_Data["DB_Data"]["IsAdmin"] || Player.Player.Character_Storage_Data["DB_Data"]["IsOwner"] || Player.Player.Character_Storage_Data["DB_Data"]["IsMod"]:
						pass
					else:
						response = {"Messege":"Error: Insufficient Privileges"}
				else:
					response = {"Messege":"Error: command is\n/mute [user#]"}
			"tp_back":
				if command.size() == 3:
					if Player.Player.Character_Storage_Data["DB_Data"]["IsAdmin"] || Player.Player.Character_Storage_Data["DB_Data"]["IsOwner"] || Player.Player.Character_Storage_Data["DB_Data"]["IsMod"]:
						pass
					else:
						response = {"Messege":"Error: Insufficient Privileges"}
				else:
					response = {"Messege":"Error: command is\n/tp_back [user#]"}
					
			"emote":
				if command.size() == 3:
					pass
				else:
					response = {"Messege":"Error: command is\n/emote [emoteID]"}
					
		if !response.is_empty():
			Server.Commands["TTS_ServerChatMessege"].server_compile(Server,Player,response)
