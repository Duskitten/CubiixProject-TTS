class_name ServerPlayer
extends Node3D

var Character_Storage_Data = {
	"peer_obj":null,
	"Current_Room":"",
	"Player_OBJ_IDName":"",
	
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
	"Disconnected":true,
	
	"Validated":false
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
