class_name ServerPlayer
extends Node3D

var Character_Storage_Data = {
	"Current_Room":"",
	"Player_OBJ_IDName":"",
	"Position":Vector3.ZERO,
	"Rotation":Vector3.ZERO,
	"Model_Rotation":Vector3.ZERO,
	"Current_Animation":"",
	"Core_Character":JSON.stringify({"B1":"5f5f5f","B1E":"000000","B1ES":1,"B1M":0,"B1R":1,"B2":"c6c6c6","B2E":"000000","B2ES":1,"B2M":0,"B2R":1,"B3":"cc8a5d","B3E":"cc8a5d","B3ES":1,"B3M":0,"B3R":1,"B4":"cc8a5d","B4E":"cc8a5d","B4ES":1,"B4M":0,"B4R":1,"EA":0,"EX":0,"EY":0,"N":"","PA":"","PB":"","PC":"","S":1,"T":0,"W":0}),
	"Extra_Character":"",
	"Disconnected":true,
	"Peer_Obj":null,
	"Validated":false
}

var Current_Saved_Packet = {
	"Spawn_Players" : [],
	"Despawn_Players" : [],
	"Update_Players" : {}
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

func room_update_character(userID:String,new_char:String) -> void:
	Current_Saved_Packet["Update_Players"][userID] = new_char
