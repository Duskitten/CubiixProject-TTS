extends Node
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

var GameVersion = "V_B.01.10"
var NewGameVersion = ""

signal Setting_Changed
signal Update_Triggered
signal Controller_Changed

var LocalUser = {
	"URL":"",
	"UserSecretCode":"",
	"Username":"",
}

var save_template = {
	"LastChar_Save":"",
	"Controls":{
		"Invert_Controls":false,
		"Input_Overrides":{
		}
	},
	"Theme":{
		"Top":"b705a9",
		"Bottom":"ffc479"
	},
	"Audio":{
		"Master":0,
		"Music":0,
		"SFX":0,
		"Notification":0,
		"Ping":0
	},
	"Visuals":{
		"Shadow_Depth":0,
		"Anti-Aliasing":0,
		"Bloom":false,
		"FOV":75
	},
	"SavedServers":[["127.0.0.1","5599"]],
	"API_URL":"https://api.cubiixproject.xyz",
	"Auth_URL":"https://cubiixproject.xyz"
}

var server_template = {
	"Port":5599,
	"MaxPlayers":40,
	"RoomMaxSize":10,
	"ServerName":"TestServer",
	"ServerColor":"#fff500",
	"API_URL":"https://api.cubiixproject.xyz",
	"Auth_URL":"https://cubiixproject.xyz",
	"Moderators":[],
	"Admins":[],
	"Owners":[],
	"BannedUserIDs":[],
	"MutedUserIDs":[],
	}

var Data:Dictionary = {}

var KillThreads:bool = false
var UI_Hovered:Array = []
var All_UI:Array = []
var Sorted_UI:Node = null
var DisablePlayerInput:bool = false
var Physics_Time:float

var Current_Input = {
	"Mode":"Keyboard",
	"Controller_Type":"Keyboard",
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
	"Shoulder_Input_Pressed":{
		"Left":false,
		"Right":false},
	"Shoulder_Input_Just_Pressed":{
		"Left":false,
		"Right":false},
	"Shoulder_Input_Just_Released":{
		"Left":false,
		"Right":false},
	"Trigger_Input":[0,0], ## Unsure What will use for
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

func _input(event: InputEvent) -> void:
	controller_manager(event)

func _physics_process(delta: float) -> void:
	print(Current_Input["Mode"]) 
	Physics_Time += delta

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if OS.has_feature("client"):
		var Json = JSON.new()
		var IsFile = FileAccess.file_exists(OS.get_user_data_dir()+"/client.json")
		if !IsFile:
			var NewFile = FileAccess.open(OS.get_user_data_dir()+"/client.json",FileAccess.WRITE)
			NewFile.store_string(JSON.stringify(save_template,"\t"))
			NewFile.close()

		var JsonFile = FileAccess.get_file_as_string(OS.get_user_data_dir()+"/client.json")
		Json.parse(JsonFile)
		Data = Json.data
		
		data_failsafe_check(save_template)
		###For continuity/Updating purposes
		#print(Data)
		_setup_audio(Data["Audio"])
		

	if OS.has_feature("server"):
		var Json = JSON.new()
		#print(OS.get_executable_path().get_base_dir()+"/server.json")
		var IsFile = FileAccess.file_exists(OS.get_user_data_dir()+"/server.json")
		if !IsFile:
			var NewFile = FileAccess.open(OS.get_user_data_dir()+"/server.json",FileAccess.WRITE)
			NewFile.store_string(JSON.stringify(server_template,"\t"))
			NewFile.close()

		var JsonFile = FileAccess.get_file_as_string(OS.get_user_data_dir()+"/server.json")
		Json.parse(JsonFile)
		Data = Json.data
		
		data_failsafe_check(server_template)
		#print(Data)

func data_failsafe_check(pathobj):
	for i in pathobj:
		if !Data.has(i):
			Data[i] = pathobj[i]
		else:
			if pathobj[i] is Dictionary:
				for x in pathobj[i]:
					if !Data[i].has(x):
						Data[i][x] = pathobj[i][x]

func _setup_audio(data:Dictionary) -> void:
	for i in data.keys():
		if AudioServer.get_bus_index(i) != -1:
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index(i),data[i])

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		Kill()
		

func Kill():
	KillThreads = true
	Core.AssetData.thread_force_post()
	if OS.has_feature("client"):
		#Core.Persistant_Core
		var NewFile = FileAccess.open(OS.get_user_data_dir()+"/client.json",FileAccess.WRITE)
		NewFile.store_string(JSON.stringify(Data,"\t"))
		NewFile.close()
	if OS.has_feature("server"):
		var NewFile = FileAccess.open(OS.get_user_data_dir()+"/server.json",FileAccess.WRITE)
		NewFile.store_string(JSON.stringify(Data,"\t"))
		NewFile.close()
	
func sort_ui() -> Node:
	var targeted_ui = null
	if UI_Hovered.size() > 1:
		for x in UI_Hovered:
			for y in UI_Hovered:
				if y != x:
					if y.get_index() > x.get_index():
						targeted_ui = y
						break
	else:
		targeted_ui = UI_Hovered[0]
		targeted_ui.get_parent().move_child(targeted_ui,targeted_ui.get_parent().get_child_count()-1)
	
	return targeted_ui


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
			Current_Input["DPad_Input"] = Vector2(Input.get_action_raw_strength("Controller_1_Button_Left")-Input.get_action_raw_strength("Controller_1_Button_Right"),Input.get_action_raw_strength("Controller_1_Button_Up")-Input.get_action_raw_strength("Controller_1_Button_Down"))
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
			Current_Input["Joy_1_Input"] = Input.get_vector("Controller_1_Joy_1_Left","Controller_1_Joy_1_Right","Controller_1_Joy_1_Up","Controller_1_Joy_1_Down")
			Current_Input["Joy_2_Input"] = Input.get_vector("Controller_1_Joy_2_Left","Controller_1_Joy_2_Right","Controller_1_Joy_2_Up","Controller_1_Joy_2_Down")
			#Menu Button
			Current_Input["Menu_Button_Pressed"] = Input.is_action_pressed("Controller_1_Menu")
			Current_Input["Menu_Button_Just_Pressed"] = Input.is_action_just_pressed("Controller_1_Menu")
			Current_Input["Menu_Button_Just_Released"] = Input.is_action_just_released("Controller_1_Menu")
		"Keyboard":
			Current_Input["DPad_Input"] = Vector2(Input.get_action_raw_strength("Keyboard_DPad_Left")-Input.get_action_raw_strength("Keyboard_DPad_Right"),Input.get_action_raw_strength("Keyboard_DPad_Up")-Input.get_action_raw_strength("Keyboard_DPad_Down"))
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
			Current_Input["Button_Input_Just_Pressed"]["Down"] = Input.is_action_just_pressed("Keyboard_Mouse_L")
			Current_Input["Button_Input_Just_Pressed"]["Left"] = Input.is_action_just_pressed("Keyboard_Mouse_R")
			Current_Input["Button_Input_Just_Pressed"]["Right"] = Input.is_action_just_pressed("Keyboard_Button_Down")
			Current_Input["Button_Input_Just_Released"]["Up"] = Input.is_action_just_released("Keyboard_Button_Up")
			Current_Input["Button_Input_Just_Released"]["Down"] = Input.is_action_just_released("Keyboard_Mouse_L")
			Current_Input["Button_Input_Just_Released"]["Left"] = Input.is_action_just_released("Keyboard_Mouse_R")
			Current_Input["Button_Input_Just_Released"]["Right"] = Input.is_action_just_released("Keyboard_Button_Down")
			Current_Input["Button_Input_Pressed"]["Up"] = Input.is_action_pressed("Keyboard_Button_Up")
			Current_Input["Button_Input_Pressed"]["Down"] = Input.is_action_pressed("Keyboard_Mouse_L")
			Current_Input["Button_Input_Pressed"]["Left"] = Input.is_action_pressed("Keyboard_Mouse_R")
			Current_Input["Button_Input_Pressed"]["Right"] = Input.is_action_pressed("Keyboard_Button_Down")
			#Joy Input
			Current_Input["Joy_1_Input"] = Input.get_vector("Keyboard_DPad_Left","Keyboard_DPad_Right","Keyboard_DPad_Up","Keyboard_DPad_Down")
			Current_Input["Joy_2_Input"] = get_viewport().get_mouse_position()-oldmouse_pos
			#Menu Button
			Current_Input["Menu_Button_Pressed"] = Input.is_action_pressed("Keyboard_Menu")
			Current_Input["Menu_Button_Just_Pressed"] = Input.is_action_just_pressed("Keyboard_Menu")
			Current_Input["Menu_Button_Just_Released"] = Input.is_action_just_released("Keyboard_Menu")
	#print(Current_Input["Controller_Type"])
			oldmouse_pos = get_viewport().get_mouse_position()

func reparse_controller_context(text:String) -> String:
	var newtext = text
	
	if Current_Input["Controller_Type"] != "Keyboard":
		for i in ControllerInputImages[Current_Input["Controller_Type"]]:
			print(i)
			newtext = newtext.replace(i,ControllerInputImages[Current_Input["Controller_Type"]][i])
	print(newtext)
	return newtext

func vibrate_controller(controllerid:int,weak:float,strong:float,length:float) -> void:
	if Current_Input["Mode"] == "Controller":
		Input.start_joy_vibration(controllerid,weak,strong,length)
