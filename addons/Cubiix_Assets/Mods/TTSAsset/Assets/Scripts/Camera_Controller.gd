extends Node3D

##Get the actual player object
@onready var Character = get_parent()

## These are all the different bits of the camera
var Camera_Core:Node3D
var Camera_Y:Node3D
var Camera_X:Node3D
var Camera_Z:SpringArm3D
var Camera:Camera3D
var Sensitivity = 5

signal CameraSetup

func setup() -> void:
	## Grabbing the actual nodes we need
	Camera_Core = get_node("../../Core_Follow")
	Camera_Y = Camera_Core.get_node("Rot_Y")
	Camera_X = Camera_Y.get_node("Rot_X")
	Camera_Z = Camera_X.get_node("Rot_Z")
	Camera = Camera_Z.get_node("Camera3D")
	
	call_deferred("emit_signal", "CameraSetup")
	

func _ready() -> void:
	setup()
	await Character.ScriptLoaded
	print("We Made it, Too!")
	

func _physics_process(delta: float) -> void:
	if Camera_Core != null:
		Camera_Core.transform = Camera_Core.transform.interpolate_with(get_parent().transform,0.15)
		Camera_Y.position.y = 0.5

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.is_action_pressed("mouse_right"):
			Camera_Y.rotation_degrees.y -= event.relative.x/Sensitivity
			Camera_X.rotation_degrees.x += event.relative.y/Sensitivity
