extends Node
class_name InputController

@export var ControllerInput := 0
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

var Current_Input = {
	"Mode":"Controller",
	"Controller_Type":"Playstation",
	"Keyboard_Mouse_Rotate_Down":false,
	
	"DPad_Input":Vector2.ZERO,  ## Try to restrict to menu stuff
	"DPad_Input_Pressed_Up":false,
	"DPad_Input_Pressed_Down":false,
	"DPad_Input_Pressed_Left":false,
	"DPad_Input_Pressed_Right":false,
	"DPad_Input_Just_Pressed_Up":false,
	"DPad_Input_Just_Pressed_Down":false,
	"DPad_Input_Just_Pressed_Left":false,
	"DPad_Input_Just_Pressed_Right":false,
	"DPad_Input_Just_Released_Up":false,
	"DPad_Input_Just_Released_Down":false,
	"DPad_Input_Just_Released_Left":false,
	"DPad_Input_Just_Released_Right":false,
	
	"Joy_1_Input":Vector2.ZERO, ## Try to restrict to movement stuff
	"Joy_2_Input":Vector2.ZERO, ## Try to restrict to camera stuff
	
	"Button_Input_Pressed_Up":false,
	"Button_Input_Pressed_Down":false,
	"Button_Input_Pressed_Left":false,
	"Button_Input_Pressed_Right":false,
	
	"Button_Input_Just_Pressed_Up":false,
	"Button_Input_Just_Pressed_Down":false,
	"Button_Input_Just_Pressed_Left":false,
	"Button_Input_Just_Pressed_Right":false,
	"Button_Input_Just_Released_Up":false,
	"Button_Input_Just_Released_Down":false,
	"Button_Input_Just_Released_Left":false,
	"Button_Input_Just_Released_Right":false,

	"Shoulder_Button_Input_Pressed_Left":false,
	"Shoulder_Button_Input_Pressed_Right":false,
	"Shoulder_Button_Input_Just_Pressed_Left":false,
	"Shoulder_Button_Input_Just_Pressed_Right":false,
	"Shoulder_Button_Input_Just_Released_Left":false,
	"Shoulder_Button_Input_Just_Released_Right":false,

	"Trigger_Input_Left":0,
	"Trigger_Input_Right":0,
	
	## Unsure What will use for
	"Menu_Button_Input_Pressed_":false,
	"Menu_Button_Input_Just_Pressed_":false,
	"Menu_Button_Input_Just_Released_":false,
}

var ControllerInputImages = {
	"Playstation":{
		#Button Buttons
		"{ControllerInputUB}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Tri_Green.png",
		"{ControllerInputDB}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/X_Blue.png",
		"{ControllerInputLB}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Square_Pink.png",
		"{ControllerInputRB}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/O_Red.png",
		#D-Pad
		"{ControllerInputUDP}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Up_Dpad.png",
		"{ControllerInputDDP}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Down_Dpad.png",
		"{ControllerInputLDP}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Left_Dpad.png",
		"{ControllerInputRDP}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Right_Dpad.png",
		#Joy1
		"{ControllerInputUJ1}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Left_Joystick_Up.png",
		"{ControllerInputDJ1}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Left_Joystick_Down.png",
		"{ControllerInputLJ1}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Left_Joystick_Left.png",
		"{ControllerInputRJ1}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Left_Joystick_Right.png",
		#Joy2
		"{ControllerInputUJ2}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Right_Joystick_Up.png",
		"{ControllerInputDJ2}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Right_Joystick_Down.png",
		"{ControllerInputLJ2}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Right_Joystick_Left.png",
		"{ControllerInputRJ2}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Right_Joystick_Right.png",
		#Shoulder Buttons
		"{ControllerInputLSB}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/L1_Grey.png",
		"{ControllerInputRSB}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/R1_Grey.png",
		#Trigger Buttons
		"{ControllerInputLTB}":"",
		"{ControllerInputRTB}":"",
		#Menu Button
		"{ControllerInputMB}":"",
	},
	"Xbox":{
		#Button Buttons
		"{ControllerInputUB}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Y_Yellow.png",
		"{ControllerInputDB}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/A_Green.png",
		"{ControllerInputLB}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/X_Blue.png",
		"{ControllerInputRB}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/B_Red.png",
		#D-Pad
		"{ControllerInputUDP}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Up_Dpad.png",
		"{ControllerInputDDP}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Down_Dpad.png",
		"{ControllerInputLDP}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Left_Dpad.png",
		"{ControllerInputRDP}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Right_Dpad.png",
				#Joy1
		"{ControllerInputUJ1}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Left_Joystick_Up.png",
		"{ControllerInputDJ1}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Left_Joystick_Down.png",
		"{ControllerInputLJ1}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Left_Joystick_Left.png",
		"{ControllerInputRJ1}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Left_Joystick_Right.png",
		#Joy2
		"{ControllerInputUJ2}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Right_Joystick_Up.png",
		"{ControllerInputDJ2}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Right_Joystick_Down.png",
		"{ControllerInputLJ2}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Right_Joystick_Left.png",
		"{ControllerInputRJ2}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Right_Joystick_Right.png",
		#Shoulder Buttons
		"{ControllerInputLSB}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/LB_Grey.png",
		"{ControllerInputRSB}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/RB_Grey.png",
		#Trigger Buttons
		"{ControllerInputLTB}":"",
		"{ControllerInputRTB}":"",
		#Menu Button
		"{ControllerInputMB}":"",
	},
	"Nintendo":{
		#Button Buttons
		"{ControllerInputUB}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/X_Blue.png",
		"{ControllerInputDB}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/B_Yellow.png",
		"{ControllerInputLB}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Y_Green.png",
		"{ControllerInputRB}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/A_Red.png",
		#D-Pad
		"{ControllerInputUDP}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Up_Dpad.png",
		"{ControllerInputDDP}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Down_Dpad.png",
		"{ControllerInputLDP}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Left_Dpad.png",
		"{ControllerInputRDP}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Right_Dpad.png",
				#Joy1
		"{ControllerInputUJ1}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Left_Joystick_Up.png",
		"{ControllerInputDJ1}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Left_Joystick_Down.png",
		"{ControllerInputLJ1}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Left_Joystick_Left.png",
		"{ControllerInputRJ1}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Left_Joystick_Right.png",
		#Joy2
		"{ControllerInputUJ2}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Right_Joystick_Up.png",
		"{ControllerInputDJ2}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Right_Joystick_Down.png",
		"{ControllerInputLJ2}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Right_Joystick_Left.png",
		"{ControllerInputRJ2}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Right_Joystick_Right.png",
		#Shoulder Buttons
		"{ControllerInputLSB}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/LB_Grey.png",
		"{ControllerInputRSB}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/RB_Grey.png",
		#Trigger Buttons
		"{ControllerInputLTB}":"",
		"{ControllerInputRTB}":"",
		#Menu Button
		"{ControllerInputMB}":"",
	},
	"Keyboard":{
		#Where To Find New Keys
		"Find_Key":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Keyboard_Keys/",
		#Button Buttons
		
		"{ControllerInputUB}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/X_Blue.png",
		"{ControllerInputDB}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/B_Yellow.png",
		"{ControllerInputLB}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Y_Green.png",
		"{ControllerInputRB}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/A_Red.png",
		#D-Pad
		"{ControllerInputUDP}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Up_Dpad.png",
		"{ControllerInputDDP}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Down_Dpad.png",
		"{ControllerInputLDP}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Left_Dpad.png",
		"{ControllerInputRDP}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Right_Dpad.png",
				#Joy1
		"{ControllerInputUJ1}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Left_Joystick_Up.png",
		"{ControllerInputDJ1}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Left_Joystick_Down.png",
		"{ControllerInputLJ1}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Left_Joystick_Left.png",
		"{ControllerInputRJ1}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Left_Joystick_Right.png",
		#Joy2
		"{ControllerInputUJ2}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Right_Joystick_Up.png",
		"{ControllerInputDJ2}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Right_Joystick_Down.png",
		"{ControllerInputLJ2}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Right_Joystick_Left.png",
		"{ControllerInputRJ2}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Right_Joystick_Right.png",
		#Shoulder Buttons
		"{ControllerInputLSB}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/LB_Grey.png",
		"{ControllerInputRSB}":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/RB_Grey.png",
		#Trigger Buttons
		"{ControllerInputLTB}":"",
		"{ControllerInputRTB}":"",
		#Menu Button
		"{ControllerInputMB}":"",
	}
	
	
}

var Keyboard_Translation = {
	"Keyboard_Button_Up":"{ControllerInputUB}",
	"Keyboard_Button_Down":"{ControllerInputDB}",
	"Keyboard_Button_Left":"{ControllerInputLB}",
	"Keyboard_Button_Right":"{ControllerInputRB}",
	
	"Keyboard_DPad_Up":"{ControllerInputUDP}",
	"Keyboard_DPad_Down":"{ControllerInputDDP}",
	"Keyboard_DPad_Left":"{ControllerInputLDP}",
	"Keyboard_DPad_Right":"{ControllerInputRDP}",
	
	"Keyboard_Shoulder_Button_Left": "{ControllerInputLSB}",
	"Keyboard_Shoulder_Button_Right": "{ControllerInputRSB}",
	
	"Keyboard_Trigger_Left": "{ControllerInputLTB}",
	"Keyboard_Trigger_Right": "{ControllerInputRTB}",
	
	"Keyboard_Joy_Up":"{ControllerInputUJ1}",
	"Keyboard_Joy_Down":"{ControllerInputDJ1}",
	"Keyboard_Joy_Left":"{ControllerInputLJ1}",
	"Keyboard_Joy_Right":"{ControllerInputRJ1}",
	
	"Keyboard_Menu":"{ControllerInputMB}",
}

var InputOverride_Defaults = {
	"{ColorInput_A}":[ ["DPad","Left"] ,["DPad","Left"]],
	"{ColorInput_B}":[ ["DPad","Left"] ,["DPad","Left"]],
	"{ColorInput_C}":[ ["DPad","Left"] ,["DPad","Left"]],
	"{ColorInput_D}":[ ["DPad","Left"] ,["DPad","Left"]],
	"{Interact_Key}":[ ["Button","Down"] , ["Button","Down"] ],
	"{UI_Up}":[ ["DPad","Up"] , ["DPad","Up"] ],
	"{UI_Down}":[ ["DPad","Down"] , ["DPad","Down"] ],
	"{UI_Left}":[ ["DPad","Left"] , ["DPad","Left"] ],
	"{UI_Right}":[ ["DPad","Right"] , ["DPad","Right"] ],
	"{Walk_Forwards}":[ ["DPad","Up"] , ["DPad","Up"] ],
	"{Walk_Backwards}":[ ["DPad","Down"] , ["DPad","Down"] ],
	"{Walk_Left}":[ ["DPad","Left"] , ["DPad","Left"] ],
	"{Walk_Right}":[ ["DPad","Right"] , ["DPad","Right"] ],
}

var oldmouse_pos:Vector2
var Creator
var Key_Update_Checker:bool = false
var IsKeyboard:bool = true
var KeyKey = ""

signal Binded_Controller
signal Controller_Changed
func _init(creator,who) -> void:
	Creator = creator
	ControllerInput = who
	
func _ready() -> void:
	reset_keyboard_images()
	
func _input(event: InputEvent) -> void:
	controller_manager(event)
	if Key_Update_Checker && event.device == ControllerInput:
		if IsKeyboard && event is InputEventKey && ControllerInput == 0:
			Key_Update_Checker = false
			#print(event)
			emit_signal("Binded_Controller", true, event, KeyKey)
		elif !IsKeyboard && event is InputEventJoypadButton:
			Key_Update_Checker = false
			#print(event)
			emit_signal("Binded_Controller", true, event, KeyKey)
		elif event is InputEventKey || event is InputEventJoypadButton:
			Key_Update_Checker = false
			#print("Input Failed")
			emit_signal("Binded_Controller", false,{}, "")
			

func enable_key_update(KeyName) -> void:
	Key_Update_Checker = true
	KeyKey = KeyName
	if Current_Input["Mode"] == "Controller":
		IsKeyboard = false
	else:
		IsKeyboard = true

func controller_manager(event:InputEvent) -> void:
	if (event is InputEventJoypadMotion && (event["axis_value"] > 0.1 ||  event["axis_value"] < -0.1)) || event is InputEventJoypadButton:
		Current_Input["Mode"] = "Controller"
		if Input.get_joy_name(0).to_lower().contains("ps") || Input.get_joy_name(0).to_lower().contains("playstation") || Input.get_joy_name(0).to_lower().contains("sony"):
			if Current_Input["Controller_Type"] != "Playstation":
				Current_Input["Controller_Type"] = "Playstation"
				emit_signal("Controller_Changed")
		elif Input.get_joy_name(0).to_lower().contains("xbox") || Input.get_joy_name(0).to_lower().contains("microsoft") || Input.get_joy_name(0).to_lower().contains("360"):
			if Current_Input["Controller_Type"] != "Xbox":
				Current_Input["Controller_Type"] = "Xbox"
				emit_signal("Controller_Changed")
		else:
			if Current_Input["Controller_Type"] != "Nintendo":
				Current_Input["Controller_Type"] = "Nintendo"
				emit_signal("Controller_Changed")
			

	if (event is InputEventMouseButton || event is InputEventKey):
		if Current_Input["Controller_Type"] != "Keyboard":
			Current_Input["Mode"] = "Keyboard"
			Current_Input["Controller_Type"] = "Keyboard"
			emit_signal("Controller_Changed")

func _process(delta: float) -> void:
	match Current_Input["Mode"]:
		"Controller":
			##D-Pad
			Current_Input["DPad_Input"] = Input.get_vector("Controller_"+str(ControllerInput)+"_DPad_Left","Controller_"+str(ControllerInput)+"_DPad_Right","Controller_"+str(ControllerInput)+"_DPad_Up","Controller_"+str(ControllerInput)+"_DPad_Down")
			Current_Input["DPad_Input_Just_Pressed_Up"] = Input.is_action_just_pressed("Controller_"+str(ControllerInput)+"_DPad_Up")
			Current_Input["DPad_Input_Just_Pressed_Down"] = Input.is_action_just_pressed("Controller_"+str(ControllerInput)+"_DPad_Down")
			Current_Input["DPad_Input_Just_Pressed_Left"] = Input.is_action_just_pressed("Controller_"+str(ControllerInput)+"_DPad_Left")
			Current_Input["DPad_Input_Just_Pressed_Right"] = Input.is_action_just_pressed("Controller_"+str(ControllerInput)+"_DPad_Right")
			Current_Input["DPad_Input_Just_Released_Up"] = Input.is_action_just_released("Controller_"+str(ControllerInput)+"_DPad_Up")
			Current_Input["DPad_Input_Just_Released_Down"] = Input.is_action_just_released("Controller_"+str(ControllerInput)+"_DPad_Down")
			Current_Input["DPad_Input_Just_Released_Left"] = Input.is_action_just_released("Controller_"+str(ControllerInput)+"_DPad_Left")
			Current_Input["DPad_Input_Just_Released_Right"] = Input.is_action_just_released("Controller_"+str(ControllerInput)+"_DPad_Right")
			Current_Input["DPad_Input_Pressed_Up"] = Input.is_action_pressed("Controller_"+str(ControllerInput)+"_DPad_Up")
			Current_Input["DPad_Input_Pressed_Down"] = Input.is_action_pressed("Controller_"+str(ControllerInput)+"_DPad_Down")
			Current_Input["DPad_Input_Pressed_Left"] = Input.is_action_pressed("Controller_"+str(ControllerInput)+"_DPad_Left")
			Current_Input["DPad_Input_Pressed_Right"] = Input.is_action_pressed("Controller_"+str(ControllerInput)+"_DPad_Right")
			##Button Inputs X, Tri, etc
			Current_Input["Button_Input_Just_Pressed_Up"] = Input.is_action_just_pressed("Controller_"+str(ControllerInput)+"_Button_Up")
			Current_Input["Button_Input_Just_Pressed_Down"] = Input.is_action_just_pressed("Controller_"+str(ControllerInput)+"_Button_Down")
			Current_Input["Button_Input_Just_Pressed_Left"] = Input.is_action_just_pressed("Controller_"+str(ControllerInput)+"_Button_Left")
			Current_Input["Button_Input_Just_Pressed_Right"] = Input.is_action_just_pressed("Controller_"+str(ControllerInput)+"_Button_Right")
			Current_Input["Button_Input_Just_Released_Up"] = Input.is_action_just_released("Controller_"+str(ControllerInput)+"_Button_Up")
			Current_Input["Button_Input_Just_Released_Down"] = Input.is_action_just_released("Controller_"+str(ControllerInput)+"_Button_Down")
			Current_Input["Button_Input_Just_Released_Left"] = Input.is_action_just_released("Controller_"+str(ControllerInput)+"_Button_Left")
			Current_Input["Button_Input_Just_Released_Right"] = Input.is_action_just_released("Controller_"+str(ControllerInput)+"_Button_Right")
			Current_Input["Button_Input_Pressed_Up"] = Input.is_action_pressed("Controller_"+str(ControllerInput)+"_Button_Up")
			Current_Input["Button_Input_Pressed_Down"] = Input.is_action_pressed("Controller_"+str(ControllerInput)+"_Button_Down")
			Current_Input["Button_Input_Pressed_Left"] = Input.is_action_pressed("Controller_"+str(ControllerInput)+"_Button_Left")
			Current_Input["Button_Input_Pressed_Right"] = Input.is_action_pressed("Controller_"+str(ControllerInput)+"_Button_Right")
			#Joy Input
			
			if !Creator.Data["Controls_"+str(ControllerInput)]["Flip_Controller_Joysticks"]:
				Current_Input["Joy_1_Input"] = Input.get_vector("Controller_"+str(ControllerInput)+"_Joy_1_Left","Controller_"+str(ControllerInput)+"_Joy_1_Right","Controller_"+str(ControllerInput)+"_Joy_1_Up","Controller_"+str(ControllerInput)+"_Joy_1_Down")
				Current_Input["Joy_2_Input"] = Input.get_vector("Controller_"+str(ControllerInput)+"_Joy_2_Left","Controller_"+str(ControllerInput)+"_Joy_2_Right","Controller_"+str(ControllerInput)+"_Joy_2_Up","Controller_"+str(ControllerInput)+"_Joy_2_Down")
			else:
				Current_Input["Joy_1_Input"] = Input.get_vector("Controller_"+str(ControllerInput)+"_Joy_2_Left","Controller_"+str(ControllerInput)+"_Joy_2_Right","Controller_"+str(ControllerInput)+"_Joy_2_Up","Controller_"+str(ControllerInput)+"_Joy_2_Down")
				Current_Input["Joy_2_Input"] = Input.get_vector("Controller_"+str(ControllerInput)+"_Joy_1_Left","Controller_"+str(ControllerInput)+"_Joy_1_Right","Controller_"+str(ControllerInput)+"_Joy_1_Up","Controller_"+str(ControllerInput)+"_Joy_1_Down")
			
			#Menu Button
			Current_Input["Menu_Button_Input_Pressed_"] = Input.is_action_pressed("Controller_"+str(ControllerInput)+"_Menu")
			Current_Input["Menu_Button_Input_Just_Pressed_"] = Input.is_action_just_pressed("Controller_"+str(ControllerInput)+"_Menu")
			Current_Input["Menu_Button_Input_Just_Released_"] = Input.is_action_just_released("Controller_"+str(ControllerInput)+"_Menu")
	
			#Shoulders
			Current_Input["Shoulder_Button_Input_Just_Pressed_Left"] = Input.is_action_just_pressed("Controller_"+str(ControllerInput)+"_Shoulder_Button_Left")
			Current_Input["Shoulder_Button_Input_Just_Pressed_Right"] = Input.is_action_just_pressed("Controller_"+str(ControllerInput)+"_Shoulder_Button_Right")
			Current_Input["Shoulder_Button_Input_Just_Released_Left"] = Input.is_action_just_released("Controller_"+str(ControllerInput)+"_Shoulder_Button_Left")
			Current_Input["Shoulder_Button_Input_Just_Released_Right"] = Input.is_action_just_released("Controller_"+str(ControllerInput)+"_Shoulder_Button_Right")
			Current_Input["Shoulder_Button_Input_Pressed_Left"] = Input.is_action_pressed("Controller_"+str(ControllerInput)+"_Shoulder_Button_Left")
			Current_Input["Shoulder_Button_Input_Pressed_Right"] = Input.is_action_pressed("Controller_"+str(ControllerInput)+"_Shoulder_Button_Right")
		
			#Triggers
			Current_Input["Trigger_Input_Left"] = Input.get_action_raw_strength("Controller_"+str(ControllerInput)+"_Trigger_Left")
			Current_Input["Trigger_Input_Right"] = Input.get_action_raw_strength("Controller_"+str(ControllerInput)+"_Trigger_Right")
		"Keyboard":
			Current_Input["DPad_Input"] = Input.get_vector("Keyboard_DPad_Left","Keyboard_DPad_Right","Keyboard_DPad_Up","Keyboard_DPad_Down")
			Current_Input["DPad_Input_Just_Pressed_Up"] = Input.is_action_just_pressed("Keyboard_DPad_Up")
			Current_Input["DPad_Input_Just_Pressed_Down"] = Input.is_action_just_pressed("Keyboard_DPad_Down")
			Current_Input["DPad_Input_Just_Pressed_Left"] = Input.is_action_just_pressed("Keyboard_DPad_Left")
			Current_Input["DPad_Input_Just_Pressed_Right"] = Input.is_action_just_pressed("Keyboard_DPad_Right")
			Current_Input["DPad_Input_Just_Released_Up"] = Input.is_action_just_released("Keyboard_DPad_Up")
			Current_Input["DPad_Input_Just_Released_Down"] = Input.is_action_just_released("Keyboard_DPad_Down")
			Current_Input["DPad_Input_Just_Released_Left"] = Input.is_action_just_released("Keyboard_DPad_Left")
			Current_Input["DPad_Input_Just_Released_Right"] = Input.is_action_just_released("Keyboard_DPad_Right")
			##Button Inputs X, Tri, etc
			Current_Input["Button_Input_Just_Pressed_Up"] = Input.is_action_just_pressed("Keyboard_Button_Up")
			Current_Input["Button_Input_Just_Pressed_Down"] = Input.is_action_just_pressed("Keyboard_Button_Down")
			Current_Input["Button_Input_Just_Pressed_Left"] = Input.is_action_just_pressed("Keyboard_Button_Left")
			Current_Input["Button_Input_Just_Pressed_Right"] = Input.is_action_just_pressed("Keyboard_Button_Right")
			Current_Input["Button_Input_Just_Released_Up"] = Input.is_action_just_released("Keyboard_Button_Up")
			Current_Input["Button_Input_Just_Released_Down"] = Input.is_action_just_released("Keyboard_Button_Down")
			Current_Input["Button_Input_Just_Released_Left"] = Input.is_action_just_released("Keyboard_Button_Left")
			Current_Input["Button_Input_Just_Released_Right"] = Input.is_action_just_released("Keyboard_Button_Right")
			Current_Input["Button_Input_Pressed_Up"] = Input.is_action_pressed("Keyboard_Button_Up")
			Current_Input["Button_Input_Pressed_Down"] = Input.is_action_pressed("Keyboard_Button_Down")
			Current_Input["Button_Input_Pressed_Left"] = Input.is_action_pressed("Keyboard_Button_Left")
			Current_Input["Button_Input_Pressed_Right"] = Input.is_action_pressed("Keyboard_Button_Right")
			#Joy Input
			Current_Input["Joy_1_Input"] = Input.get_vector("Keyboard_Joy_Left","Keyboard_Joy_Right","Keyboard_Joy_Up","Keyboard_Joy_Down")
			Current_Input["Joy_2_Input"] = get_viewport().get_mouse_position()-oldmouse_pos
			#Menu Button
			Current_Input["Menu_Button_Pressed_"] = Input.is_action_pressed("Keyboard_Menu")
			Current_Input["Menu_Button_Just_Pressed_"] = Input.is_action_just_pressed("Keyboard_Menu")
			Current_Input["Menu_Button_Just_Released_"] = Input.is_action_just_released("Keyboard_Menu")
			
			if Creator.Data["Controls_"+str(ControllerInput)]["Use_Middle_Mouse_Rotate"]:
				Current_Input["Keyboard_Mouse_Rotate_Down"] = Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE)
			else:
				Current_Input["Keyboard_Mouse_Rotate_Down"] = Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT)
			
			#Shoulders
			Current_Input["Shoulder_Button_Input_Just_Pressed_Left"] = Input.is_action_just_pressed("Keyboard_Shoulder_Button_Left")
			Current_Input["Shoulder_Button_Input_Just_Pressed_Right"] = Input.is_action_just_pressed("Keyboard_Shoulder_Button_Right")
			Current_Input["Shoulder_Button_Input_Just_Released_Left"] = Input.is_action_just_released("Keyboard_Shoulder_Button_Left")
			Current_Input["Shoulder_Button_Input_Just_Released_Right"] = Input.is_action_just_released("Keyboard_Shoulder_Button_Right")
			Current_Input["Shoulder_Button_Input_Pressed_Left"] = Input.is_action_pressed("Keyboard_Shoulder_Button_Left")
			Current_Input["Shoulder_Button_Input_Pressed_Right"] = Input.is_action_pressed("Keyboard_Shoulder_Button_Right")
			
			#Triggers
			Current_Input["Trigger_Input_Left"] = Input.get_action_raw_strength("Keyboard_Trigger_Left")
			Current_Input["Trigger_Input_Right"] = Input.get_action_raw_strength("Keyboard_Trigger_Right")
	#print(Current_Input["Controller_Type"])
			oldmouse_pos = get_viewport().get_mouse_position()

func reset_keyboard_images() -> void:
	var Current_Input = Core.Globals.Data["Controls_"+str(ControllerInput)]["Input_Translations"]
	for i in Current_Input:
		var newImage = "res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Controller_Buttons/Keyboard_Keys/"+str(int(Current_Input[i]))+".png"
		ControllerInputImages["Keyboard"][Keyboard_Translation[i]] = newImage

func reparse_controller_context(text:String) -> String:
	var newtext = text
	
	##Adaptive First Pass // {VarName} -> {InputName}
	for i in Core.Globals.Data["Controls_"+str(ControllerInput)]["Input_Overrides"]:
		newtext = newtext.replace(i,Core.Globals.Data["Controls_"+str(ControllerInput)]["Input_Overrides"][i][int(Current_Input["Mode"] == "Controller")])
	
	##Apply New Images // {InputName} -> res://image.png
	for i in ControllerInputImages[Current_Input["Controller_Type"]]:
		newtext = newtext.replace(i,ControllerInputImages[Current_Input["Controller_Type"]][i])
	#print(newtext)
	return newtext

func vibrate_controller(weak:float,strong:float,length:float) -> void:
	if Current_Input["Mode"] == "Controller":
		Input.start_joy_vibration(ControllerInput,weak,strong,length)

func find_controller_input(VarText:String) -> Dictionary:
	var VarInput = []
	
	var Data_Point = Core.Globals.Data["Controls_"+str(ControllerInput)]["Input_Overrides"][VarText][int(Current_Input["Mode"] == "Controller")]
	
	if  Data_Point != ["",""]:
		VarInput = Data_Point
	else:
		VarInput = InputOverride_Defaults[VarText][int(Current_Input["Mode"] == "Controller")]
	
	var InputType = VarInput[0]
	var InputKey = VarInput[1]
	
	match InputType:
		"Button","DPad":
			return {
				"Just_Pressed":Current_Input[InputType+"_Input_Just_Pressed_"+InputKey],
				"Just_Released":Current_Input[InputType+"_Input_Just_Released_"+InputKey],
				"Is_Pressed":Current_Input[InputType+"_Input_Pressed_"+InputKey]
			}
		"Trigger":
			return {
				"Strength":Current_Input[InputType+"_Input_"+InputKey]
			}
		"Joy":
			return {
				"Vector":Current_Input[InputType+"_"+InputKey+"_Input"]
			}
	return {}
