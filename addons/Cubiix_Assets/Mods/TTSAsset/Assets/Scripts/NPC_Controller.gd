extends Node
@onready var Character:CharacterBody3D = get_parent()

@onready var Hub:Node3D = Character.get_node("Hub")

var Lookat = Cubiix_LookAtBone.new()
var snap_ray:RayCast3D = RayCast3D.new()

var NPC_Name = ""
var NPC_Dialogue_Point = ""

func _ready() -> void:
	await Hub.Skeleton_Added
	Hub.update_animation(["Idle",0.0])
	Lookat.Use_BoneName = "Head"
	
	if Hub.Character_Skeleton != null:
		print("Meow")
		Hub.Character_Skeleton.add_child(Lookat)
	Lookat.setup()
	var collider = CollisionShape3D.new()
	collider.shape = SphereShape3D.new()
	collider.shape.radius = 2.0
	var area = Area3D.new()
	area.add_child(collider)
	add_child(area)
	area.body_entered.connect(set_target.bind())
	area.body_exited.connect(remove_target.bind())
	
	area.set_collision_mask_value(1,false)
	area.set_collision_mask_value(2,true)
	area.set_collision_layer_value(1,false)
	area.set_collision_layer_value(2,true)
	
	snap_ray.target_position = Vector3(0,-10000,0)
	Character.add_child(snap_ray)
	
func _physics_process(delta: float) -> void:
	if snap_ray != null:
		if snap_ray.is_colliding():
			Character.position = snap_ray.get_collision_point()
			snap_ray.queue_free()

func set_target(collider) -> void:
	if collider.is_in_group("Player"):
		Lookat.Target = collider.get_node("MoveMarker")
	
func remove_target(collider) -> void:
	if collider.is_in_group("Player"):
		print("Hai")
		Lookat.Target = null
