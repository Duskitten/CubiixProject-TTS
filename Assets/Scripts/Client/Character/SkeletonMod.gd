class_name DynBone
extends SkeletonModifier3D

var DynBones_Register = {}
var DynBones_CoreVal = {}
var DynBones_OldVal = {}
var DynBones_Vel_O = {}
var DynBones_CoreRot = {}

var DynBones_Nodes = {}
var DynBones_OldPos = {}
var DynBones_NodeTailsVal = {}
var DynBones_RealTails = {}
var DynBones_Parents = {}

var olddelta = 0.0

var oldSystem = true
var debug = false

@onready var Skeleton:Skeleton3D = get_node("../")
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

func first_run():
	if oldSystem:
		DynBones_Nodes = DynBones_Register.duplicate(true)
		DynBones_OldPos = DynBones_Register.duplicate(true)
		DynBones_NodeTailsVal = DynBones_Register.duplicate(true)
		DynBones_CoreRot = DynBones_Register.duplicate(true)
		DynBones_RealTails = DynBones_Register.duplicate(true)
	else:
		DynBones_CoreVal = DynBones_Register.duplicate(true)
		DynBones_OldVal = DynBones_Register.duplicate(true)
		DynBones_Vel_O = DynBones_Register.duplicate(true)
		DynBones_CoreRot = DynBones_Register.duplicate(true)
	##This is just some initialization stuff
	for x in DynBones_Register:
		for y in DynBones_Register[x]:
			var current_parent = Skeleton
			for z in DynBones_Register[x][y].size():
				var current_bone = DynBones_Register[x][y][z]
				if oldSystem:
					if z == 0:
						current_parent = parent_check(current_bone)
					var new_node = Node3D.new()
					if debug:
						var box = CSGBox3D.new()
						box.size = Vector3(0.2,0.2,0.2)
						new_node.add_child(box)
					current_parent.add_child(new_node)
					new_node.quaternion = Skeleton.get_bone_pose_rotation(current_bone)
					new_node.position = Skeleton.get_bone_pose(current_bone).origin
					current_parent = new_node
					DynBones_Nodes[x][y][z] = new_node
					DynBones_OldPos[x][y][z] = new_node.global_position
					DynBones_NodeTailsVal[x][y][z] = Vector3.ZERO
					DynBones_CoreRot[x][y][z] = Skeleton.get_bone_pose_rotation(current_bone)
					DynBones_RealTails[x][y][z] = new_node.get_parent().to_local(new_node.to_global(Vector3.UP))
				else:
					var parent_bone = Skeleton.get_bone_parent(current_bone)
					var parent_pose_global = Skeleton.global_transform * Skeleton.get_bone_global_pose(parent_bone)
					var parent_pose_local = Skeleton.get_bone_pose(parent_bone)
					var bone_pose_global = Skeleton.global_transform * Skeleton.get_bone_global_pose(current_bone)
					var bone_pose_local = Skeleton.get_bone_pose(current_bone)
					var bone_pose_rest_global = Skeleton.global_transform * (Skeleton.get_bone_global_rest(current_bone))
					var bone_pose_rest_local = Skeleton.get_bone_rest(current_bone)
					
					DynBones_Vel_O[x][y][z] = Vector3.ZERO
					DynBones_OldVal[x][y][z] =  parent_pose_global.affine_inverse() * bone_pose_rest_local.origin
					DynBones_CoreVal[x][y][z] =  parent_pose_global.affine_inverse() * bone_pose_rest_local.basis.y
					DynBones_CoreRot[x][y][z] = Skeleton.get_bone_pose_rotation(current_bone)
					#print(DynBones_OldVal[x][y][z])

func parent_check(bone_old) -> Node3D:
	var current_bone = Skeleton.get_bone_parent(bone_old)
	if !DynBones_Parents.has(current_bone):
		var new_node = Node3D.new()
		new_node.quaternion = Skeleton.get_bone_pose_rotation(current_bone)
		new_node.position = Skeleton.get_bone_pose(current_bone).origin
		DynBones_Parents[current_bone] = {"Node":new_node,"Checked":false}
		Skeleton.add_child(new_node)
		return new_node
	return DynBones_Parents[current_bone]["Node"]
	
func parent_update(bone_old):
	var current_bone = Skeleton.get_bone_parent(bone_old)
	if DynBones_Parents.has(current_bone):
		if !DynBones_Parents[current_bone]["Checked"]:
			DynBones_Parents[current_bone]["Node"].transform = Skeleton.get_bone_pose(current_bone)
			DynBones_Parents[current_bone]["Checked"] = true
		
func _process_modification() -> void:
	for x in DynBones_Register:
		for y in DynBones_Register[x]:
			var settings = Core.AssetData.Mesh_Data_Assets[x]["DynBone_Data"]["DynBone_Settings"][y]
			var damp_ratio = log(settings["dampening"]) / (-settings["osc_ps"] * settings["damp_time"])
			for z in DynBones_Register[x][y].size():
				var delta = Time.get_ticks_msec()/1000.0 - olddelta
				var current_bone = DynBones_Register[x][y][z]
				if oldSystem:
					if z == 0:
						parent_update(current_bone)
					var current_node = DynBones_Nodes[x][y][z]
					var extension_time = settings["extension_damp_time"] + (settings["extension_damp_time"]*(z))
					
					var realtail = DynBones_RealTails[x][y][z]
					var tailglobal = current_node.get_parent().to_global(realtail)
					
					var osc_ps_cus = settings["osc_ps"] + extension_time
					var damp_ratio_cus = damp_ratio + extension_time
					var a = -2.0 * delta * damp_ratio_cus * osc_ps_cus
					var b = delta * osc_ps_cus * osc_ps_cus
					var pos_tar = tailglobal
					var vel_o = DynBones_NodeTailsVal[x][y][z]
					var pos_cur_o = DynBones_OldPos[x][y][z]
					DynBones_NodeTailsVal[x][y][z] += Vector3(a * vel_o.x + b  * (pos_tar.x - pos_cur_o.x),a * vel_o.y + b  * (pos_tar.y - pos_cur_o.y),a * vel_o.z + b  * (pos_tar.z - pos_cur_o.z))
					DynBones_OldPos[x][y][z] += (delta*vel_o)
					
					var ray_a :Vector3 =  current_node.position.direction_to(realtail)
					var ray_b :Vector3 =  current_node.position.direction_to(current_node.get_parent().to_local(DynBones_OldPos[x][y][z]))
					
					var final_quaternion = Quaternion(ray_a,ray_b) * DynBones_CoreRot[x][y][z]
					current_node.quaternion = final_quaternion
					Skeleton.set_bone_pose_rotation(current_bone,final_quaternion)
				else:
					var extension_time = settings["extension_damp_time"] + (settings["extension_damp_time"]*(z))
					var parent_bone = Skeleton.get_bone_parent(current_bone)
					var parent_pose_global = Skeleton.global_transform * Skeleton.get_bone_global_pose(parent_bone)
					var parent_pose_local = Skeleton.get_bone_pose(parent_bone)
					var bone_pose_global = Skeleton.global_transform * Skeleton.get_bone_global_pose(current_bone)
					var bone_pose_local = Skeleton.get_bone_pose(current_bone)
					var bone_pose_rest_global = Skeleton.global_transform * (Skeleton.get_bone_global_rest(current_bone))
					var bone_pose_rest_local = Skeleton.get_bone_rest(current_bone)
					
					
					##semi-implicit-euler-updater
					var osc_ps_cus = settings["osc_ps"] + extension_time
					var damp_ratio_cus = damp_ratio + extension_time
					var a = -2.0 * delta * damp_ratio_cus * osc_ps_cus
					var b = delta * osc_ps_cus * osc_ps_cus
					
					var pos_tar = Skeleton.global_transform*DynBones_CoreVal[x][y][z]
					var vel_o = DynBones_Vel_O[x][y][z]
					var pos_cur_o = DynBones_OldVal[x][y][z]
					DynBones_Vel_O[x][y][z] += Vector3(a * vel_o.x + b  * (pos_tar.x - pos_cur_o.x),a * vel_o.y + b  * (pos_tar.y - pos_cur_o.y),a * vel_o.z + b  * (pos_tar.z - pos_cur_o.z))
					DynBones_OldVal[x][y][z] += (delta*vel_o)
					
					#print(DynBones_OldVal[x][y][z])
	
					#Begin our direction calc
					#Something is going wrong here, not sure what
					var ray_a :Vector3 =  bone_pose_local.origin.direction_to(parent_pose_local.affine_inverse() * bone_pose_rest_local.basis.y)
					var ray_b :Vector3 =  bone_pose_local.origin.direction_to(parent_pose_local.affine_inverse() * (bone_pose_rest_local.basis.y - (pos_tar-DynBones_OldVal[x][y][z])))
					
					var final_quaternion = Quaternion(ray_a,ray_b) * DynBones_CoreRot[x][y][z]
					Skeleton.set_bone_pose_rotation(current_bone,final_quaternion)

	olddelta = Time.get_ticks_msec()/1000.0 
	
	if oldSystem:
		for i in DynBones_Parents.keys():
			DynBones_Parents[i]["Checked"] = false
