extends Node3D
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
## Get the actual player object
@onready var ControllerID = 0
@onready var Character:CharacterBody3D = get_parent()

## This is the mesh root itself
@onready var Hub:Node3D = Character.get_node("Hub")

## Camera variables for movement
var Camera_Core:Node3D
var Camera_Y:Node3D
var Camera_X:Node3D
var Camera_Z:SpringArm3D
var Camera:Camera3D

## This is our Player Collider Setup
var Collider = CollisionShape3D.new()
var CollisionShape:CapsuleShape3D = CapsuleShape3D.new()

## Floor Check RayCasts
var RayCast1:RayCast3D = RayCast3D.new()
var RayCast2:RayCast3D = RayCast3D.new()
var RayCast3:RayCast3D = RayCast3D.new()

var MoveMarker:Marker3D =  Marker3D.new()

## This is used when we actually do our falling checks to prevent infinite falls
var JumpTimer:Timer = Timer.new()

## This is for keyboard input to ask what local Direction
var input:Vector2

## This is a toggle for wall walking and stuff
var anti_grav_enabled = false

## Movement Speeds
const walkspeed = .5
const runspeed = 3
const jumpspeed = 6

## Current active speed
var speed:float = 3
var swim_speed:float = 1.2
var compiled_velocity = Vector3.ZERO
var walk = false

## Gravity related stuff
const gravity = -0.98 * 2
var gravity_control:Vector3 = Vector3.ZERO
var jumping = false
var falling = false
var fall_timer = 0
var forcingUp = false
var AltJump = false
var Fall_Delta = 0
var Fall_Delta_Prev = 0
var Fall_Tick = 0

var CameraController = null
var Current_Animation = ""
var IsEmoting = false

var Movement_Disable = false
var Alt_Input:Vector2
var velocity_lock = false

## Swimming controller variables
var RayCast_Swim:RayCast3D = RayCast3D.new()
var Swimming = false
var current_swim_particles:Node
var swim_pos:Vector3

var sploosh = load("res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Objects/Client/Map/Water/sploosh.tscn").instantiate()
var particles = load("res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Objects/Client/Map/Water/water_particles.tscn").instantiate()

func _init() -> void:
	## Disable these to prevent "Null" errors before load.
	set_process(false)
	set_physics_process(false)

func setup():
	
	## Setting up the collision shapes
	CollisionShape.radius = 0.202
	CollisionShape.height = 0.735
	CollisionShape.margin = 0.4
	Collider.shape = CollisionShape
	Collider.position = Vector3(0,0.5,0)
	
	## Add ray length
	RayCast1.target_position = Vector3(0,-0.24,0)
	RayCast2.target_position = Vector3(0,-0.24,0)
	RayCast3.target_position = Vector3(0,-0.4,0)
	RayCast_Swim.target_position = Vector3(0,-0.2,0)
	
	RayCast1.position = Vector3(0,0.214,0)
	RayCast2.position = Vector3(0,0.214,0)
	RayCast3.position = Vector3(0,0.214,0)
	RayCast_Swim.position = Vector3(0,0.7,0)
	
	RayCast1.set_collision_mask_value(1,false)
	RayCast1.set_collision_mask_value(2,true)
	RayCast2.set_collision_mask_value(1,false)
	RayCast2.set_collision_mask_value(2,true)
	RayCast3.set_collision_mask_value(1,false)
	RayCast3.set_collision_mask_value(2,true)
	RayCast_Swim.set_collision_mask_value(1,false)
	RayCast_Swim.set_collision_mask_value(3,true)
	
	RayCast1.exclude_parent = true
	RayCast2.exclude_parent = true
	RayCast3.exclude_parent = true
	RayCast_Swim.exclude_parent = true
	
	## Adding all required nodes
	Character.add_child(Collider)
	Character.add_child(RayCast1)
	Character.add_child(RayCast2)
	Character.add_child(RayCast3)
	Character.add_child(RayCast_Swim)
	Character.add_child(JumpTimer)
	JumpTimer.timeout.connect(_on_jump_timer_timeout.bind())
	MoveMarker.name = "MoveMarker"
	Character.add_child(MoveMarker)
	
	CameraController = Character.get_node("Camera_Controller")
	
	await CameraController.CameraSetup
	
	Camera = CameraController.Camera
	Camera_Y = CameraController.Camera_Y
	Camera_X = CameraController.Camera_X
	Camera_Z = CameraController.Camera_Z
	Camera_Core = CameraController.Camera_Core
	
	## Re-activate processes now
	set_process(true)
	set_physics_process(true)
	print(get_parent())
	

func _ready() -> void:
	await Character.ScriptLoaded
	## Seperate out the setup process for easier management of ready function
	setup()
	
	## Just a little check which can be removed later
	#print("We Made it!")

func _process(delta: float) -> void:
	if !Core.Globals.DisablePlayerInput:
		input = Core.Globals.local_inputs[ControllerID].Current_Input["Joy_1_Input"]
	else:
		input = Vector2.ZERO
		
	if Core.Globals.DisablePlayerInput:
		input = Vector2.ZERO

	if input != Vector2.ZERO || (Alt_Input != Vector2.ZERO && velocity_lock):
		if !Swimming:
			#print(input.length())
			if (input.length() > .4 && Core.Globals.local_inputs[ControllerID].Current_Input["Mode"] == "Controller") || (Core.Globals.local_inputs[ControllerID].Current_Input["Mode"] == "Keyboard" && !Core.Globals.local_inputs[ControllerID].Current_Input["Button_Input_Pressed"]["Up"]):
				Current_Animation = ["Run",.3]
			else:
				Current_Animation = ["Walk",.3]
		else:
			Current_Animation = ["Swimming_Run",.1]
	else:
		if !Swimming:
			Current_Animation = ["Idle",.3]
		else:
			Current_Animation = ["Swimming_Idle",.1]
				
	if jumping:
		Current_Animation = ["Jump",.2]
			
	if falling && !RayCast3.is_colliding():
		Current_Animation = ["Falling",.2]
		
	Hub.update_animation(Current_Animation)
	if CameraController != null:
		if Camera_Z.spring_length >= -0.1:
			Hub.hide()
			
			Hub.rotation.y = Camera_Y.rotation.y
			
		else:
			Hub.show()
			
	if current_swim_particles != null:
		current_swim_particles.global_position = Character.to_global(swim_pos)
	
	
func _physics_process(delta: float) -> void:
	
	if Camera != null: 
		if !velocity_lock:
			if input != Vector2.ZERO:
				MoveMarker.rotation.y = atan2(-input.x,-input.y)+Camera_Y.transform.basis.get_euler().y
				Hub.rotation.y = lerp_angle(Hub.rotation.y, MoveMarker.rotation.y, delta*10)
		else:
			MoveMarker.rotation.y = atan2(-Alt_Input.x,-Alt_Input.y)
			#if !shiftlock_Enabled:
			Hub.rotation.y = lerp_angle(Hub.rotation.y, MoveMarker.rotation.y, delta*10)
	
	if !Movement_Disable:
		if RayCast_Swim.is_colliding():
			Swimming = true
			RayCast_Swim.enabled = false
			gravity_control = Vector3.ZERO
			compiled_velocity = Vector3.ZERO
			Character.global_transform.basis = align_up(Character.basis,RayCast_Swim.get_collision_normal(),1)
			Character.position = RayCast_Swim.get_collision_point() - (Character.global_transform.basis.y * 0.48)
			#if falling:
				#var sploosh2 = sploosh.duplicate()
				#sploosh2.get_node("AnimationPlayer").play("Sploosh")
				#Character.get_parent().get_node("Effects").add_child(sploosh2)
				#sploosh2.global_position = RayCast_Swim.get_collision_point()
				#sploosh2.global_transform.basis = Character.global_transform.basis
			falling = false
			jumping = false
			#
			#var particles2 = particles.duplicate()
			#Character.get_parent().get_node("Effects").add_child(particles2)
			#swim_pos = Character.to_local(RayCast_Swim.get_collision_point()) + Vector3(0,0.02,0)
			#particles2.global_transform.basis = Character.global_transform.basis
			#
			#current_swim_particles = particles2
			#particles2.emitting = true
			
		if !Swimming:
			Fall_Delta = Time.get_ticks_msec() - Fall_Delta_Prev
			Fall_Delta_Prev = Time.get_ticks_msec()
			forcingUp = false
			if RayCast2.is_colliding():
				RayCast1.target_position = Vector3(0,-0.4,0)
				fall_timer = 0
				jumping = false
				falling = false
				Fall_Tick = 0
				gravity_control = Vector3.ZERO
			else:
				gravity_control += (MoveMarker.global_transform.basis.y * 1) * (gravity/8)
					
				if Character.up_direction > gravity_control:
					Fall_Tick += Fall_Delta
					if Fall_Tick > (300) || jumping:
						falling = true

				RayCast1.target_position = Vector3(0,-0.27,0)
				RayCast2.target_position = Vector3(0,-0.27,0)
				
			if !forcingUp:
				if walk:
					speed = walkspeed
				else:
					speed = runspeed
					
				if (Core.Globals.local_inputs[ControllerID].Current_Input["Button_Input_Just_Pressed"]["Right"] && !jumping && !Core.Globals.DisablePlayerInput) || (AltJump):
					JumpTimer.start()
					jumping = true
					gravity_control = (MoveMarker.global_transform.basis.y * 1) * jumpspeed
					RayCast1.target_position = Vector3(0,-0.07,0)
					RayCast2.target_position = Vector3(0,-0.07,0)
					if AltJump:
						AltJump = false
				
				if !velocity_lock:
					if !(Core.Globals.local_inputs[ControllerID].Current_Input["Mode"] == "Keyboard" && Core.Globals.local_inputs[ControllerID].Current_Input["Button_Input_Pressed"]["Up"]):
						compiled_velocity += ((MoveMarker.global_transform.basis.z * clamp(abs(input.y)+abs(input.x),0,1)) * speed) 
					else:
						compiled_velocity += ((MoveMarker.global_transform.basis.z * clamp(abs(input.y)+abs(input.x),0,1)) * walkspeed) 
				else:
					compiled_velocity += ((MoveMarker.global_transform.basis.z * clamp(abs(Alt_Input.y)+abs(Alt_Input.x),0,1)) * speed) 
				
			if RayCast3.is_colliding() && !jumping:
				JumpTimer.stop()
				Character.position = Character.position.slerp(RayCast3.get_collision_point(),.5)
				gravity_control += (MoveMarker.global_transform.basis.y * 1) * 0.2
			elif !RayCast3.is_colliding() && jumping:
				JumpTimer.start()
				RayCast1.target_position = Vector3(0,-0.07,0)
				RayCast2.target_position = Vector3(0,-0.07,0)
						
			if Character.is_on_ceiling():
				#print("hai")
				gravity_control += ((MoveMarker.global_transform.basis.y * 1) * (gravity/8)* 2.0)
		
		else:
			if !velocity_lock:
				compiled_velocity += ((MoveMarker.global_transform.basis.z * clamp(abs(input.y)+abs(input.x),0,1)) * swim_speed) 
			else:
				compiled_velocity += ((MoveMarker.global_transform.basis.z * clamp(abs(Alt_Input.y)+abs(Alt_Input.x),0,1)) * swim_speed) 
			
			
			if Core.Globals.local_inputs[ControllerID].Current_Input["Button_Input_Just_Pressed"]["Right"]:
				Swimming = false
				AltJump = true
				RayCast_Swim.enabled = true
				if current_swim_particles != null:
					current_swim_particles.emitting = false
			elif Character.is_on_floor():
				Swimming = false
				RayCast_Swim.enabled = true
				if current_swim_particles != null:
					current_swim_particles.emitting = false
				
	Character.velocity = compiled_velocity + gravity_control
	Character.move_and_slide()

	compiled_velocity = compiled_velocity.slerp(Vector3.ZERO,0.4)

## Supplimentary function for aligning player to world smoothly
func align_up(node_basis, normal, slerptime):
	var result = Basis()
	result.x = normal.cross(node_basis.z)
	result.y = normal
	result.z = node_basis.x.cross(normal)
	
	result = node_basis.slerp(result.orthonormalized(),slerptime)
	return result

func _on_jump_timer_timeout() -> void:
	JumpTimer.stop()
	jumping = false
	falling = false
