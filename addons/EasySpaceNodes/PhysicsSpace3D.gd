class_name PhysicsSpace3D
extends Node3D

var NewSpace:RID

func _ready() -> void:
	NewSpace = PhysicsServer3D.space_create()
	_propagate_enter_space(self)
	child_entered_tree.connect(_propagate_enter_space.bind())

func _propagate_enter_space(NodeVal:Node) -> void:
	if (NodeVal is StaticBody3D || 
	   NodeVal is RigidBody3D || 
	   NodeVal is CharacterBody3D):
		PhysicsServer3D.body_set_space(NodeVal.get_rid(), NewSpace)
		PhysicsServer3D.space_set_active(NewSpace,true)
		for i in NodeVal.get_child_count():
			_propagate_enter_space(NodeVal.get_child(i))
	elif (NodeVal is SoftBody3D):
		PhysicsServer3D.soft_body_set_space(NodeVal.get_rid(), NewSpace)
		PhysicsServer3D.space_set_active(NewSpace,true)
		for i in NodeVal.get_child_count():
			_propagate_enter_space(NodeVal.get_child(i))
	elif (NodeVal is Area3D):
		PhysicsServer3D.area_set_space(NodeVal.get_rid(), NewSpace)
		PhysicsServer3D.space_set_active(NewSpace,true)
		for i in NodeVal.get_child_count():
			_propagate_enter_space(NodeVal.get_child(i))
	elif (NodeVal is PhysicsSpace3D && NodeVal != self):
		pass
	else:
		for i in NodeVal.get_child_count():
			_propagate_enter_space(NodeVal.get_child(i))
