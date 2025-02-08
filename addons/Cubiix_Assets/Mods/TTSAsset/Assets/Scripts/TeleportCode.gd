class_name TeleportationScript extends Node


func teleport_to_coords( player:CharacterBody3D, location:Vector3, rotation:Vector3 ) -> void:
	var char_control = player.get_node("Character_Controller")
	
	char_control.Movement_Disable = true
	char_control.Swimming = false
	
	player.global_position = location
	player.rotation = rotation
	
	# Note to self: Browse the documentation from time to time, features like these are useful!
	await get_tree().process_frame
	
	char_control.Movement_Disable = false
	
	queue_free()


func teleport_to_reference( player:CharacterBody3D, reference:Node3D ) -> void:
	var char_control = player.get_node("Character_Controller")
	
	char_control.Movement_Disable = true
	char_control.Swimming = false
	
	player.global_position = reference.global_position
	
	await get_tree().process_frame
	char_control.Movement_Disable = false
	
	queue_free()
