extends MeshInstance3D

@export var New_Y = 0.0
@export_range(0.0,85.0) var New_Z = 0.0
func _process(delta: float) -> void:
	update_rotation_points(deg_to_rad(New_Y), deg_to_rad(New_Z))
	
func update_rotation_points(Y:float, Z: float) -> void:
	self.rotation.y = lerp_angle(self.rotation.y,Y,0.1)
	$Telescope.rotation.z = lerp_angle($Telescope.rotation.z,Z,0.1)
	get_surface_override_material(0).set_shader_parameter("FloatParameter", self.rotation.y*-14)
