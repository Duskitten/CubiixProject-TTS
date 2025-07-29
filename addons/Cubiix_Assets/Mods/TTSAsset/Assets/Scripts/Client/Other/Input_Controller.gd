extends Node
class_name InputController

@export var ControllerInput := 0


var Current_Input = {
	"Mode":"Keyboard",
	"Controller_Type":"Keyboard",
	"Keyboard_Mouse_Rotate_Down":false,
	"DPad_Input":Vector2.ZERO,  ## Try to restrict to menu stuff
	"DPad_Input_Pressed":{
		"Up":false,
		"Down":false,
		"Left":false,
		"Right":false},
	"DPad_Input_Just_Pressed":{
		"Up":false,
		"Down":false,
		"Left":false,
		"Right":false},
	"DPad_Input_Just_Released":{
		"Up":false,
		"Down":false,
		"Left":false,
		"Right":false},
	"Joy_1_Input":Vector2.ZERO, ## Try to restrict to movement stuff
	"Joy_2_Input":Vector2.ZERO, ## Try to restrict to camera stuff
	"Button_Input_Pressed":{
		"Up":false,
		"Down":false,
		"Left":false,
		"Right":false},
	"Button_Input_Just_Pressed":{
		"Up":false,
		"Down":false,
		"Left":false,
		"Right":false},
	"Button_Input_Just_Released":{
		"Up":false,
		"Down":false,
		"Left":false,
		"Right":false},
	"Shoulder_Button_Input_Pressed":{
		"Left":false,
		"Right":false},
	"Shoulder_Button_Input_Just_Pressed":{
		"Left":false,
		"Right":false},
	"Shoulder_Button_Input_Just_Released":{
		"Left":false,
		"Right":false},
	"Trigger_Input":{
		"Left":0,
		"Right":0
	}, ## Unsure What will use for
	"Menu_Button_Pressed":false,
	"Menu_Button_Just_Pressed":false,
	"Menu_Button_Just_Released":false,
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
		"{ControllerInputUJ1}":"",
		"{ControllerInputDJ1}":"",
		"{ControllerInputLJ1}":"",
		"{ControllerInputRJ1}":"",
		"{ControllerInputPJ1}":"",
		#Joy2
		"{ControllerInputUJ2}":"",
		"{ControllerInputDJ2}":"",
		"{ControllerInputLJ2}":"",
		"{ControllerInputRJ2}":"",
		"{ControllerInputPJ2}":"",
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
		"{ControllerInputUJ1}":"",
		"{ControllerInputDJ1}":"",
		"{ControllerInputLJ1}":"",
		"{ControllerInputRJ1}":"",
		"{ControllerInputPJ1}":"",
		#Joy2
		"{ControllerInputUJ2}":"",
		"{ControllerInputDJ2}":"",
		"{ControllerInputLJ2}":"",
		"{ControllerInputRJ2}":"",
		"{ControllerInputPJ2}":"",
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
		"{ControllerInputUJ1}":"",
		"{ControllerInputDJ1}":"",
		"{ControllerInputLJ1}":"",
		"{ControllerInputRJ1}":"",
		"{ControllerInputPJ1}":"",
		#Joy2
		"{ControllerInputUJ2}":"",
		"{ControllerInputDJ2}":"",
		"{ControllerInputLJ2}":"",
		"{ControllerInputRJ2}":"",
		"{ControllerInputPJ2}":"",
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
		
	}
	
	
	
}
var oldmouse_pos:Vector2
var Creator

func _init(creator,who) -> void:
	Creator = creator
	ControllerInput = who
	
func _input(event: InputEvent) -> void:
	controller_manager(event)

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
		elif Input.get_joy_name(0).to_lower().contains("switch") || Input.get_joy_name(0).to_lower().contains("nintendo"):
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
			Current_Input["DPad_Input"] = Input.get_vector("Controller_1_DPad_Left","Controller_1_DPad_Right","Controller_1_DPad_Up","Controller_1_DPad_Down")
			Current_Input["DPad_Input_Just_Pressed"]["Up"] = Input.is_action_just_pressed("Controller_1_DPad_Up")
			Current_Input["DPad_Input_Just_Pressed"]["Down"] = Input.is_action_just_pressed("Controller_1_DPad_Down")
			Current_Input["DPad_Input_Just_Pressed"]["Left"] = Input.is_action_just_pressed("Controller_1_DPad_Left")
			Current_Input["DPad_Input_Just_Pressed"]["Right"] = Input.is_action_just_pressed("Controller_1_DPad_Right")
			Current_Input["DPad_Input_Just_Released"]["Up"] = Input.is_action_just_released("Controller_1_DPad_Up")
			Current_Input["DPad_Input_Just_Released"]["Down"] = Input.is_action_just_released("Controller_1_DPad_Down")
			Current_Input["DPad_Input_Just_Released"]["Left"] = Input.is_action_just_released("Controller_1_DPad_Left")
			Current_Input["DPad_Input_Just_Released"]["Right"] = Input.is_action_just_released("Controller_1_DPad_Right")
			Current_Input["DPad_Input_Pressed"]["Up"] = Input.is_action_pressed("Controller_1_DPad_Up")
			Current_Input["DPad_Input_Pressed"]["Down"] = Input.is_action_pressed("Controller_1_DPad_Down")
			Current_Input["DPad_Input_Pressed"]["Left"] = Input.is_action_pressed("Controller_1_DPad_Left")
			Current_Input["DPad_Input_Pressed"]["Right"] = Input.is_action_pressed("Controller_1_DPad_Right")
			##Button Inputs X, Tri, etc
			Current_Input["Button_Input_Just_Pressed"]["Up"] = Input.is_action_just_pressed("Controller_1_Button_Up")
			Current_Input["Button_Input_Just_Pressed"]["Down"] = Input.is_action_just_pressed("Controller_1_Button_Down")
			Current_Input["Button_Input_Just_Pressed"]["Left"] = Input.is_action_just_pressed("Controller_1_Button_Left")
			Current_Input["Button_Input_Just_Pressed"]["Right"] = Input.is_action_just_pressed("Controller_1_Button_Right")
			Current_Input["Button_Input_Just_Released"]["Up"] = Input.is_action_just_released("Controller_1_Button_Up")
			Current_Input["Button_Input_Just_Released"]["Down"] = Input.is_action_just_released("Controller_1_Button_Down")
			Current_Input["Button_Input_Just_Released"]["Left"] = Input.is_action_just_released("Controller_1_Button_Left")
			Current_Input["Button_Input_Just_Released"]["Right"] = Input.is_action_just_released("Controller_1_Button_Right")
			Current_Input["Button_Input_Pressed"]["Up"] = Input.is_action_pressed("Controller_1_Button_Up")
			Current_Input["Button_Input_Pressed"]["Down"] = Input.is_action_pressed("Controller_1_Button_Down")
			Current_Input["Button_Input_Pressed"]["Left"] = Input.is_action_pressed("Controller_1_Button_Left")
			Current_Input["Button_Input_Pressed"]["Right"] = Input.is_action_pressed("Controller_1_Button_Right")
			#Joy Input
			
			if !Creator.Data["Controls_"+str(ControllerInput)]["Flip_Controller_Joysticks"]:
				Current_Input["Joy_1_Input"] = Input.get_vector("Controller_1_Joy_1_Left","Controller_1_Joy_1_Right","Controller_1_Joy_1_Up","Controller_1_Joy_1_Down")
				Current_Input["Joy_2_Input"] = Input.get_vector("Controller_1_Joy_2_Left","Controller_1_Joy_2_Right","Controller_1_Joy_2_Up","Controller_1_Joy_2_Down")
			else:
				Current_Input["Joy_1_Input"] = Input.get_vector("Controller_1_Joy_2_Left","Controller_1_Joy_2_Right","Controller_1_Joy_2_Up","Controller_1_Joy_2_Down")
				Current_Input["Joy_2_Input"] = Input.get_vector("Controller_1_Joy_1_Left","Controller_1_Joy_1_Right","Controller_1_Joy_1_Up","Controller_1_Joy_1_Down")
			
			#Menu Button
			Current_Input["Menu_Button_Pressed"] = Input.is_action_pressed("Controller_1_Menu")
			Current_Input["Menu_Button_Just_Pressed"] = Input.is_action_just_pressed("Controller_1_Menu")
			Current_Input["Menu_Button_Just_Released"] = Input.is_action_just_released("Controller_1_Menu")
	
			#Shoulders
			Current_Input["Shoulder_Button_Input_Just_Pressed"]["Left"] = Input.is_action_just_pressed("Controller_1_Shoulder_Button_Left")
			Current_Input["Shoulder_Button_Input_Just_Pressed"]["Right"] = Input.is_action_just_pressed("Controller_1_Shoulder_Button_Right")
			Current_Input["Shoulder_Button_Input_Just_Released"]["Left"] = Input.is_action_just_released("Controller_1_Shoulder_Button_Left")
			Current_Input["Shoulder_Button_Input_Just_Released"]["Right"] = Input.is_action_just_released("Controller_1_Shoulder_Button_Right")
			Current_Input["Shoulder_Button_Input_Pressed"]["Left"] = Input.is_action_pressed("Controller_1_Shoulder_Button_Left")
			Current_Input["Shoulder_Button_Input_Pressed"]["Right"] = Input.is_action_pressed("Controller_1_Shoulder_Button_Right")
		
			#Triggers
			Current_Input["Trigger_Input"]["Left"] = Input.get_action_raw_strength("Controller_1_Trigger_Left")
			Current_Input["Trigger_Input"]["Right"] = Input.get_action_raw_strength("Controller_1_Trigger_Right")
		"Keyboard":
			Current_Input["DPad_Input"] = Input.get_vector("Keyboard_DPad_Left","Keyboard_DPad_Right","Keyboard_DPad_Up","Keyboard_DPad_Down")
			Current_Input["DPad_Input_Just_Pressed"]["Up"] = Input.is_action_just_pressed("Keyboard_DPad_Up")
			Current_Input["DPad_Input_Just_Pressed"]["Down"] = Input.is_action_just_pressed("Keyboard_DPad_Down")
			Current_Input["DPad_Input_Just_Pressed"]["Left"] = Input.is_action_just_pressed("Keyboard_DPad_Left")
			Current_Input["DPad_Input_Just_Pressed"]["Right"] = Input.is_action_just_pressed("Keyboard_DPad_Right")
			Current_Input["DPad_Input_Just_Released"]["Up"] = Input.is_action_just_released("Keyboard_DPad_Up")
			Current_Input["DPad_Input_Just_Released"]["Down"] = Input.is_action_just_released("Keyboard_DPad_Down")
			Current_Input["DPad_Input_Just_Released"]["Left"] = Input.is_action_just_released("Keyboard_DPad_Left")
			Current_Input["DPad_Input_Just_Released"]["Right"] = Input.is_action_just_released("Keyboard_DPad_Right")
			##Button Inputs X, Tri, etc
			Current_Input["Button_Input_Just_Pressed"]["Up"] = Input.is_action_just_pressed("Keyboard_Button_Up")
			Current_Input["Button_Input_Just_Pressed"]["Down"] = Input.is_action_just_pressed("Keyboard_Button_Down")
			Current_Input["Button_Input_Just_Pressed"]["Left"] = Input.is_action_just_pressed("Keyboard_Button_Left")
			Current_Input["Button_Input_Just_Pressed"]["Right"] = Input.is_action_just_pressed("Keyboard_Button_Right")
			Current_Input["Button_Input_Just_Released"]["Up"] = Input.is_action_just_released("Keyboard_Button_Up")
			Current_Input["Button_Input_Just_Released"]["Down"] = Input.is_action_just_released("Keyboard_Button_Down")
			Current_Input["Button_Input_Just_Released"]["Left"] = Input.is_action_just_released("Keyboard_Button_Left")
			Current_Input["Button_Input_Just_Released"]["Right"] = Input.is_action_just_released("Keyboard_Button_Right")
			Current_Input["Button_Input_Pressed"]["Up"] = Input.is_action_pressed("Keyboard_Button_Up")
			Current_Input["Button_Input_Pressed"]["Down"] = Input.is_action_pressed("Keyboard_Button_Down")
			Current_Input["Button_Input_Pressed"]["Left"] = Input.is_action_pressed("Keyboard_Button_Left")
			Current_Input["Button_Input_Pressed"]["Right"] = Input.is_action_pressed("Keyboard_Button_Right")
			#Joy Input
			Current_Input["Joy_1_Input"] = Input.get_vector("Keyboard_Joy_Left","Keyboard_Joy_Right","Keyboard_Joy_Up","Keyboard_Joy_Down")
			Current_Input["Joy_2_Input"] = get_viewport().get_mouse_position()-oldmouse_pos
			
			#Menu Button
			Current_Input["Menu_Button_Pressed"] = Input.is_action_pressed("Keyboard_Menu")
			Current_Input["Menu_Button_Just_Pressed"] = Input.is_action_just_pressed("Keyboard_Menu")
			Current_Input["Menu_Button_Just_Released"] = Input.is_action_just_released("Keyboard_Menu")
			
			
			if Creator.Data["Controls"]["Use_Middle_Mouse_Rotate"]:
				Current_Input["Keyboard_Mouse_Rotate_Down"] = Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE)
			else:
				Current_Input["Keyboard_Mouse_Rotate_Down"] = Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT)
			
			#Shoulders
			Current_Input["Shoulder_Button_Input_Just_Pressed"]["Left"] = Input.is_action_just_pressed("Keyboard_Shoulder_Button_Left")
			Current_Input["Shoulder_Button_Input_Just_Pressed"]["Right"] = Input.is_action_just_pressed("Keyboard_Shoulder_Button_Right")
			Current_Input["Shoulder_Button_Input_Just_Released"]["Left"] = Input.is_action_just_released("Keyboard_Shoulder_Button_Left")
			Current_Input["Shoulder_Button_Input_Just_Released"]["Right"] = Input.is_action_just_released("Keyboard_Shoulder_Button_Right")
			Current_Input["Shoulder_Button_Input_Pressed"]["Left"] = Input.is_action_pressed("Keyboard_Shoulder_Button_Left")
			Current_Input["Shoulder_Button_Input_Pressed"]["Right"] = Input.is_action_pressed("Keyboard_Shoulder_Button_Right")
			
			#Triggers
			Current_Input["Trigger_Input"]["Left"] = Input.get_action_raw_strength("Keyboard_Trigger_Left")
			Current_Input["Trigger_Input"]["Right"] = Input.get_action_raw_strength("Keyboard_Trigger_Right")
	#print(Current_Input["Controller_Type"])
			oldmouse_pos = get_viewport().get_mouse_position()

func reparse_controller_context(text:String) -> String:
	var newtext = text
	
	if Current_Input["Controller_Type"] != "Keyboard":
		for i in ControllerInputImages[Current_Input["Controller_Type"]]:
			print(i)
			newtext = newtext.replace(i,ControllerInputImages[Current_Input["Controller_Type"]][i])
	#print(newtext)
	return newtext

func vibrate_controller(weak:float,strong:float,length:float) -> void:
	if Current_Input["Mode"] == "Controller":
		Input.start_joy_vibration(ControllerInput,weak,strong,length)
