extends StaticBody3D

@onready var Core = get_node("/root/Main_Scene/CoreLoader")
@onready var Player_Lock = $CharacterBody3D/Player_Lock
@onready var Player_Mover = $CharacterBody3D
@export var Offset_vector:Vector3
@onready var Particles:CPUParticles3D = $CharacterBody3D/CPUParticles3D
var Player:Node
var Player_Script:Node
var Normal:Vector3
var compiled_velocity:Vector3
@export var swim_speed:float = 1.2

var Collider = CollisionShape3D.new()
var CollisionShape:CapsuleShape3D = CapsuleShape3D.new()
var RayCast1:RayCast3D = RayCast3D.new()
var Sploosh_Peices = ResourceLoader.load("res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Objects/Map/sploosh.tscn","",ResourceLoader.CACHE_MODE_REPLACE).instantiate()

func _ready() -> void:
	## Setting up the collision shapes
	CollisionShape.radius = 0.202
	CollisionShape.height = 0.735
	CollisionShape.margin = 0.4
	Collider.shape = CollisionShape
	Collider.position = Vector3(0,0.5,0)
	RayCast1.target_position = Vector3(0,-0.2,0)
	RayCast1.position = Vector3(0,0.214,0)
	RayCast1.set_collision_mask_value(1,false)
	RayCast1.set_collision_mask_value(2,true)
	RayCast1.exclude_parent = true
	Player_Mover.add_child(RayCast1)
	## Adding all required nodes
	Player_Mover.add_child(Collider)

func _physics_process(delta: float) -> void:
	if Player != null:
		if Input.is_action_just_pressed("ui_jump"):
			player_unlock(true)
		if RayCast1.is_colliding():
			player_unlock(false)
		
		if Player_Script != null && Player != null:
			var input:Vector2
			if !Player_Script.velocity_lock:
				input = Player_Script.input
			else:
				input = Player_Script.Alt_Input
			compiled_velocity += ((Player_Script.MoveMarker.global_transform.basis.z * clamp(abs(input.y)+abs(input.x),0,1)) * swim_speed) 
			
			Player_Mover.velocity = compiled_velocity
			Player_Mover.move_and_slide()
			compiled_velocity = compiled_velocity.slerp(Vector3.ZERO,0.4)
		
func player_lock(Insert_Player:Node, Start_Pos:Vector3, Insert_PlayerScript:Node, Start_Normal:Vector3) -> void:
	if Insert_Player != null:
		var sploosh = Sploosh_Peices.duplicate()
		Player_Mover.global_position = Start_Pos + Offset_vector
		Player = Insert_Player
		Player_Script = Insert_PlayerScript
		Player_Mover.global_transform.basis = align_up(Player_Mover.basis,Start_Normal,1)
		Insert_Player.global_transform.basis = align_up(Player_Mover.basis,Start_Normal,1)
		Player_Lock.remote_path = Player_Lock.get_path_to(Insert_Player)
		add_child(sploosh)
		
		if Particles != null:
			Particles.emitting = true
			if Player_Script.falling:
				sploosh.global_transform = Particles.global_transform
				sploosh.get_node("AnimationPlayer").play("Sploosh")
				sploosh.get_node("AnimationPlayer").animation_finished.connect(kill_sploosh.bind(sploosh))

func player_unlock(Jump:bool) -> void:
	Player_Lock.remote_path = NodePath("")
	Player = null
	if Player_Script != null:
		Player_Script.Swimming = false
		Player_Script.Movement_Disable = false
		if Particles != null:
				Particles.emitting = false
		if Jump:
			Player_Script.AltJump = true
		Player_Script.RayCast_Swim.enabled = true
		Player_Script = null

func align_up(node_basis, normal, slerptime):
	var result = Basis()
	result.x = normal.cross(node_basis.z)
	result.y = normal
	result.z = node_basis.x.cross(normal)
	
	result = node_basis.slerp(result.orthonormalized(),slerptime)
	return result

func kill_sploosh(Anim:StringName, node:Node) -> void:
	node.queue_free()
