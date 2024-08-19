extends CharacterBody3D
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

var charmat = load("res://Assets/Materials/Characters/Cubiix_Base_Shader_Material.tres").duplicate()

enum EYE_ENUM {Default,Chonk,Tri,Nat,Circle,Fox,Four,Entity,Text}
enum EAR_ENUM {None,Cat, Fox, Wolf, Goat, Bee, Moth,Mouse,Alien,Deer, Entity, Dog, Bunny, Fluffy}
enum EXTRA_ENUM {None, Shark, Nub, Antler, Ram, Fish, Narwhal, Dragon}
enum TAIL_ENUM {None,Cat, Fox, Wolf, Bug, Bee, Moth, Dog, Mouse, Fluffy, Shark, Entity, Bunny, Deer, Dragon}
enum WING_ENUM {None, Entity, Angel, Butterfly, Wasp, Dragon}
#--
enum HEAD_ENUM {None,Goggle_Test,Orb_Test,DotMouse_Hat}
enum CHEST_ENUM {None,Trad_Pride_Bandanna,Trans_Pride_Bandanna}
enum BACK_ENUM {None}

@export var Eyes : EYE_ENUM = EYE_ENUM.Default
@export var Ears : EAR_ENUM = EAR_ENUM.None
@export var Extra : EXTRA_ENUM = EXTRA_ENUM.None
@export var Tail : TAIL_ENUM = TAIL_ENUM.None
@export var Wings : WING_ENUM = WING_ENUM.None

@export var Head : HEAD_ENUM = HEAD_ENUM.None
@export var Chest : CHEST_ENUM = CHEST_ENUM.None
@export var Back : BACK_ENUM = BACK_ENUM.None

@export_color_no_alpha var Body_1 = Color8(0,0,0)
@export_color_no_alpha var Body_2 = Color8(0,0,0)
@export_color_no_alpha var Body_3 = Color8(0,0,0)
@export_color_no_alpha var Body_4 = Color8(0,0,0)

@export_color_no_alpha var Body_Emiss_1 = Color8(0,0,0)
@export_color_no_alpha var Body_Emiss_2 = Color8(0,0,0)
@export_color_no_alpha var Body_Emiss_3 = Color8(0,0,0)
@export_color_no_alpha var Body_Emiss_4 = Color8(0,0,0)

var DynBones_Register = {}
var Skeleton_Values = {}

var CharSetup = false
@export var Is_Player = false

@onready var Anim_Tree = $Hub/Cubiix_Model/AnimationTree
@onready var Anim_Player = $Hub/Cubiix_Model/AnimationPlayer
@onready var Skeleton = $Hub/Cubiix_Model/Skeleton3D
@onready var MeshObj = $Hub/Cubiix_Model/Skeleton3D/Cube
@onready var DynBones = null
@onready var Model = $Hub/Cubiix_Model
@onready var Camera = get_viewport().get_camera_3d()
@onready var MoveMarker = $Marker3D
signal MeshFinished

var cache_data = {}

##Integration for Disabling Player
var BasePlayer_Disabled = false

##Integration for Sitting
var Is_Sitting  = false
var Is_Piloting = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Core.Client.Local_Player = self
	Regen_Character()


func Regen_Character():
	CharSetup = false
	for i in stored_items.keys():
		stored_items[i]["object"].hide()
	
	var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	var tween2 = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(charmat,"shader_parameter/distance_fade_max",300.0,.5)
	tween2.tween_property(charmat,"shader_parameter/distance_fade_glow",300.0,.2)
	charmat.set_shader_parameter("distance_transitioning",true)
	tween.tween_callback(func():
		Model.queue_free()
		await get_tree().process_frame
		var base_model = Core.AssetData.Cubiix_Model.duplicate(true)
		base_model.hide()
		Model = base_model
		$Hub.add_child(base_model)
		base_model.global_position = Vector3(0,0,0)
		await get_tree().process_frame
		base_model.name = "Cubiix_Model"
		Anim_Tree = base_model.get_node("AnimationTree")
		Anim_Tree.advance_expression_base_node = self.get_path()
		Anim_Player = base_model.get_node("AnimationPlayer")
		Skeleton = base_model.get_node("Skeleton3D")
		MeshObj = Skeleton.get_node("Cube")
		DynBones = DynBone.new()
		for i in stored_items.keys():
			stored_items[i]["object"].external_skeleton = Skeleton.get_path()
			stored_items[i]["object"].bone_name = Core.AssetData.Item_Data_Assets[stored_items[i]["type"]]["target"]
			
		await get_tree().process_frame
		
		var compiled = Core.AssetData.register_meshlist(
		["Body",Core.AssetData.Eye_Slot[Eyes],Core.AssetData.Ear_Slot[Ears],Core.AssetData.Extra_Slot[Extra],Core.AssetData.Tail_Slot[Tail],Core.AssetData.Wing_Slot[Wings],Core.AssetData.Head_Slot[Head],Core.AssetData.Chest_Slot[Chest],Core.AssetData.Back_Slot[Back]],
		{"User":charmat}
		)
		
		Core.AssetData.add_to_mesh_queue(compiled["MeshList"],compiled["MaterialList"],MeshObj,Skeleton, self)
		await MeshFinished
		charmat.set_shader_parameter("Body1",Body_1)
		charmat.set_shader_parameter("emiss_Body1",Body_Emiss_1)
		charmat.set_shader_parameter("Body2",Body_2)
		charmat.set_shader_parameter("emiss_Body2",Body_Emiss_2)
		charmat.set_shader_parameter("Body3",Body_3)
		charmat.set_shader_parameter("emiss_Body3",Body_Emiss_3)
		charmat.set_shader_parameter("Body4",Body_4)
		charmat.set_shader_parameter("emiss_Body4",Body_Emiss_4)
		
		Anim_Tree.active = true
		Skeleton.add_child(DynBones)
		DynBones.DynBones_Register = DynBones_Register.duplicate(true)
		DynBones.first_run()
		base_model.position = Vector3(0,0,0)
		base_model.show()
		CharSetup = true
		await get_tree().create_timer(0.2).timeout
		DynBones.emit_signal("RePositioned")
		
		tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
		tween2 = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
		tween2.tween_property(charmat,"shader_parameter/distance_fade_glow",0.0,.5)
		tween.tween_property(charmat,"shader_parameter/distance_fade_max",0.0,.5)
		tween.tween_callback(func():
			for i in stored_items.keys():
				stored_items[i]["object"].show()
			charmat.set_shader_parameter("distance_transitioning",false)

			)
	)

var input :Vector2 = Vector2.ZERO
var CurrentTick :int = 0
var CurrentTime :int = Time.get_ticks_msec()
var Blink_Timer = 0
var Blink_RNG = 100
var Idle_Timer = 0
var Idle_RNG = 100
var Tick_Prev = 0
var can_idle = true
var can_idle_override = true
var walk = false
var customizing = false
var stored_items = {}
var Delta = 0


func _process(delta: float) -> void:
	Delta = Time.get_ticks_msec() - Tick_Prev
	Tick_Prev = Time.get_ticks_msec()
	Blink_Timer += Delta
	
	if can_idle && can_idle_override && !customizing:
		Idle_Timer += Delta
		
	if Is_Player:
		input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
		input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
			
	if Is_Player && !BasePlayer_Disabled:

		if Input.is_action_just_pressed("ui_accept") && CharSetup:
			Ears = EAR_ENUM.Cat
			Tail = TAIL_ENUM.Cat
			Wings = WING_ENUM.Angel
			Extra = EXTRA_ENUM.None
			Eyes = EYE_ENUM.Default
			Regen_Character()

		if CharSetup:
			if Input.is_action_just_pressed("ui_cancel"):
				customizing = !customizing
				if customizing:
					var device = Core.AssetData.Item_Data_Assets["Hexii_Device"]["path"].duplicate()
					$Hub/Items.add_child(device)
					device.external_skeleton = Skeleton.get_path()
					device.bone_name = Core.AssetData.Item_Data_Assets["Hexii_Device"]["target"]
					stored_items["Device"] = {
						"object":device,
						"type":"Hexii_Device"
						}
				else:
					stored_items["Device"]["object"].queue_free()
					stored_items.erase("Device")
				
			walk = Input.is_action_pressed("ui_select")

		if input != Vector2.ZERO || customizing:
			Idle_Timer = 0
			can_idle_override = false
		else:
			can_idle_override = true
		if Blink_Timer > (30000/2) + Blink_RNG:
			Blink_Timer = 0
			Blink_RNG = randi_range(-2000,2000)
			var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
			tween.tween_property(MeshObj,"blend_shapes/Blink_L",1,0.1)
			var tween4 = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
			tween4.tween_property(MeshObj,"blend_shapes/Blink_R",1,0.1)
			tween.tween_callback(func():
				var tween2 = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
				tween2.tween_property(MeshObj,"blend_shapes/Blink_L",0,0.1)
				var tween3 = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
				tween3.tween_property(MeshObj,"blend_shapes/Blink_R",0,0.1)
			)
		if  Idle_Timer > (40000/2) + Idle_RNG && can_idle && can_idle_override:
			Idle_RNG = randi_range(-2000,2000)
			can_idle = false
			Idle_Timer = 0
			print("Damb")
			run_idle()
		

			
			
			
func run_idle():
	await get_tree().create_timer(3.5).timeout
	can_idle = true

func _input(event: InputEvent) -> void:
	if Is_Player:
		if Input.is_action_pressed("mouse_right"):
			if event is InputEventMouseMotion:
				Camera.get_parent().get_parent().get_parent().rotation.y -= event["relative"].x/200
				Camera.get_parent().get_parent().rotation.x += event["relative"].y/200
				reset_camera = false
				

const walkspeed = .5
const runspeed = 2

var speed = 3
var jumpspeed = 6
const gravity = -0.98 * 2
var gravity_control:Vector3 = Vector3.ZERO
var jumping = false
var falling = false
var fall_timer = 0
var anti_grav_enabled = false

var queue_network_moved = false
var forcingUp = false
var AltJump = false

var target_camera_position = null:
	set(value):
		target_camera_position = value
		if target_camera_position != null:
			cam_swapped = true
			old_velocity = ((MoveMarker.global_transform.basis.z * clamp(abs(input.y)+abs(input.x),0,1)) * speed)
		else:
			reset_camera = true

var cam_swapped = false
var reset_camera = false
var input_old = Vector2.ZERO
var old_velocity = Vector3.ZERO
var compiled_velocity = Vector3.ZERO
var last_hit = Vector3.ZERO

func _physics_process(delta: float) -> void:
	if Is_Player:
		var camparent = Camera.get_parent().get_parent().get_parent().get_parent()
		if target_camera_position != null:
			camparent.global_position = lerp(camparent.global_position ,target_camera_position.global_position,0.1)
			target_camera_position.look_at($Hub/Follow_Point.global_position)
			Camera.get_parent().get_parent().get_parent().global_rotation.y = lerp_angle(Camera.get_parent().get_parent().get_parent().global_rotation.y ,target_camera_position.global_rotation.y + deg_to_rad(180),0.1)
			Camera.get_parent().get_parent().global_rotation.x = lerp_angle(Camera.get_parent().get_parent().global_rotation.x,-target_camera_position.global_rotation.x,0.1)
			Camera.get_parent().spring_length = 0
		else:
			Camera.get_parent().spring_length = -4
			camparent.global_position = lerp(camparent.global_position,$Hub/Follow_Point.global_position,0.2)
			if reset_camera:
				reset_camera = false
				var tween = get_tree().create_tween() \
				.set_ease(Tween.EASE_IN_OUT) \
				.set_trans(Tween.TRANS_QUAD) \
				.set_parallel(true)
				
				tween.tween_property(Camera.get_parent().get_parent().get_parent(),"global_rotation:y",$Hub.global_rotation.y,1)
				tween.tween_property(Camera.get_parent().get_parent(),"global_rotation:x",deg_to_rad(25),1)
	
	if Is_Player && !BasePlayer_Disabled:
		forcingUp = false
		cache_data["Player_Position"] = self.global_position
		
		if customizing:
			input = Vector2.ZERO
		
		var camparent = Camera.get_parent().get_parent().get_parent().get_parent()
		
		if input != Vector2.ZERO:
			if !cam_swapped:
				MoveMarker.rotation.y = atan2(-input.x,-input.y)+Camera.get_parent().get_parent().get_parent().transform.basis.get_euler().y
				$Hub.rotation.y = lerp_angle($Hub.rotation.y, MoveMarker.rotation.y, delta*10)
		
		if $RayCast3D.is_colliding() || is_on_floor():
			if anti_grav_enabled:
				transform.basis = align_up(transform.basis, $RayCast3D.get_collision_normal(), 0.15)
				if target_camera_position != null:
					camparent.transform = target_camera_position.transform
				else:
					camparent.transform = transform
				
				up_direction = $RayCast3D.get_collision_normal()
			
		

				#Camera.get_parent().get_parent().get_parent().global_rotation.y = lerp_angle(Camera.get_parent().get_parent().get_parent().global_rotation.y ,$Hub.global_rotation.y,0.1)
				#Camera.get_parent().get_parent().global_rotation.x = lerp_angle(Camera.get_parent().get_parent().global_rotation.x,deg_to_rad(25),0.1)
	
		if $RayCast3D2.is_colliding():
			$RayCast3D.target_position = Vector3(0,-0.4,0)
			fall_timer = 0
			jumping = false
			falling = false
			gravity_control = Vector3.ZERO
			
		else:
			if anti_grav_enabled:
				fall_timer += Delta
				if fall_timer > (4000/2):
					up_direction = Vector3.UP
					camparent.transform.basis = align_up(camparent.transform.basis,  Vector3.UP, 0.05)
					transform.basis = align_up(transform.basis,  Vector3.UP, 0.15)
					forcingUp = true
				
			if up_direction < gravity_control:
				falling = true
			gravity_control += (MoveMarker.global_transform.basis.y * 1) * (gravity/8)
			$RayCast3D.target_position = Vector3(0,-0.27,0)
			$RayCast3D2.target_position = Vector3(0,-0.27,0)
		
		if !forcingUp:
			if walk:
				speed = walkspeed
			else:
				speed = runspeed
				
			if (Input.is_action_just_pressed("ui_jump") && !jumping) || (AltJump):
				jumping = true
				gravity_control = (MoveMarker.global_transform.basis.y * 1) * jumpspeed
				$RayCast3D.target_position = Vector3(0,-0.07,0)
				$RayCast3D2.target_position = Vector3(0,-0.07,0)
				if AltJump:
					AltJump = false
				

			
			if cam_swapped:
				if input_old != input:
					cam_swapped = false
				compiled_velocity += old_velocity
			else:
				compiled_velocity += ((MoveMarker.global_transform.basis.z * clamp(abs(input.y)+abs(input.x),0,1)) * speed) 
			
		if $RayCast3D3.is_colliding() && !jumping:
			self.position = self.position.slerp($RayCast3D3.get_collision_point(),.5)
			gravity_control += (MoveMarker.global_transform.basis.y * 1) * 0.2
		
		velocity = compiled_velocity + gravity_control
		move_and_slide()
		
		compiled_velocity = compiled_velocity.slerp(Vector3.ZERO,0.4)
		if self.position != cache_data["Player_Position"]:
			queue_network_moved = true
		
		input_old = input
		
func align_up(node_basis, normal, slerptime):
	var result = Basis()
	result.x = normal.cross(node_basis.z)
	result.y = normal
	result.z = node_basis.x.cross(normal)
	
	result = node_basis.slerp(result.orthonormalized(),slerptime)
	return result
