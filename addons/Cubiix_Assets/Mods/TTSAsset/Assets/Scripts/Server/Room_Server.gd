class_name ServerRoom
extends Node

var NewCollisionZone = PhysicsSpace3D.new()

var Room_Storage_Data = {
	"Players":[]
}

func _ready() -> void:
	add_child(NewCollisionZone)
