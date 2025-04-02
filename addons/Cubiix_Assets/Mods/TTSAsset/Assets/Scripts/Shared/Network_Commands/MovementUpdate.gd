extends Node

func server_parse(Server:Node, Player:ServerPlayer, Data:Variant) -> void:
	for i in Data:
		Player.Character_Storage_Data[i] = Data[i]
	Server.Room_Manager.update_player_movement(Player.Character_Storage_Data["Current_Room"],Player)

func server_compile(Server:Node, Player:ServerPlayer) -> void:
	Player.Current_Saved_Packet["TTS_MovementUpdate"] = true

var OldPlayerPosition
var OldPlayerRotation
var OldPlayerModel_Rotation
var OldPlayerAnimation

func client_parse(Client:Node, Data:Variant) -> void:
	var Player = Client.Core.Persistant_Core.Player
	if OldPlayerPosition != Player.global_position || OldPlayerRotation != Player.global_rotation || OldPlayerModel_Rotation != Player.get_node("Hub").rotation || OldPlayerAnimation != Player.get_node("Hub").old_animation[0]:
		OldPlayerPosition = Player.global_position 
		OldPlayerRotation = Player.global_rotation 
		OldPlayerModel_Rotation = Player.get_node("Hub").rotation 
		OldPlayerAnimation = Player.get_node("Hub").old_animation[0]
		
		var compiled_movement = {
			"Position":OldPlayerPosition,
			"Rotation":OldPlayerRotation,
			"Model_Rotation":OldPlayerModel_Rotation,
			"Current_Animation":OldPlayerAnimation
		}
		
		Client.current_packet["TTS_MovementUpdate"] = compiled_movement
		
	
func client_compile(Client:Node) -> void:
	pass
