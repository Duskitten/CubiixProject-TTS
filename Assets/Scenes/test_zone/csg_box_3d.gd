extends CSGBox3D

func _ready() -> void:
	var packedArry = [
		Color(1,1,1,1),
		Color(1,1,0,1),Color(1,0,1,1),
		Color(1,0,1,1),Color(1,1,1,0),Color(0,1,1,1),Color(1,1,1,1)
		]
	packedArry.resize(36)
	self.material.set_shader_parameter("Body_Color", packedArry)
