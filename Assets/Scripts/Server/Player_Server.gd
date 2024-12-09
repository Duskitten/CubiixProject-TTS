class_name ServerPlayer
extends Node3D

var Character_Storage_Data = {
	"Current_Room":"",
	"Player_OBJ_IDName":"",
	"Position":Vector3.ZERO,
	"Rotation":Vector3.ZERO,
	"Model_Rotation":Vector3.ZERO,
	"Current_Animation":"",
	"Current_Character":"",
	"Disconnected":true,
	"Peer_Obj":null,
	"Validated":false
}

var Current_Saved_Packet = {
	"Spawn_Players" : [],
	"Despawn_Players" : []
}

var Current_Saved_Packet_Template = {
	"Spawn_Players" : [],
	"Despawn_Players" : []
}

func room_connect(userID:String) -> void:
	Current_Saved_Packet["Spawn_Players"].append(userID)
	
func room_disconnect(userID:String) -> void:
	Current_Saved_Packet["Despawn_Players"].append(userID)
