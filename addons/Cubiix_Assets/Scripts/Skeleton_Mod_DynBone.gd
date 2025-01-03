class_name Cubiix_DynBone
extends SkeletonModifier3D

var DynBones_Register = {}
var DynBones_CoreRot = {}
var DynBones_OldPos = {}
var DynBones_NodeTailsVal = {}
var DynBones_RealTails = {}
var DynBones_Parents = {}

signal RePositioned
var olddelta = 0.0


var oldSystem = false
var debug = false
var canrun = false

@onready var Skeleton:Skeleton3D = get_node("../")
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

func first_run():

	DynBones_OldPos = DynBones_Register.duplicate(true)
	DynBones_NodeTailsVal = DynBones_Register.duplicate(true)
	DynBones_CoreRot = DynBones_Register.duplicate(true)
	DynBones_RealTails = DynBones_Register.duplicate(true)
	

	##This is just some initialization stuff
	await RePositioned
	for x in DynBones_Register:
		for y in DynBones_Register[x]:
			var current_parent = Skeleton
			for z in DynBones_Register[x][y].size():
				var current_bone = DynBones_Register[x][y][z]
				DynBones_OldPos[x][y][z] = (Skeleton.global_transform * Skeleton.get_bone_global_pose(current_bone)).origin
				DynBones_NodeTailsVal[x][y][z] = Vector3.ZERO
				DynBones_CoreRot[x][y][z] = Skeleton.get_bone_pose_rotation(current_bone)
				if Skeleton.get_bone_children(current_bone).size() > 0:
					DynBones_RealTails[x][y][z] = (Skeleton.global_transform * Skeleton.get_bone_global_pose(Skeleton.get_bone_parent(current_bone))).affine_inverse() * ((Skeleton.global_transform * Skeleton.get_bone_global_pose(current_bone)) * Vector3(0,(Skeleton.global_transform * Skeleton.get_bone_global_pose(current_bone)).origin.distance_to((Skeleton.global_transform * Skeleton.get_bone_global_pose(Skeleton.get_bone_children(current_bone)[0])).origin),0))
				else:
					DynBones_RealTails[x][y][z] = (Skeleton.global_transform * Skeleton.get_bone_global_pose(Skeleton.get_bone_parent(current_bone))).affine_inverse() * ((Skeleton.global_transform * Skeleton.get_bone_global_pose(current_bone)) * Vector3(0,.2,0))
	canrun = true
		
func _process_modification() -> void:
	if canrun:
		for x in DynBones_Register:
			for y in DynBones_Register[x]:
				var settings = x["DynBone_Data"]["DynBone_Settings"][y]
				var damp_ratio = log(settings["dampening"]) / (-settings["osc_ps"] * settings["damp_time"])
				for z in DynBones_Register[x][y].size():
					var delta = olddelta
					var current_bone = DynBones_Register[x][y][z]
					
					var BoneParent = Skeleton.get_bone_global_pose(Skeleton.get_bone_parent(current_bone))
					var BonePos = Skeleton.get_bone_pose(current_bone)
					
					var extension_time = settings["extension_damp_time"] + (settings["extension_damp_time"]*(z))
					
					var realtail = DynBones_RealTails[x][y][z]
					var tailglobal = (Skeleton.global_transform * BoneParent) * realtail
					
					var osc_ps_cus = settings["osc_ps"] + extension_time
					var damp_ratio_cus = damp_ratio + extension_time
					var a = -2.0 * delta * damp_ratio_cus * osc_ps_cus
					var b = delta * osc_ps_cus * osc_ps_cus
					var pos_tar = tailglobal
					var vel_o = DynBones_NodeTailsVal[x][y][z]
					var pos_cur_o = DynBones_OldPos[x][y][z]
					DynBones_NodeTailsVal[x][y][z] += Vector3(a * vel_o.x + b  * (pos_tar.x - pos_cur_o.x),a * vel_o.y + b  * (pos_tar.y - pos_cur_o.y),a * vel_o.z + b  * (pos_tar.z - pos_cur_o.z))
					DynBones_OldPos[x][y][z] += (delta*vel_o)
					
					var ray_a :Vector3 =  (realtail - BonePos.origin).normalized()
					var ray_b :Vector3 =  ((Skeleton.global_transform * BoneParent).affine_inverse() * DynBones_OldPos[x][y][z] - BonePos.origin).normalized()
					
					var final_quaternion = Quaternion(ray_a,ray_b) * DynBones_CoreRot[x][y][z]
					Skeleton.set_bone_pose_rotation(current_bone,final_quaternion)
					
						
	olddelta = get_process_delta_time()
