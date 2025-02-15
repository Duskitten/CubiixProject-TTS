extends MeshInstance3D

func _process(delta: float) -> void:
	self.rotate_y(self.rotation.x + deg_to_rad(0.1))
	get_surface_override_material(0).set_shader_parameter("FloatParameter", self.rotation.y*-14)
