class_name CommandRunner
extends Node


func parse_command(Server:Node, Player:ServerPlayer, command:Array) -> void:
	if command.size() > 1:
		var response = {}
		match command[1].to_lower():
			"admin":
				if command.size() == 3:
					if Player.Character_Storage_Data["DB_Data"]["IsOwner"]:
						if Server.Database_Manager.is_valid_phonenumber(command[2]):
							if !Server.Core.Globals.Data["Admins"].has(command[2]):
								Server.Core.Globals.Data["Admins"].append(command[2])
								if Server.Core.Globals.Data["Moderators"].has(command[2]):
									Server.Core.Globals.Data["Moderators"].erase(command[2])
								if Server.Real_Connections.has(command[2]):
									Server.Real_Connections[command[2]].update_perms()
								response = {"Messege":"Added user to Admin list."}
							else:
								response = {"Messege":"Error: User is already Admin."}
						else:
							response = {"Messege":"Error: Invalid userID"}
					else:
						response = {"Messege":"Error: Insufficient Privileges"}
				else:
					response = {"Messege":"Error: command is\n/admin [user#]"}
			"unadmin":
				if command.size() == 3:
					if Player.Character_Storage_Data["DB_Data"]["IsOwner"]:
						if Server.Database_Manager.is_valid_phonenumber(command[2]):
							Server.Core.Globals.Data["Admins"].erase(command[2])
							if Server.Real_Connections.has(command[2]):
								Server.Real_Connections[command[2]].update_perms()
							response = {"Messege":"User unadmined."}
						else:
							response = {"Messege":"Error: Invalid userID"}
					else:
						response = {"Messege":"Error: Insufficient Privileges"}
				else:
					response = {"Messege":"Error: command is\n/unadmin [user#]"}
			"mod":
				if command.size() == 3:
					if Player.Character_Storage_Data["DB_Data"]["IsOwner"]:
						if Server.Database_Manager.is_valid_phonenumber(command[2]):
							if !Server.Core.Globals.Data["Moderators"].has(command[2]):
								Server.Core.Globals.Data["Moderators"].append(command[2])
								if Server.Core.Globals.Data["Admins"].has(command[2]):
									Server.Core.Globals.Data["Admins"].erase(command[2])
								if Server.Real_Connections.has(command[2]):
									Server.Real_Connections[command[2]].update_perms()
								response = {"Messege":"Added user to Moderators list."}
							else:
								response = {"Messege":"Error: User is already Moderator."}
						else:
							response = {"Messege":"Error: Invalid userID"}
					else:
						response = {"Messege":"Error: Insufficient Privileges"}
				else:
					response = {"Messege":"Error: command is\n/mod [user#]"}
			"unmod":
				if command.size() == 3:
					if Player.Character_Storage_Data["DB_Data"]["IsOwner"]:
						if Server.Database_Manager.is_valid_phonenumber(command[2]):
							Server.Core.Globals.Data["Moderators"].erase(command[2])
							if Server.Real_Connections.has(command[2]):
								Server.Real_Connections[command[2]].update_perms()
							response = {"Messege":"User unmodded."}
						else:
							response = {"Messege":"Error: Invalid userID"}
					else:
						response = {"Messege":"Error: Insufficient Privileges"}
				else:
					response = {"Messege":"Error: command is\n/unmod [user#]"}
			"kick":
				if command.size() == 3:
					if Player.Character_Storage_Data["DB_Data"]["IsAdmin"] || Player.Character_Storage_Data["DB_Data"]["IsOwner"] || Player.Character_Storage_Data["DB_Data"]["IsMod"]:
						if Server.Database_Manager.is_valid_phonenumber(command[2]):
							if Server.Core.Globals.Data["Owners"].has(command[2]) && (Player.Character_Storage_Data["DB_Data"]["IsAdmin"] || Player.Character_Storage_Data["DB_Data"]["IsMod"]):
								response = {"Messege":"Error: User is Higher Permission Level."}
							elif Server.Core.Globals.Data["Admins"].has(command[2]) && (Player.Character_Storage_Data["DB_Data"]["IsMod"]):
								response = {"Messege":"Error: User is Higher Permission Level."}
							else:
								if Server.Real_Connections.has(command[2]):
									Server.Commands["TTS_ServerChatMessege"].server_compile(Server,Server.Real_Connections[command[2]],{"Messege":"You have been kicked from the server."})
									Server.Real_Connections[command[2]].Character_Storage_Data["Disconnect"] = true
							response = {"Messege":"User kicked."}
						else:
							response = {"Messege":"Error: Invalid userID"}
					else:
						response = {"Messege":"Error: Insufficient Privileges"}
				else:
					response = {"Messege":"Error: command is\n/kick [user#]"}
			"ban":
				if command.size() == 3:
					if Player.Character_Storage_Data["DB_Data"]["IsAdmin"] || Player.Character_Storage_Data["DB_Data"]["IsOwner"]:
						if Server.Database_Manager.is_valid_phonenumber(command[2]):
							if Server.Core.Globals.Data["Owners"].has(command[2]) && Player.Character_Storage_Data["DB_Data"]["IsAdmin"]:
								response = {"Messege":"Error: User is Higher Permission Level."}
							else:
								if !Server.Core.Globals.Data["BannedUserIDs"].has(command[2]):
									Server.Core.Globals.Data["BannedUserIDs"].append(command[2])
									if Server.Real_Connections.has(command[2]):
										Server.Commands["TTS_ServerChatMessege"].server_compile(Server,Server.Real_Connections[command[2]],{"Messege":"You have been banned from the server."})
										Server.Real_Connections[command[2]].Character_Storage_Data["Disconnect"] = true
									response = {"Messege":"User banned."}
								else:
									response = {"Messege":"Error: User is already banned."}
						else:
							response = {"Messege":"Error: Invalid userID"}
					else:
						response = {"Messege":"Error: Insufficient Privileges"}
				else:
					response = {"Messege":"Error: command is\n/ban [user#]"}
			"unban":
				if command.size() == 3:
					if Player.Character_Storage_Data["DB_Data"]["IsAdmin"] || Player.Character_Storage_Data["DB_Data"]["IsOwner"]:
						if Server.Database_Manager.is_valid_phonenumber(command[2]):
							Server.Core.Globals.Data["BannedUserIDs"].erase(command[2])
							response = {"Messege":"User unbanned."}
						else:
							response = {"Messege":"Error: Invalid userID"}
					else:
						response = {"Messege":"Error: Insufficient Privileges"}
				else:
					response = {"Messege":"Error: command is\n/unban [user#]"}
			#"tp_to":
				#if command.size() == 3:
					#if Player.Character_Storage_Data["DB_Data"]["IsAdmin"] || Player.Character_Storage_Data["DB_Data"]["IsOwner"] || Player.Character_Storage_Data["DB_Data"]["IsMod"]:
						#if Server.Database_Manager.is_valid_phonenumber(command[2]):
							#pass
						#else:
							#response = {"Messege":"Error: Invalid userID"}
					#else:
						#response = {"Messege":"Error: Insufficient Privileges"}
				#else:
					#response = {"Messege":"Error: command is\n/tp_to [user#]"}
			#"tp_here":
				#if command.size() == 3:
					#if Player.Character_Storage_Data["DB_Data"]["IsAdmin"] || Player.Character_Storage_Data["DB_Data"]["IsOwner"] || Player.Character_Storage_Data["DB_Data"]["IsMod"]:
						#if Server.Database_Manager.is_valid_phonenumber(command[2]):
							#pass
						#else:
							#response = {"Messege":"Error: Invalid userID"}
					#else:
						#response = {"Messege":"Error: Insufficient Privileges"}
				#else:
					#response = {"Messege":"Error: command is\n/tp_here [user#]"}
			"mute":
				if command.size() == 3:
					if Player.Character_Storage_Data["DB_Data"]["IsAdmin"] || Player.Character_Storage_Data["DB_Data"]["IsOwner"] || Player.Character_Storage_Data["DB_Data"]["IsMod"]:
						if Server.Database_Manager.is_valid_phonenumber(command[2]):
							if Server.Core.Globals.Data["Owners"].has(command[2]) && (Player.Character_Storage_Data["DB_Data"]["IsAdmin"] || Player.Character_Storage_Data["DB_Data"]["IsMod"]):
								response = {"Messege":"Error: User is Higher Permission Level."}
							elif Server.Core.Globals.Data["Admins"].has(command[2]) && (Player.Character_Storage_Data["DB_Data"]["IsMod"]):
								response = {"Messege":"Error: User is Higher Permission Level."}
							else:
								if !Server.Core.Globals.Data["MutedUserIDs"].has(command[2]):
									Server.Core.Globals.Data["MutedUserIDs"].append(command[2])
									if Server.Real_Connections.has(command[2]):
										Server.Commands["TTS_ServerChatMessege"].server_compile(Server,Server.Real_Connections[command[2]],{"Messege":"You have been muted."})
										Server.Real_Connections[command[2]].update_perms()
									response = {"Messege":"User muted."}
								else:
									response = {"Messege":"Error: User is already muted."}
						else:
							response = {"Messege":"Error: Invalid userID"}
					else:
						response = {"Messege":"Error: Insufficient Privileges"}
				else:
					response = {"Messege":"Error: command is\n/mute [user#]"}
			"unmute":
				if command.size() == 3:
					if Player.Character_Storage_Data["DB_Data"]["IsAdmin"] || Player.Character_Storage_Data["DB_Data"]["IsOwner"] || Player.Character_Storage_Data["DB_Data"]["IsMod"]:
						if Server.Database_Manager.is_valid_phonenumber(command[2]):
							Server.Core.Globals.Data["MutedUserIDs"].erase(command[2])
							if Server.Real_Connections.has(command[2]):
								Server.Commands["TTS_ServerChatMessege"].server_compile(Server,Server.Real_Connections[command[2]],{"Messege":"You have been unmuted."})
								Server.Real_Connections[command[2]].update_perms()
							response = {"Messege":"User unmuted."}
						else:
							response = {"Messege":"Error: Invalid userID"}
					else:
						response = {"Messege":"Error: Insufficient Privileges"}
				else:
					response = {"Messege":"Error: command is\n/unmute [user#]"}
			#"tp_back":
				#if command.size() == 3:
					#if Player.Character_Storage_Data["DB_Data"]["IsAdmin"] || Player.Character_Storage_Data["DB_Data"]["IsOwner"] || Player.Character_Storage_Data["DB_Data"]["IsMod"]:
						#if Server.Database_Manager.is_valid_phonenumber(command[2]):
							#pass
						#else:
							#response = {"Messege":"Error: Invalid userID"}
					#else:
						#response = {"Messege":"Error: Insufficient Privileges"}
				#else:
					#response = {"Messege":"Error: command is\n/tp_back [user#]"}
					#
			#"emote":
				#if command.size() == 3:
					#pass
				#else:
					#response = {"Messege":"Error: command is\n/emote [emoteID]"}
			"commands":
				response = {"Messege":"CommandsList:\n"}
				if command.size() == 2:
					if Player.Character_Storage_Data["DB_Data"]["IsOwner"]:
						response["Messege"]+=\
						"/admin [user#]\n"+\
						"/unadmin [user#]\n"+\
						"/mod [user#]\n"+\
						"/unmod [user#]\n"
					if Player.Character_Storage_Data["DB_Data"]["IsAdmin"] || Player.Character_Storage_Data["DB_Data"]["IsOwner"]:
						response["Messege"]+=\
						"/ban [user#]\n"+\
						"/unban [user#]\n"
					if Player.Character_Storage_Data["DB_Data"]["IsAdmin"] || Player.Character_Storage_Data["DB_Data"]["IsMod"] || Player.Character_Storage_Data["DB_Data"]["IsOwner"]:
						response["Messege"]+=\
						"/kick [user#]\n"+\
						"/mute [user#]\n"+\
						"/unmute [user#]\n"+\
						"/commands"
					
		if !response.is_empty():
			Server.Commands["TTS_ServerChatMessege"].server_compile(Server,Player,response)
