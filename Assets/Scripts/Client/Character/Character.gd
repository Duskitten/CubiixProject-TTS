extends CharacterBody3D
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

var charmat = load("res://Assets/Materials/Characters/Cubiix_Base_Shader_Material.tres").duplicate()

enum EYE_ENUM {Default,Chonk,Tri,Nat,Circle,Fox,Four,Entity,Text}
enum EAR_ENUM {None,Cat, Fox, Wolf, Goat, Bee, Moth,Mouse,Alien,Deer, Entity, Dog, Bunny, Fluffy}
enum EXTRA_ENUM {None, Shark, Nub, Antler, Ram, Fish, Narwhal, Dragon}
enum TAIL_ENUM {None,Cat, Fox, Wolf, Bug, Bee, Moth, Dog, Mouse, Fluffy, Shark, Entity, Bunny, Deer, Dragon}
enum WING_ENUM {None, Entity, Angel, Butterfly, Wasp, Dragon}
#--
enum HEAD_ENUM {None,Goggle_Test,Orb_Test,DotMouse_Hat, Pumpkin_Head_Cute_1, Devil_Head, Witch_Head}
enum CHEST_ENUM {None,Trad_Pride_Bandanna,Trans_Pride_Bandanna}
enum BACK_ENUM {None, Trad_Pride_Cape}

@export var Randomize : bool

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

@export_color_no_alpha var Body_1_Emiss = Color8(0,0,0)
@export_color_no_alpha var Body_2_Emiss = Color8(0,0,0)
@export_color_no_alpha var Body_3_Emiss = Color8(0,0,0)
@export_color_no_alpha var Body_4_Emiss = Color8(0,0,0)

@export var Body_1_Emiss_S = 1.0
@export var Body_2_Emiss_S = 1.0
@export var Body_3_Emiss_S = 1.0
@export var Body_4_Emiss_S = 1.0

@export var Body_1_Roughness = 1.0
@export var Body_2_Roughness = 1.0
@export var Body_3_Roughness = 1.0
@export var Body_4_Roughness = 1.0

@export var Body_1_Metallic = 0.0
@export var Body_2_Metallic= 0.0
@export var Body_3_Metallic = 0.0
@export var Body_4_Metallic = 0.0

var DynBones_Register = {}
var Skeleton_Values = {}

var CharSetup = false
@export var Is_Player = false
@export var Is_UI = false
@export var Generate = false

@onready var Anim_Tree = $Hub/Cubiix_Model/AnimationTree
@onready var Anim_Player = $Hub/Cubiix_Model/AnimationPlayer
@onready var Skeleton:Skeleton3D = $Hub/Cubiix_Model/Skeleton3D
@onready var MeshObj = $Hub/Cubiix_Model/Skeleton3D/Cube
@onready var DynBones = null
@onready var Model = $Hub/Cubiix_Model
@onready var Camera = get_viewport().get_camera_3d()

@onready var LeftHandPoint = $Hub/Cubiix_Model/Skeleton3D/ProxyLeftHandPoint
@onready var RightHandPoint = $Hub/Cubiix_Model/Skeleton3D/ProxyRightHandPoint

var Emote_Anims = ["wave"]
var Is_Emoting = false
var Current_Emote = ""

var CameraLength = -4.0
@onready var MoveMarker = $Marker3D
signal MeshFinished

var cache_data = {}

##Integration for Disabling Player
var BasePlayer_Disabled = false

##Integration for Sitting
var Is_Sitting  = false
var Is_Piloting = false
var Is_Grinding = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Is_Player:
		Core.Client.Local_Player = self
		Regen_Character()
	elif Is_UI:
		pass
	else:
		self.remove_from_group("Player")
		$CollisionShape3D.queue_free()
		$RayCast3D.queue_free()
		$RayCast3D2.queue_free()
		$RayCast3D3.queue_free()
		set_physics_process(false)
		if Randomize:
			Eyes = Core.AssetData.Eye_Slot.find(Core.AssetData.Eye_Slot.pick_random())
			Ears = Core.AssetData.Ear_Slot.find(Core.AssetData.Ear_Slot.pick_random())
			Extra = Core.AssetData.Extra_Slot.find(Core.AssetData.Extra_Slot.pick_random())
			Tail = Core.AssetData.Tail_Slot.find(Core.AssetData.Tail_Slot.pick_random())
			Wings = Core.AssetData.Wing_Slot.find(Core.AssetData.Wing_Slot.pick_random())
		Regen_Character()

func Regen_Color():
	charmat.set_shader_parameter("Body1",Body_1)
	charmat.set_shader_parameter("emiss_Body1",Body_1_Emiss*Body_1_Emiss_S)
	charmat.set_shader_parameter("Body1_metallic",Body_1_Metallic)
	charmat.set_shader_parameter("Body1_roughness",Body_1_Roughness)
	charmat.set_shader_parameter("Body2",Body_2)
	charmat.set_shader_parameter("emiss_Body2",Body_2_Emiss*Body_2_Emiss_S)
	charmat.set_shader_parameter("Body2_metallic",Body_2_Metallic)
	charmat.set_shader_parameter("Body2_roughness",Body_2_Roughness)
	charmat.set_shader_parameter("Body3",Body_3)
	charmat.set_shader_parameter("Body3_metallic",Body_3_Metallic)
	charmat.set_shader_parameter("Body3_roughness",Body_3_Roughness)
	charmat.set_shader_parameter("emiss_Body3",Body_3_Emiss*Body_3_Emiss_S)
	charmat.set_shader_parameter("Body4",Body_4)
	charmat.set_shader_parameter("emiss_Body4",Body_4_Emiss*Body_4_Emiss_S)
	charmat.set_shader_parameter("Body4_metallic",Body_1_Metallic)
	charmat.set_shader_parameter("Body4_roughness",Body_1_Roughness)
func Regen_Character():
	CharSetup = false
	for i in stored_items.keys():
		stored_items[i]["object"].hide()
	
	swapping = true
	Model.name = "replaceMe"
	var base_model = Core.AssetData.Cubiix_Model.duplicate(true)
	base_model.hide()
	$Hub.add_child(base_model)
	base_model.global_position = Vector3(0,0,0)
	await get_tree().process_frame
	base_model.name = "Cubiix_Model"
	Anim_Tree = base_model.get_node("AnimationTree")
	Anim_Tree.advance_expression_base_node = self.get_path()
	Anim_Player = base_model.get_node("AnimationPlayer")
	Skeleton.remove_child(LeftHandPoint)
	Skeleton.remove_child(RightHandPoint)
	Skeleton = base_model.get_node("Skeleton3D")
	if !Is_UI:
		Skeleton.get_node("ProxyLeftHandPoint").queue_free()
		Skeleton.get_node("ProxyRightHandPoint").queue_free()
	MeshObj = Skeleton.get_node("Cube")
	DynBones = DynBone.new()
	#for i in stored_items.keys():
		#stored_items[i]["object"].external_skeleton = Skeleton.get_path()
		#stored_items[i]["object"].bone_name = Core.AssetData.Item_Data_Assets[stored_items[i]["type"]]["target"]
		#
	await get_tree().process_frame

	var compiled = Core.AssetData.register_meshlist(
	["Body",Core.AssetData.Eye_Slot[Eyes],Core.AssetData.Ear_Slot[Ears],Core.AssetData.Extra_Slot[Extra],Core.AssetData.Tail_Slot[Tail],Core.AssetData.Wing_Slot[Wings],Core.AssetData.Head_Slot[Head],Core.AssetData.Chest_Slot[Chest],Core.AssetData.Back_Slot[Back]],
	{"User":charmat}
	)
	var parent = Skeleton.get_parent()
	
	Skeleton.get_parent().remove_child(Skeleton)
	
	Core.AssetData.add_to_mesh_queue(compiled["MeshList"],compiled["MaterialList"],MeshObj,Skeleton,self)
	
	await MeshFinished
	Model.queue_free()
	parent.add_child(Skeleton)
	Skeleton.add_child(LeftHandPoint)
	Skeleton.add_child(RightHandPoint)
	Model = base_model
	
	Regen_Color()
	
	Anim_Tree.active = true
	if Is_Player || Is_UI:
		Skeleton.add_child(DynBones)
		DynBones.DynBones_Register = DynBones_Register.duplicate(true)
		DynBones.first_run()
	base_model.position = Vector3(0,0,0)
	base_model.show()
	CharSetup = true
	if !Is_Player:
		$Hub/Cubiix_Model/AnimationTree.set("parameters/NPC/blend_amount",1)
	await get_tree().create_timer(0.2).timeout
	
	swapping = false
	DynBones.emit_signal("RePositioned")
	#if Is_Player:
		#add_new_item("Tech_Sword")

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
var Look_At = null

var NPC_Is_InterestPoint = false

func _process(delta: float) -> void:
	var Camera2 = get_viewport().get_camera_3d()
	
	if Camera2.is_in_group("PlayerCamera"):
		Camera = get_viewport().get_camera_3d()
	else:
		Camera = null
	
		
	Delta = Time.get_ticks_msec() - Tick_Prev
	Tick_Prev = Time.get_ticks_msec()
	Blink_Timer += Delta
	#if Skeleton == null:
		#$Hub/Lerped_Head/BoneAttachment3D.override_pose = false
	#if !Is_Player:
		#if Look_At != null:
			#$Hub/Lerped_Head/BoneAttachment3D.override_pose = true
			#
			#$Hub/Cubiix_Model/AnimationTree.set("parameters/Blend2/blend_amount",1)
			#$Hub/Head.look_at(Look_At.global_position)
			#$Hub/Lerped_Head.rotation.x = lerp_angle($Hub/Lerped_Head.rotation.x,clamp(lerp_angle($Hub/Lerped_Head.rotation.x,-$Hub/Head.rotation.x, 1),deg_to_rad(-30),deg_to_rad(30)),0.1)
			#$Hub/Lerped_Head.rotation.y = lerp_angle($Hub/Lerped_Head.rotation.y,clamp(lerp_angle($Hub/Lerped_Head.rotation.y,$Hub/Head.rotation.y+deg_to_rad(180), 1),deg_to_rad(-45),deg_to_rad(45)),0.1)
			#$Hub/Lerped_Head.rotation.z = lerp_angle($Hub/Lerped_Head.rotation.z,$Hub/Head.rotation.z, 0.1)
			#$Hub/Lerped_Head.global_position = Skeleton.to_global(Skeleton.get_bone_global_pose(Skeleton.find_bone("Chest")).origin)
			#
		#else:
			#$Hub/Lerped_Head.rotation.x = lerp_angle($Hub/Lerped_Head.rotation.x,0, 0.5)
			#$Hub/Lerped_Head.rotation.y = lerp_angle($Hub/Lerped_Head.rotation.y,0, 0.5)
			#$Hub/Lerped_Head.rotation.z = lerp_angle($Hub/Lerped_Head.rotation.z,0, 0.5)
			#
			#
			#if $Hub/Lerped_Head.rotation.length() <= 0.1:
				#$Hub/Lerped_Head/BoneAttachment3D.override_pose = false
				#$Hub/Cubiix_Model/AnimationTree.set("parameters/Blend2/blend_amount",0)
			
	if can_idle && can_idle_override && !customizing:
		Idle_Timer += Delta
		
	if Is_Player:
		if !Core.Persistant_Core.Menu_Focused:
			input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
			input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
		else:
			input = Vector2.ZERO
			
	if Is_Player && !BasePlayer_Disabled:

		#if Input.is_action_just_pressed("ui_accept") && CharSetup:
			#Ears = EAR_ENUM.Cat
			#Tail = TAIL_ENUM.Cat
			#Wings = WING_ENUM.Angel
			#Extra = EXTRA_ENUM.None
			#Eyes = EYE_ENUM.Default
			#Regen_Character()

		if CharSetup:
			#if Input.is_action_just_pressed("ui_cancel"):
				#customizing = !customizing
				#if customizing:
					#var device = Core.AssetData.Item_Data_Assets["Hexii_Device"]["path"].duplicate()
					#$Hub/Items.add_child(device)
					#device.external_skeleton = Skeleton.get_path()
					#device.bone_name = Core.AssetData.Item_Data_Assets["Hexii_Device"]["target"]
					#stored_items["Device"] = {
						#"object":device,
						#"type":"Hexii_Device"
						#}
				#else:
					#stored_items["Device"]["object"].queue_free()
					#stored_items.erase("Device")
				
			walk = Input.is_action_pressed("ui_select")

		if input != Vector2.ZERO || customizing:
			Is_Emoting = false
			Current_Emote = ""
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
	if Is_Player && !Core.Persistant_Core.Mouse_In_UI:
		if (Input.is_action_pressed("mouse_right")||shiftlock_Enabled):
			if event is InputEventMouseMotion && Camera != null:
				Camera.get_parent().get_parent().get_parent().rotation.y -= event["relative"].x/200
				Camera.get_parent().get_parent().rotation.x += event["relative"].y/200
				reset_camera = false
		if Input.is_action_just_released("ui_scroll_down") && Camera != null :
			CameraLength -= 1.0
			print("Haoi")
		if Input.is_action_just_released("ui_scroll_up") && Camera != null:
			CameraLength += 1.0
		if Input.is_action_just_pressed("shiftlock"):
			shiftlock_Enabled = !shiftlock_Enabled
			if shiftlock_Enabled:
				Input.mouse_mode = Input.MouseMode.MOUSE_MODE_CAPTURED
			else:
				Input.mouse_mode = Input.MouseMode.MOUSE_MODE_VISIBLE

const walkspeed = .5
const runspeed = 2

var speed = 3
var jumpspeed = 6
const gravity = -0.98 * 2
var gravity_control:Vector3 = Vector3.ZERO
var jumping = false
var falling = false
var fall_timer = 0
@export var anti_grav_enabled = false

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
var shiftlock_Enabled = false


###RailGrinding Stuff
var HitRail = null
var InitRail = false
var CanRide = true
var RailDir = 0
var RotOffset = 0 
var RailSpeed = 10
var ActiveArea = null
var HopCooldown = false
var AltRiding = false
var IsTransfering = false
var movepoint = null
var Flip_B = false
var swapping = false

func _physics_process(delta: float) -> void:
	if Is_Player:
		if Camera != null:
			var camparent = Camera.get_parent().get_parent().get_parent().get_parent()
			if target_camera_position != null:
				if CameraLength != 0:
					camparent.global_position = lerp(camparent.global_position ,target_camera_position.global_position,0.1)
					target_camera_position.look_at($Hub/Follow_Point.global_position)
					Camera.get_parent().get_parent().get_parent().global_rotation.y = lerp_angle(Camera.get_parent().get_parent().get_parent().global_rotation.y ,target_camera_position.global_rotation.y + deg_to_rad(180),0.1)
					Camera.get_parent().get_parent().global_rotation.x = lerp_angle(Camera.get_parent().get_parent().global_rotation.x,-target_camera_position.global_rotation.x,0.1)
					Camera.get_parent().spring_length = 0
				else:
					Camera.get_parent().spring_length = clamp(lerpf(Camera.get_parent().spring_length,float(CameraLength),0.15),-8, 0)
					camparent.global_position = $Hub/Follow_Point.global_position
				
			else:
				CameraLength = clamp(CameraLength,-8, 0)
				Camera.get_parent().spring_length = clamp(lerpf(Camera.get_parent().spring_length,float(CameraLength),0.15),-8, 0)

				if CameraLength != 0:
					$Hub/Cubiix_Model.show()
					if shiftlock_Enabled:
						$Hub.rotation.y = Camera.get_parent().get_parent().get_parent().rotation.y
						Camera.get_parent().position.x = -.5
						camparent.global_position = $Hub/Follow_Point.global_position
						
					else:
						camparent.global_position = lerp(camparent.global_position,$Hub/Follow_Point.global_position,0.2)
						Camera.get_parent().position.x = 0
					if reset_camera:
						reset_camera = false
						var tween = get_tree().create_tween() \
						.set_ease(Tween.EASE_IN_OUT) \
						.set_trans(Tween.TRANS_QUAD) \
						.set_parallel(true)
						
						tween.tween_property(Camera.get_parent().get_parent().get_parent(),"global_rotation:y",$Hub.global_rotation.y,1)
						tween.tween_property(Camera.get_parent().get_parent(),"global_rotation:x",deg_to_rad(25),1)
				else:
					$Hub.rotation.y = Camera.get_parent().get_parent().get_parent().rotation.y
					$Hub/Cubiix_Model.hide()
					camparent.global_position = $Hub/Follow_Point.global_position
					if reset_camera:
						reset_camera = false

		
	if Is_Player && Is_Grinding:
		Is_Emoting = false
		Current_Emote = ""
		if Camera != null:
			Camera.fov = lerpf(Camera.fov,85,0.025)
		if CanRide:
			
			var RailPath = HitRail.get_node("Path3D")
			var RailPathFollow = RailPath.get_node("PathFollow3D")
			var RailPathTransform = RailPathFollow.get_node("RemoteTransform3D")
			var RailPathParticles = RailPathFollow.get_node("GPUParticles3D")
			if InitRail:
				InitRail = false
				var p_b = RailPath.curve.get_closest_point(RailPath.to_local(self.global_position))
				var p_c = RailPath.curve.get_closest_offset(p_b)
				RailPathFollow.progress = p_c
				await get_tree().physics_frame
				var playerdirection = $Hub.global_transform.basis.z
				RailDir = roundi(playerdirection.dot(RailPathFollow.get_node("RemoteTransform3D").global_transform.basis.z))
				if RailDir == 0:
					RailDir = 1
				if RailDir == 1:
					RotOffset = 0
					AltRiding = false
				else:
					RotOffset = 180
					AltRiding = true
					
				RailPathTransform.remote_path = get_path()
				RailPathParticles.emitting = true
			RailPathFollow.progress -= RailDir*(RailSpeed*delta)
			$Hub.quaternion = RailPathTransform.global_transform.basis.get_rotation_quaternion() * Quaternion.from_euler(Vector3(0,deg_to_rad(RotOffset),0))
			
			if IsTransfering:
				var movepath = movepoint.get_node("Path3D")
				var MovePathFollow = movepath.get_node("PathFollow3D")
				var MovePathTransform = MovePathFollow.get_node("RemoteTransform3D")
				MovePathFollow.progress -= RailDir*(RailSpeed*delta)
				self.global_position = self.global_position.move_toward(MovePathTransform.global_position, .14)
				print(self.global_position.distance_squared_to(MovePathTransform.global_position))

				if self.global_position.distance_squared_to(MovePathTransform.global_position) > 1.8 :
					IsTransfering = false
					HitRail = movepoint
					movepoint = null
					InitRail = true
					await get_tree().create_timer(0.4).timeout
					HopCooldown = false
				
			if (Input.is_action_just_pressed("ui_jump") && !IsTransfering) ||  ((RailPathFollow.progress_ratio == 1 || RailPathFollow.progress_ratio == 0 ) && !RailPathFollow.loop) :
				RailPathParticles.emitting = false
				CanRide = false
				BasePlayer_Disabled = false
				AltJump = true
				Is_Grinding = false
				$RayCast3D4/RailTimer.start()
				$Hub.rotation = up_direction

			if (Input.is_action_just_pressed("ui_left") || Input.is_action_just_pressed("ui_right")) && !HopCooldown && ActiveArea != null && !IsTransfering:
					if  (Input.is_action_just_pressed("ui_left")):
						if AltRiding:
							if ActiveArea.P_Right_Fixed != null:
								movepoint = ActiveArea.P_Right_Fixed
								Flip_B = true
						else:
							if ActiveArea.P_Left_Fixed  != null:
								Flip_B = true
								movepoint = ActiveArea.P_Left_Fixed
					elif (Input.is_action_just_pressed("ui_right")):
						if AltRiding:
							if ActiveArea.P_Left_Fixed != null:
								Flip_B = false
								movepoint = ActiveArea.P_Left_Fixed
						else:
							if ActiveArea.P_Right_Fixed != null:
								Flip_B = false
								movepoint = ActiveArea.P_Right_Fixed
					
					if movepoint != null:
						IsTransfering = true
						HopCooldown = true
						var movepath = movepoint.get_node("Path3D")
						var MovePathFollow = movepath.get_node("PathFollow3D")
						var MovePathTransform = MovePathFollow.get_node("RemoteTransform3D")
						var MovePathParticles = MovePathFollow.get_node("GPUParticles3D")
						var p_b = movepath.curve.get_closest_point(movepoint.to_local(self.global_position))
						var p_c = movepath.curve.get_closest_offset(p_b)
						MovePathFollow.progress = p_c
						MovePathFollow.progress -= RailDir*(RailSpeed*delta)
						RailPathTransform.remote_path = NodePath("")
						MovePathTransform.remote_path = NodePath("")
						RailPathParticles.emitting = false

						
				
	if Is_Player && !BasePlayer_Disabled:
		var camparent
		if Camera != null:
			Camera.fov = lerpf(Camera.fov,56.3,0.1)
			camparent = Camera.get_parent().get_parent().get_parent().get_parent()
		forcingUp = false
		cache_data["Player_Position"] = self.global_position
		if customizing:
			input = Vector2.ZERO
		
		if input != Vector2.ZERO:
			if !cam_swapped:
				if Camera != null: 
					MoveMarker.rotation.y = atan2(-input.x,-input.y)+Camera.get_parent().get_parent().get_parent().transform.basis.get_euler().y
					if !shiftlock_Enabled:
						$Hub.rotation.y = lerp_angle($Hub.rotation.y, MoveMarker.rotation.y, delta*10)

		if $RayCast3D.is_colliding() || is_on_floor():
			if anti_grav_enabled:
				transform.basis = align_up(transform.basis, $RayCast3D.get_collision_normal(), 0.15)
				if Camera != null:
					if target_camera_position != null:
						camparent.transform = target_camera_position.transform
					else:
						camparent.global_transform.basis = global_transform.basis
				
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
					
			gravity_control += (MoveMarker.global_transform.basis.y * 1) * (gravity/8)
			
			if up_direction > gravity_control:
				falling = true
				if $RayCast3D4.is_colliding() && CanRide:
					BasePlayer_Disabled = true
					Is_Grinding = true
					HitRail = $RayCast3D4.get_collider().get_parent()
					InitRail = true
					
					

			$RayCast3D.target_position = Vector3(0,-0.27,0)
			$RayCast3D2.target_position = Vector3(0,-0.27,0)
		
		if !forcingUp:
			if walk:
				speed = walkspeed
			else:
				speed = runspeed
				
			if (Input.is_action_just_pressed("ui_jump") && !jumping && !Core.Persistant_Core.Menu_Focused) || (AltJump):
				Is_Emoting = false
				Current_Emote = ""
				$JumpTimer.start()
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
			$JumpTimer.stop()
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


func _on_rail_timer_timeout() -> void:
	CanRide = true

func _on_jump_timer_timeout() -> void:
	jumping = false

func add_new_item(ItemID:String) -> void:
	var item = Core.AssetData.Item_Data_Assets[ItemID]
	var LoadedItem = item["path"].duplicate()
	
	match item["attachpoint"]:
		"Hand_R":
			for i in RightHandPoint.get_children():
				i.queue_free()
			RightHandPoint.add_child(LoadedItem)

func play_new_emote(EmoteID:String) -> bool:
	if Emote_Anims.has(EmoteID) && (!Is_Sitting && !Is_Piloting && !Is_Grinding && !falling && !jumping):
		Is_Emoting = true
		Current_Emote = EmoteID
		return true
	else:
		return false
