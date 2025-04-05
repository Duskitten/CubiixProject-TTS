class_name RoomManager
extends Node
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
var Server

var Rooms = {}

var RoomTemplate = {
	"MapID":"",
	"Players":{},
	"LastChatLog":[]
}

func check_for_new_room(RoomID:String) -> String:
	var Map:Dictionary = Core.AssetData.find_map(RoomID)
	if !Map.is_empty():
		if !Rooms.keys().is_empty():
			for i in Rooms.keys():
				if Rooms[i]["MapID"] == RoomID:
					if Rooms[i]["Players"].keys().size() < int(Core.Globals.Data["RoomMaxSize"]*80/100):
						return i
			return create_new_room(RoomID)
		else:
			return create_new_room(RoomID)
	else:
		#print("Error, Map Does Not Exist!")
		return ""

func create_new_room(RoomID:String) -> String:
	var intcount = 0
	#print("test?")
	while Rooms.keys().has(RoomID+"-"+str(intcount)):
		intcount += 1
	var new_roomname = RoomID+"-"+str(intcount)
	#print(new_roomname)
	var DupeDict = RoomTemplate.duplicate(true)
	DupeDict["MapID"] = RoomID
	Rooms[new_roomname] = DupeDict
	
	return new_roomname

func find_avaliable_rooms(RoomID:String) -> Array[String]:
	var RoomArray:Array[String] = []
	for n in Rooms.keys():
		if Rooms[n]["MapID"] == RoomID:
			if Rooms[n]["Players"].keys().size() < int(Core.Globals.Data["RoomMaxSize"]*80/100):
				RoomArray.append(n)
	return RoomArray

func notify_of_new_join(RoomName:String, User:ServerPlayer) -> void:
	for i in Rooms[RoomName]["Players"].keys():
		var plr = Rooms[RoomName]["Players"][i]
		if plr != User:
			Server.Commands["TTS_SpawnPlayers"].server_compile(Server,plr,User)

func notify_disconnect(RoomName:String, User:ServerPlayer) -> void:
	for i in Rooms[RoomName]["Players"].keys():
		var plr = Rooms[RoomName]["Players"][i]
		if plr != User:
			Server.Commands["TTS_DespawnPlayers"].server_compile(Server,plr,User)
	
	Rooms[RoomName]["Players"].erase(User.Character_Storage_Data["DB_Data"]["PhoneID"])

func spawn_current_users_data(RoomName:String, User:ServerPlayer) -> void:
	for i in Rooms[RoomName]["Players"].keys():
		var plr = Rooms[RoomName]["Players"][i]
		if plr != User:
			Server.Commands["TTS_SpawnPlayers"].server_compile(Server,User,plr)

func update_player_movement(RoomName:String, User:ServerPlayer) -> void:
	for i in Rooms[RoomName]["Players"].keys():
		var plr = Rooms[RoomName]["Players"][i]
		if plr != User:
			Server.Commands["TTS_PlayerMovementUpdate"].server_compile(Server,plr,User)

func update_chat(RoomName:String, User:ServerPlayer, Messeges:Dictionary) -> void:
	for i in Rooms[RoomName]["Players"].keys():
		var plr = Rooms[RoomName]["Players"][i]
		Server.Commands["TTS_ChatMessege"].server_compile(Server,plr,Messeges)

func update_character(RoomName:String, User:ServerPlayer) -> void:
	for i in Rooms[RoomName]["Players"].keys():
		var plr = Rooms[RoomName]["Players"][i]
		if plr != User:
			Server.Commands["TTS_UpdateCharacter"].server_compile(Server,plr,User)
