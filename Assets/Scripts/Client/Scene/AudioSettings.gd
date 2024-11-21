@tool
extends Marker3D

@export_enum(
	"FishShop",
	"Trinket"
	) var SongID : String = ""

@export_range(0.0,999999.0) var Tag_Radius : float = 1.0 :
	set(value):
		Tag_Radius = value
		_adjust_radius(value)
		
func _adjust_radius(size:float) -> void:
	if Engine.is_editor_hint():
		if $CollisionShape3D.mesh == null:
			$CollisionShape3D.mesh = SphereMesh.new()
			$CollisionShape3D.mesh.radius = size
			$CollisionShape3D.mesh.height = size*2
		else:
			$CollisionShape3D.mesh.radius = size
			$CollisionShape3D.mesh.height = size*2
	else:
		$CollisionShape3D.mesh = null

func _ready() -> void:
	if Engine.is_editor_hint():
		$CollisionShape3D.mesh = $CollisionShape3D.mesh.duplicate(true)
