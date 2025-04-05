extends Node
@onready var Character:CharacterBody3D = get_parent()

@onready var Hub:Node3D = Character.get_node("Hub")

var Lookat = Cubiix_LookAtBone.new()
var snap_ray:RayCast3D = RayCast3D.new()

var NPC_Name = ""
var PassThroughAnimation = "Idle":
	set(value):
		PassThroughAnimation = value
		print("set!", value)
var NPC_Dialogue_Point = ""

func _ready() -> void:
	await Hub.Skeleton_Added
	Hub.update_animation([PassThroughAnimation,0.0])
	snap_ray.target_position = Vector3(0,-10000,0)
	Character.add_child(snap_ray)
	
func _physics_process(delta: float) -> void:
	if snap_ray != null:
		if snap_ray.is_colliding():
			Character.position = snap_ray.get_collision_point()
			snap_ray.queue_free()
	
