extends Node3D
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
@onready var ControllerID = 0
##Get the actual player object
@onready var Character = get_parent()

## These are all the different bits of the camera
var Camera_Core:Node3D
var Camera_Y:Node3D
var Camera_X:Node3D
var Camera_Z:SpringArm3D
var Camera:Camera3D
var Sensitivity:float = 5
var Controller_Sensitivity:float = .6
var CameraZoom:float = -4.0
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
	#print("We Made it, Too!")
	

func _physics_process(delta: float) -> void:
	if Camera_Core != null:
		if CameraZoom == 0:
			Camera_Core.transform = get_parent().transform
		else:
			Camera_Core.transform = get_parent().transform
		Camera_Y.position.y = 0.7
		


func _process(delta: float) -> void:
	if Core.Globals.local_inputs[ControllerID].Current_Input["Mode"] == "Keyboard" && Core.Globals.local_inputs[ControllerID].Current_Input["Keyboard_Mouse_Rotate_Down"]:
		Camera_Y.rotation_degrees.y -= Core.Globals.local_inputs[ControllerID].Current_Input["Joy_2_Input"].x/Sensitivity
		Camera_X.rotation_degrees.x += Core.Globals.local_inputs[ControllerID].Current_Input["Joy_2_Input"].y/Sensitivity
		Camera_X.rotation_degrees.x =  clampf(Camera_X.rotation_degrees.x,-90,90)
	elif Core.Globals.local_inputs[ControllerID].Current_Input["Mode"] == "Controller":
		Camera_Y.rotation_degrees.y -= Core.Globals.local_inputs[ControllerID].Current_Input["Joy_2_Input"].x*Sensitivity
		Camera_X.rotation_degrees.x += Core.Globals.local_inputs[ControllerID].Current_Input["Joy_2_Input"].y*Sensitivity
		Camera_X.rotation_degrees.x =  clampf(Camera_X.rotation_degrees.x,-90,90)

	if Core.Globals.local_inputs[ControllerID].Current_Input["Shoulder_Button_Input_Just_Pressed"]["Right"]:
		CameraZoom += 1
	elif Core.Globals.local_inputs[ControllerID].Current_Input["Shoulder_Button_Input_Just_Pressed"]["Left"]:
		CameraZoom -= 1
			
	CameraZoom = clampf(CameraZoom, -10,0)
	
	
	Camera_Z.spring_length = lerpf(Camera_Z.spring_length,CameraZoom,0.15)
	
