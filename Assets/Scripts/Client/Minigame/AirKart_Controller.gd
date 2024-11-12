extends CharacterBody3D
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

const walkspeed = .5
const runspeed = 2

var speed_max = 1.5
var speed = 0.0
var speed_accelerate = 0.01
var speed_deccelerate = 0.03
var jumpspeed = 6
const gravity = -0.98 * 2
var gravity_control:Vector3 = Vector3.ZERO
var compiled_velocity = Vector3.ZERO

@export var spring_strength = 10.0
@export var suspension_rest_dist = .5
@export var wheel_radius = 0.33
var prev_spring_length = 0.0
@export var spring_damper = 2.0

var has_player = false
var input = Vector2.ZERO
var stored_velocity = Vector3.ZERO

func _ready() -> void:
	$Interact_Prompt.Interacted.connect(FlySetup)
	set_physics_process(false)
	
func _process(delta: float) -> void:
	if has_player:
		input = Core.Client.Local_Player.input
		
		if Input.is_action_just_pressed("ui_jump") && !Core.Persistant_Core.Menu_Focused:
			FlyDisable()
			
func FlyDisable():
	$Interact_Prompt.show()
	$Interact_Prompt.hard_disable = false
	Core.Client.Local_Player.BasePlayer_Disabled = false
	Core.Client.Local_Player.Is_Sitting = false
	Core.Client.Local_Player.Is_Piloting = false
	$Hub/RemotePos.remote_path = ""
	$Hub/RemoteRot.remote_path = ""
	has_player = false
	Core.Client.Local_Player.AltJump = true
	
func FlySetup():
	$Interact_Prompt.hide()
	$Interact_Prompt.hard_disable = true
	Core.Client.Local_Player.BasePlayer_Disabled = true
	Core.Client.Local_Player.Is_Sitting = true
	Core.Client.Local_Player.Is_Piloting = true
	$Hub/RemotePos.remote_path = Core.Client.Local_Player.get_path()
	$Hub/RemoteRot.remote_path = Core.Client.Local_Player.get_node("Hub").get_path()
	has_player = true

@onready var Camera = get_viewport().get_camera_3d()
func _physics_process(delta: float) -> void:
	
	gravity_control += (self.global_transform.basis.y * 1) * (gravity/8)

	if $RayCast3D.is_colliding():
		var raycast_origin = $RayCast3D.global_position
		var raycast_dest = $RayCast3D.get_collision_point()
		var distance = raycast_dest.distance_to(raycast_origin)
		var contact = raycast_dest - raycast_origin
		var spring_length = clamp(distance - wheel_radius, 0, suspension_rest_dist )
		var spring_force = spring_strength * (suspension_rest_dist - spring_length)
		var spring_velocity = (prev_spring_length - spring_length) / delta
		var damper_force = spring_damper * spring_velocity
		var suspension_force = (self.global_transform.basis.y * 1) * (spring_force + damper_force)
		prev_spring_length = spring_length
		gravity_control += suspension_force
	if input != Vector2.ZERO && has_player:
		$MoveMarker.rotation.y = lerp_angle($MoveMarker.rotation.y,atan2(-input.x,-input.y)+Camera.get_parent().get_parent().get_parent().transform.basis.get_euler().y, 0.15)
		$Hub.rotation.y = lerp_angle($Hub.rotation.y, $MoveMarker.rotation.y, delta*10)
		speed += speed_accelerate
		speed = clamp(speed,0,speed_max)
		compiled_velocity += (($MoveMarker.global_transform.basis.z * clamp(abs(input.y)+abs(input.x),0,1)) * speed) 
	elif input == Vector2.ZERO || !has_player:
		speed -= speed_deccelerate
		speed = clamp(speed,0,speed_max)
		compiled_velocity += (($MoveMarker.global_transform.basis.z * clamp(abs(input.y)+abs(input.x),0,1)) * speed) 
	
	if $RayCast3D2.is_colliding():
		gravity_control = (self.global_transform.basis.y * 1) * 1
	velocity = compiled_velocity + gravity_control
	compiled_velocity = compiled_velocity.slerp(Vector3.ZERO,0.05)
	move_and_slide()

	
func align_up(node_basis, normal, slerptime):
	var result = Basis()
	result.x = normal.cross(node_basis.z)
	result.y = normal
	result.z = node_basis.x.cross(normal)
	
	result = node_basis.slerp(result.orthonormalized(),slerptime)
	return result
