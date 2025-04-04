class_name ServerPlayer
extends Node3D
var Server
var ValidationRequest = HTTPRequest.new()
var ValidationURLAppend = "/user/validateUser"

var defaults = {
	"gamedata_VB_01_00":{
		"Character" : {"B1":"9ec0bd","B1E":"6e6c5f","B1ES":1,"B1M":0.7,"B1R":0,"B2":"354c56","B2E":"63665f","B2ES":1,"B2M":0,"B2R":1,"B3":"ff7e00","B3E":"ffb67c","B3ES":1,"B3M":0,"B3R":1,"B4":"ff7e00","B4E":"ffb67c","B4ES":1,"B4M":0,"B4R":1,"EA":"CoreAssets/Ears","EX":"CoreAssets/Extra","EY":"CoreAssets/Eyes_Default","N":"","PA":"","PB":"","PC":"","S":1,"T":"CoreAssets/Tails","W":"CoreAssets/Wings"},
		"Accessories": {"Head":"","Face":"","Chest":"","Back":"","L_Hip":"","R_Hip":"","L_Hand":"","R_Hand":""},
		"Olive":{}
		}
	}

var Character_Storage_Data = {
	"peer_obj":null,
	"Current_Room":"",
	"Player_OBJ_IDName":"",
	"Validated": false,
	"Position":Vector3.ZERO,
	"Old_Position":Vector3.ZERO,
	"Rotation":Vector3.ZERO,
	"Old_Rotation":Vector3.ZERO,
	"Model_Rotation":Vector3.ZERO,
	"Old_Model_Rotation":Vector3.ZERO,
	"Current_Animation":"Idle",
	"Old_Current_Animation":"",
	"DirtyUpdate": false,
	"DB_Data":{
		"UserID":"",
		"PhoneID":"",
		"IsMod":false,
		"IsAdmin":false
	},
	"DB_Version_Data":{
		
	}
}

var PosOverride = {
	
}

var Current_Saved_Packet = {
}

var Current_Saved_Packet_Template = {
	"Spawn_Players" : [],
	"Despawn_Players" : [],
	"Update_Players" : {}
}

func _ready() -> void:
	add_child(ValidationRequest)
	
	for i in Server.Database_Manager.gamedata_versions:
		Character_Storage_Data["DB_Version_Data"][i] = {}

func validate_accessories(accessorystring:String) -> String:
	return ""

func validate_player(Data:Dictionary)-> void:
	ValidationRequest.request(Data["API_URL"]+ValidationURLAppend,PackedStringArray(["userID:\""+Data["Username"]+"\"","userSecretCode:\""+Data["SecretKey"]+"\""]))
	Data.erase("SecretKey")
	ValidationRequest.request_completed.connect(validation_request_completed.bind(Data))
	
func validation_request_completed(result, response_code, headers, body, Data:Dictionary):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	if response["status"] == 0:
		Character_Storage_Data["Validated"] = true
		var Database = Server.Database_Manager.Database
		var url:String = str(Data["Username"])+"@"+str(Data["Auth_URL"])
		var DB =  Database.select_rows("PlayerInfo","userid is '"+url+"'",["*"])
		#print(DB)
		var PhoneID = ""
		var LastRoom = "TTSAssets/Hexstaria_V2"
		if DB.is_empty():
			var newtable = {
				"phoneid":Server.Database_Manager.generate_new_phonenumber(), 
				"userid" : url,
				"last_interaction":LastRoom,
			}
			PhoneID = newtable["phoneid"]
			Database.insert_row("PlayerInfo",newtable)
			for i in Server.Database_Manager.gamedata_versions:
				Character_Storage_Data["DB_Version_Data"][i] = defaults[i]
			#print("Inserting Into DB")
		else:
			#print("DB Found!")
			#print(DB)
			PhoneID = DB[0]["phoneid"]
			LastRoom = DB[0]["last_interaction"]
			for i in DB[0].keys():
				if Server.Database_Manager.gamedata_versions.has(i):
					Character_Storage_Data["DB_Version_Data"][i] = JSON.parse_string(DB[0][i])
					check_for_updates(i)
					
		
		Character_Storage_Data["DB_Data"]["UserID"] = url
		Character_Storage_Data["DB_Data"]["PhoneID"] = PhoneID
		
		Server.Real_Connections[Character_Storage_Data["DB_Data"]["PhoneID"]] = self
		
		var AssignedRoomID = Server.Room_Manager.check_for_new_room(LastRoom)
		Server.Room_Manager.Rooms[AssignedRoomID]["Players"][PhoneID] = self
		Character_Storage_Data["Current_Room"] = AssignedRoomID
		#print(Server.Room_Manager.Rooms[AssignedRoomID]["Players"])
		Server.Room_Manager.notify_of_new_join(AssignedRoomID, self)
		Server.Room_Manager.spawn_current_users_data(AssignedRoomID, self)
		
		Server.Commands["TTS_SelfUpdateCharacter"].server_compile(Server,self)
		
		save_player(Server)
		#await get_tree().create_timer(2).timeout
		#print("testing Save")


func check_for_updates(string:String) -> void:
	for i in defaults[string]:
		if !Character_Storage_Data["DB_Version_Data"][string].has(i):
			Character_Storage_Data["DB_Version_Data"][string][i] = defaults[string][i]


func save_player(Server:Node) -> void:
	var Database = Server.Database_Manager.Database
	var url = Character_Storage_Data["DB_Data"]["UserID"]
	var newtable = {
		"last_interaction" = Server.Room_Manager.Rooms[Character_Storage_Data["Current_Room"]]["MapID"]
	}
	for i in Server.Database_Manager.gamedata_versions:
		if Character_Storage_Data["DB_Version_Data"].has(i):
			newtable[i] = JSON.stringify(Character_Storage_Data["DB_Version_Data"][i])
	var DB =  Database.select_rows("PlayerInfo","userid is '"+url+"'",["*"])
	print(DB)
	Database.update_rows("PlayerInfo","userid is '"+url+"'",newtable)
