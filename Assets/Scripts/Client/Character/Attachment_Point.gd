class_name Item_Attachment
extends SkeletonModifier3D

@export var target_bone = ""

func _process_modification() -> void:
	if get_parent() != null:
		transform = get_parent().get_bone_global_pose(get_parent().find_bone(target_bone))
