class_name TeleportObject extends Area3D

@onready var Persistant = get_node("/root/Main_Scene/Persistant")

@export var teleportation_target :Node3D

func _ready() -> void:
	body_entered.connect(_on_player_entered_teleportation_area)
	
	
	
func _on_player_entered_teleportation_area(body) -> void:
	
	
	if body.is_in_group("Player"):
		if Persistant.has_method("SpawnAt"):
			
			# I have to add the child otherwise it can't call await with the scenetree timer
			# Unless?
			var teleport = TeleportationScript.new()
			add_child(teleport)
			teleport.teleport_to_reference(body, teleportation_target)
