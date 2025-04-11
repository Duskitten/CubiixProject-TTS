class_name ServerPlayer
extends Node
var Server
var ValidationRequest = HTTPRequest.new()
var ValidationURLAppend = "/user/validateUser"
var DisconnectTimer:Timer = Timer.new()
var defaults = {
	"gamedata_VB_01_00":{
		"Character" : {"B1":"9ec0bd","B1E":"6e6c5f","B1ES":1,"B1M":0.7,"B1R":0,"B2":"354c56","B2E":"63665f","B2ES":1,"B2M":0,"B2R":1,"B3":"ff7e00","B3E":"ffb67c","B3ES":1,"B3M":0,"B3R":1,"B4":"ff7e00","B4E":"ffb67c","B4ES":1,"B4M":0,"B4R":1,"EA":"CoreAssets/Ears","EX":"CoreAssets/Extra","EY":"CoreAssets/Eyes_Default","N":"","PA":"","PB":"","PC":"","S":1,"T":"CoreAssets/Tails","W":"CoreAssets/Wings"},
		"Accessories": {"Head":"","Face":"","Chest":"","Back":"","L_Hip":"","R_Hip":"","L_Hand":"","R_Hand":""},
		"Unlocked_Accessories":{
			"Head":[
				"TTSAssets/Dock_Hat",
				"TTSAssets/Shroomby_Hat",
				"TTSAssets/Witch_Hat",
				"TTSAssets/DotMouse_Hat"
				],
			"Face":[
				"TTSAssets/Ki_Star_Shades"
				],
			"Chest":[
				"TTSAssets/Dock_Bib",
				"TTSAssets/LGBT_Bandanna",
				"TTSAssets/LGBT_Scarf"
				],
			"Back":[
				"TTSAssets/LGBT_Cape",
				"TTSAssets/FlyingV_Guitar"
				],
			"L_Hip":[],
			"R_Hip":[],
			"L_Hand":[],
			"R_Hand":[]
			}
		}
	}

var Character_Storage_Data = {
	"Disconnect":false,
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
		"IsAdmin":false,
		"IsOwner":false,
		"IsMuted":false
	},
	"DB_Version_Data":{

	},
	"NonPersistData":{
		"BackTP":Vector3.ZERO
	}
}

var Valid_Accessories = {
	"Head":[],
	"Face":[],
	"Chest":[],
	"Back":[],
	"L_Hip":[],
	"R_Hip":[],
	"L_Hand":[],
	"R_Hand":[]
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
	DisconnectTimer.autostart = false
	DisconnectTimer.wait_time = 30
	DisconnectTimer.one_shot = true
	DisconnectTimer.timeout.connect(end_timer.bind())
	add_child(DisconnectTimer)
	
	for i in Server.Database_Manager.gamedata_versions:
		Character_Storage_Data["DB_Version_Data"][i] = {}

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
	
			for i in Character_Storage_Data["DB_Version_Data"]["gamedata_VB_01_00"]["Unlocked_Accessories"]:
				for x in defaults["gamedata_VB_01_00"]["Unlocked_Accessories"][i]:
					if !Character_Storage_Data["DB_Version_Data"]["gamedata_VB_01_00"]["Unlocked_Accessories"][i].has(x):
						Character_Storage_Data["DB_Version_Data"]["gamedata_VB_01_00"]["Unlocked_Accessories"][i].append(x)
		
		Valid_Accessories = Character_Storage_Data["DB_Version_Data"]["gamedata_VB_01_00"]["Unlocked_Accessories"]
		#print(Valid_Accessories)
			
		Character_Storage_Data["DB_Data"]["UserID"] = url
		Character_Storage_Data["DB_Data"]["PhoneID"] = PhoneID
		
		if Server.Core.Globals.Data["BannedUserIDs"].has(PhoneID):
			Server.Commands["TTS_ServerChatMessege"].server_compile(Server,self,{"Messege":"Failed To Connect: You are banned from this server."})
			Character_Storage_Data["Disconnect"] = true
			return

		if Server.Real_Connections.has(Character_Storage_Data["DB_Data"]["PhoneID"]):
			Server.Commands["TTS_ServerChatMessege"].server_compile(Server,self,{"Messege":"Failed To Connect: This user is already connected."})
			Character_Storage_Data["Disconnect"] = true
			return
		else:
			Server.Real_Connections[Character_Storage_Data["DB_Data"]["PhoneID"]] = self
		
		update_perms()
		
		var AssignedRoomID = Server.Room_Manager.check_for_new_room(LastRoom)
		Server.Room_Manager.Rooms[AssignedRoomID]["Players"][PhoneID] = self
		Character_Storage_Data["Current_Room"] = AssignedRoomID
		#print(Server.Room_Manager.Rooms[AssignedRoomID]["Players"])
		Server.Room_Manager.notify_of_new_join(AssignedRoomID, self)
		Server.Room_Manager.spawn_current_users_data(AssignedRoomID, self)
		
		Server.Commands["TTS_SelfUpdateCharacter"].server_compile(Server,self)
		Server.Commands["TTS_SelfSpawnPlayer"].server_compile(Server,self)
		
		save_player()
		#await get_tree().create_timer(2).timeout
		#print("testing Save")


func check_for_updates(string:String) -> void:
	for i in defaults[string]:
		if !Character_Storage_Data["DB_Version_Data"][string].has(i):
			Character_Storage_Data["DB_Version_Data"][string][i] = defaults[string][i]

func update_perms() -> void:
	var PhoneID = Character_Storage_Data["DB_Data"]["PhoneID"]
	var isAdmin = false
	var isModerator = false
	var isOwner= false
	var isMuted = false
	
	if Server.Core.Globals.Data["Admins"].has(PhoneID):
		isAdmin = true
	if Server.Core.Globals.Data["Moderators"].has(PhoneID):
		isModerator = true
	if Server.Core.Globals.Data["Owners"].has(PhoneID):
		isOwner = true
	if Server.Core.Globals.Data["MutedUserIDs"].has(PhoneID):
		isMuted = true
	
	Character_Storage_Data["DB_Data"]["IsAdmin"] = isAdmin
	Character_Storage_Data["DB_Data"]["IsMod"] = isModerator
	Character_Storage_Data["DB_Data"]["IsOwner"] = isOwner
	Character_Storage_Data["DB_Data"]["IsMuted"] = isMuted

func save_player() -> void:
	var Database = Server.Database_Manager.Database
	var url = Character_Storage_Data["DB_Data"]["UserID"]
	var newtable = {
		"last_interaction" = Server.Room_Manager.Rooms[Character_Storage_Data["Current_Room"]]["MapID"]
	}
	for i in Server.Database_Manager.gamedata_versions:
		if Character_Storage_Data["DB_Version_Data"].has(i):
			newtable[i] = JSON.stringify(Character_Storage_Data["DB_Version_Data"][i])
	var DB =  Database.select_rows("PlayerInfo","userid is '"+url+"'",["*"])
	#print(DB)
	Database.update_rows("PlayerInfo","userid is '"+url+"'",newtable)

func validate_character_update(Data:Dictionary) -> void:
	
	if !Server.Core.AssetData.assets_tagged["Eyes"].has(Data["Character"]["EY"]):
		Data["Character"]["EY"] = "CoreAssets/Eyes_Default"
	if !Server.Core.AssetData.assets_tagged["Ears"].has(Data["Character"]["EA"]):
		Data["Character"]["EA"] = "CoreAssets/Ears"
	if !Server.Core.AssetData.assets_tagged["Extras"].has(Data["Character"]["EX"]):
		Data["Character"]["EX"] = "CoreAssets/Extra"
	if !Server.Core.AssetData.assets_tagged["Wings"].has(Data["Character"]["W"]):
		Data["Character"]["W"] = "CoreAssets/Wings"
	if !Server.Core.AssetData.assets_tagged["Tails"].has(Data["Character"]["T"]):
		Data["Character"]["T"] = "CoreAssets/Tails"

	if (!Server.Core.AssetData.assets_tagged["Head"].has(Data["Accessories"]["Head"]) || !Valid_Accessories["Head"].has(Data["Accessories"]["Head"])) && Data["Accessories"]["Head"].strip_edges(true,true) != "":
		Data["Accessories"]["Head"] = ""
	if (!Server.Core.AssetData.assets_tagged["Chest"].has(Data["Accessories"]["Chest"]) || !Valid_Accessories["Chest"].has(Data["Accessories"]["Chest"])) && Data["Accessories"]["Chest"].strip_edges(true,true) != "":
		Data["Accessories"]["Chest"] = ""
	if (!Server.Core.AssetData.assets_tagged["Face"].has(Data["Accessories"]["Face"])  || !Valid_Accessories["Face"].has(Data["Accessories"]["Face"])) && Data["Accessories"]["Face"].strip_edges(true,true) != "":
		Data["Accessories"]["Face"] = ""
	if (!Server.Core.AssetData.assets_tagged["Back"].has(Data["Accessories"]["Back"]) || !Valid_Accessories["Back"].has(Data["Accessories"]["Back"])) && Data["Accessories"]["Back"].strip_edges(true,true) != "":
		Data["Accessories"]["Back"] = ""
	if (!Server.Core.AssetData.assets_tagged["L_Hand"].has(Data["Accessories"]["L_Hand"]) || !Valid_Accessories["L_Hand"].has(Data["Accessories"]["L_Hand"])) && Data["Accessories"]["L_Hand"].strip_edges(true,true) != "":
		Data["Accessories"]["L_Hand"] = ""
	if (!Server.Core.AssetData.assets_tagged["R_Hand"].has(Data["Accessories"]["R_Hand"]) || !Valid_Accessories["R_Hand"].has(Data["Accessories"]["R_Hand"])) && Data["Accessories"]["R_Hand"].strip_edges(true,true) != "":
		Data["Accessories"]["R_Hand"] = ""
	if (!Server.Core.AssetData.assets_tagged["L_Hip"].has(Data["Accessories"]["L_Hip"]) || !Valid_Accessories["L_Hip"].has(Data["Accessories"]["L_Hip"])) && Data["Accessories"]["L_Hip"].strip_edges(true,true) != "" :
		Data["Accessories"]["L_Hip"] = ""
	if (!Server.Core.AssetData.assets_tagged["R_Hip"].has(Data["Accessories"]["R_Hip"]) || !Valid_Accessories["R_Hip"].has(Data["Accessories"]["R_Hip"])) && Data["Accessories"]["R_Hip"].strip_edges(true,true) != "" :
		Data["Accessories"]["R_Hip"] = ""
	
	
	
	Character_Storage_Data["DB_Version_Data"]["gamedata_VB_01_00"]["Character"] =  Data["Character"]
	Character_Storage_Data["DB_Version_Data"]["gamedata_VB_01_00"]["Accessories"] = Data["Accessories"]
	
	Server.Commands["TTS_SelfUpdateCharacter"].server_compile(Server,self)
	Server.Room_Manager.update_character(Character_Storage_Data["Current_Room"], self)
		

var lastcheck = 0

func start_timer() -> void:
	lastcheck += 1
	if lastcheck > 5:
	#print("Starting Disconnect!")
		DisconnectTimer.start()

func stop_timer() -> void:
	lastcheck = 0
	#print("Stopping Disconnect!")
	DisconnectTimer.stop()
	
func end_timer() -> void:
	Character_Storage_Data["Disconnect"] = true
