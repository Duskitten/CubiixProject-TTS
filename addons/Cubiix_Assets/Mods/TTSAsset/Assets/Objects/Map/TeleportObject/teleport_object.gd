class_name TeleportObject extends Area3D

@onready var Persistant = get_node("/root/Main_Scene/Persistant")

@export var teleportation_target :Node3D

func _ready() -> void:
	body_entered.connect(_on_player_entered_teleportation_area)
	
	
	
func _on_player_entered_teleportation_area(body) -> void:
	
	
	if body.is_in_group("Player"):
		if Persistant.has_method("SpawnAt"):
			var char_control = Persistant.Player.get_node("Character_Controller")
			
			char_control.Movement_Disable = true
			Persistant.Player.global_position = teleportation_target.global_position
			#Persistant.SpawnAt(teleportation_target.position, teleportation_target.rotation)
			await get_tree().create_timer(0.01).timeout
			char_control.Movement_Disable = false
			
			
			
			
			#char_control.Movem
