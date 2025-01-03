class_name Cubiix_LookAtBone
extends SkeletonModifier3D

@export var Target : Node3D = null
@export var Use_BoneName : String
@export var LookSpeed = 0.5

var targetBone = 0
var Alt_Pose:Basis = Basis()
var holderRotation = Transform3D()
var olddelta = 0.0
var delta = 0.0
func setup() -> void:
	#var debugcube = CSGBox3D.new()
	#debugcube.size = Vector3(.4,.4,.4)
	#add_child(debugcube)
	targetBone = get_skeleton().find_bone(Use_BoneName)
	self.global_position = (get_skeleton().global_transform * get_skeleton().get_bone_global_pose(targetBone)).origin

func _process_modification() -> void:
	var delta = olddelta
	self.global_position = (get_skeleton().global_transform * get_skeleton().get_bone_global_pose(targetBone)).origin
	if Target != null :
		self.look_at(Target.global_position+(Target.global_transform.basis.y * .5),Vector3(0,1,0),true)
		self.rotation = Vector3(clampf(self.rotation.x,deg_to_rad(-45),deg_to_rad(45)),clampf(self.rotation.y,deg_to_rad(-45),deg_to_rad(45)),clampf(self.rotation.z,deg_to_rad(-45),deg_to_rad(45)))
	elif Target == null:
		if Alt_Pose != Basis():
			self.transform.basis = Alt_Pose
		else:
			self.look_at(self.global_position + get_parent().global_transform.basis.z,Vector3(0,1,0),true)
	
	holderRotation = holderRotation.interpolate_with(self.transform,5*delta)
	var new_transform = Transform3D(holderRotation.basis,self.position)
	
	if targetBone != -1:
		get_skeleton().set_bone_global_pose(targetBone,new_transform)

	olddelta = get_process_delta_time()
