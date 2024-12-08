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
}
