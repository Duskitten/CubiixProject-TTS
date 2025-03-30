class_name ServerPlayer
extends Node3D

var ValidationRequest = HTTPRequest.new()
var ValidationURLAppend = "/user/validateUser"
var Character_Storage_Data = {
	"peer_obj":null,
	"Current_Room":"",
	"Player_OBJ_IDName":0,
	"Validated": false,
	"Position":Vector3.ZERO,
	"Old_Position":Vector3.ZERO,
	"Rotation":Vector3.ZERO,
	"Old_Rotation":Vector3.ZERO,
	"Model_Rotation":Vector3.ZERO,
	"Old_Model_Rotation":Vector3.ZERO,
	"Current_Animation":"",
	"Old_Current_Animation":"",
	"DirtyUpdate": false,
	"Core_Character":{
		"Character" : JSON.stringify({"B1":"9ec0bd","B1E":"6e6c5f","B1ES":1,"B1M":0.7,"B1R":0,"B2":"354c56","B2E":"63665f","B2ES":1,"B2M":0,"B2R":1,"B3":"ff7e00","B3E":"ffb67c","B3ES":1,"B3M":0,"B3R":1,"B4":"ff7e00","B4E":"ffb67c","B4ES":1,"B4M":0,"B4R":1,"EA":"CoreAssets/Ears","EX":"CoreAssets/Extra","EY":"CoreAssets/Eyes_Default","N":"","PA":"","PB":"","PC":"","S":1,"T":"CoreAssets/Tails","W":"CoreAssets/Wings"}),
		"Accessories": JSON.stringify({"Head_Slot":"","Face_Slot":"","Chest_Slot":"","Back_Slot":"","L_Hip_Slot":"","R_Hip_Slot":"","L_Hand_Slot":"","R_Hand_Slot":""})
	},
}

var Unlocked_Accessory_Data = {
	"Head_Slot":["","Head_Clothes/DotMouse_Hat","Head_Clothes/Generic_Helmet","Head_Clothes/MC_Deimos_Visor"],
	"Face_Slot":["","Face_Clothes/Nerd_Glasses","Face_Clothes/MC_Agent_Glasses"],
	"Chest_Slot":[""],
	"Back_Slot":[""],
	"L_Hip_Slot":[""],
	"R_Hip_Slot":[""],
	"L_Hand_Slot":[""],
	"R_Hand_Slot":[""],
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
	
func room_connect(userID:String) -> void:
	Current_Saved_Packet["Spawn_Players"].append(userID)
	
func room_disconnect(userID:String) -> void:
	Current_Saved_Packet["Despawn_Players"].append(userID)

func room_update_character(userID:String,new_char:Dictionary) -> void:
	if userID != Character_Storage_Data["Player_OBJ_IDName"]:
		Current_Saved_Packet["Update_Players"][userID] = new_char

func pos_overrider(userID:String, userobj:ServerPlayer) -> void:
	PosOverride[userobj.Character_Storage_Data["Player_OBJ_IDName"]] = {
		"Position":userobj.Character_Storage_Data["Position"],
		"Rotation":userobj.Character_Storage_Data["Rotation"],
		"Model_Rotation":userobj.Character_Storage_Data["Model_Rotation"],
		"Current_Animation":userobj.Character_Storage_Data["Current_Animation"]
	}

func validate_accessories(accessorystring:String) -> String:
	var accessorylist = JSON.parse_string(accessorystring)
	
	for i in accessorylist.keys():
		if !Unlocked_Accessory_Data[i].has(accessorylist[i]):
			accessorylist[i] = ""
			
	return JSON.stringify(accessorylist)

func validate_player(Server:Node ,Data:Dictionary)-> void:
	ValidationRequest.request(Data["API_URL"]+ValidationURLAppend,PackedStringArray(["userID:\""+Data["Username"]+"\"","userSecretCode:\""+Data["SecretKey"]+"\""]))
	Data.erase("SecretKey")
	ValidationRequest.request_completed.connect(validation_request_completed.bind(Server,Data))
	
func validation_request_completed(result, response_code, headers, body, Server:Node, Data:Dictionary):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	if response["status"] == 0:
		Character_Storage_Data["Validated"] = true
		
		var url:String = str(Data["Username"])+"@"+str(Data["Auth_URL"])
		var compiled_url = "select * from PlayerInfo where userid is '"+url+"';"
		Server.Database.query(compiled_url)
		var DB = Server.Database.query_result
		print(DB)
		if DB.is_empty():
			var newtable = {
				"phoneid":Server.generate_new_phonenumber(), 
				"userid" : url,
				"character" : "",
			}
			Server.Database.insert_row("PlayerInfo",newtable)
			print("Inserting Into DB")
		else:
			print("DB Found!")
			print(DB)
