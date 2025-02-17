extends Control
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
@onready var Shapecast = $TextureRect/Control/SubViewportContainer/SubViewport/Node3D/Node3D/Main_Camera3D/ShapeCast3D
@onready var CameraParent = $TextureRect/Control/SubViewportContainer/SubViewport/Node3D/Node3D
@onready var Camera = $TextureRect/Control/SubViewportContainer/SubViewport/Node3D/Node3D/Main_Camera3D
@onready var SliderX = $VBoxContainer/ScrollContainer/VBoxContainer/X
@onready var SliderY = $VBoxContainer/ScrollContainer/VBoxContainer/Y
@onready var Location = $TextureRect/Control/SubViewportContainer/SubViewport/Node3D/Control/Location
@onready var Planet_Data = $TextureRect/Control/SubViewportContainer/SubViewport/Node3D/Control/Planet_Data

var XRot = 0
var YRot = 0

func _on_value_changed(value: float, extra_arg_0: bool) -> void:
	match extra_arg_0:
		true:
			XRot = value
		false:
			YRot = value

func _process(delta: float) -> void:
	if Core.SceneData.Current_SceneID == "TTSAssets/Hexstaria_V2":
		var Telescope = Core.SceneData.Scene_Root.get_node_or_null("Client/Map/HexstariaV2-Mesh/Isle_3/Observatory_Gears")
		if Telescope != null:
			Telescope.New_Y = CameraParent.rotation_degrees.y
			Telescope.New_Z = Camera.rotation_degrees.x
		
		CameraParent.rotation.y = lerp_angle(CameraParent.rotation.y, CameraParent.rotation.y+deg_to_rad(XRot), 0.01)
		Camera.rotation.x = lerp_angle(Camera.rotation.x, deg_to_rad(clamp(rad_to_deg(Camera.rotation.x + deg_to_rad(YRot)),0,85)),0.01)
		#print(CameraParent.rotation.y)
		if rad_to_deg(CameraParent.rotation.y) < 360:
			CameraParent.rotation.y += deg_to_rad(360)
		Location.text = "[color=green]X:"+str(snappedf(fmod(rad_to_deg(CameraParent.rotation.y),360), 0.1)) +"\nY:"+str(snappedf(rad_to_deg(Camera.rotation.x),0.1))

func _physics_process(delta: float) -> void:
	var Name = "Unknown"
	var Owner = "-"
	var Desc = "-No Planet Data Found-"
	if Shapecast.is_colliding():
		Name = Shapecast.get_collider(0).get_meta("Planet_Name")
		Owner = Shapecast.get_collider(0).get_meta("Planet_Owner")
		Desc = Shapecast.get_collider(0).get_meta("Planet_Desc")

	Planet_Data.text = "[center][color=green]" + Name + "\n[font_size=10] Owned by :" + Owner + "\n" + Desc
	
