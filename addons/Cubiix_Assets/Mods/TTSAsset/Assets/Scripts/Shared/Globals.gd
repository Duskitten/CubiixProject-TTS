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
	"Controls_0":{
		"Flip_Controller_Joysticks":false,
		"Controller_Sensitivity_Joy_1":0.1,
		"Controller_Sensitivity_Joy_2":0.1,
		"Use_Middle_Mouse_Rotate":false,
		"Mouse_Sensitivity":0.1,
		"Input_Translations":{
			"Keyboard_Button_Up":KEY_1,
			"Keyboard_Button_Down":KEY_3,
			"Keyboard_Button_Left":KEY_2,
			"Keyboard_Button_Right":KEY_4,
			
			"Keyboard_DPad_Up":KEY_W,
			"Keyboard_DPad_Down":KEY_S,
			"Keyboard_DPad_Left":KEY_A,
			"Keyboard_DPad_Right":KEY_D,
			
			"Keyboard_Shoulder_Button_Right": KEY_Q,
			"Keyboard_Shoulder_Button_Left": KEY_E,
			
			"Keyboard_Trigger_Right": KEY_Z,
			"Keyboard_Trigger_Left": KEY_X,
			
			"Keyboard_Joy_Up":KEY_W,
			"Keyboard_Joy_Down":KEY_S,
			"Keyboard_Joy_Left":KEY_A,
			"Keyboard_Joy_Right":KEY_D,
		},
		"Input_Overrides":{
			"{ColorInput_A}":["",""],
			"{ColorInput_B}":["",""],
			"{ColorInput_C}":["",""],
			"{ColorInput_D}":["",""],
			"{Interact_Key}":["",""],
			"{UI_Up}":["",""],
			"{UI_Down}":["",""],
			"{UI_Left}":["",""],
			"{UI_Right}":["",""],
			"{Walk_Forwards}":["",""],
			"{Walk_Backwards}":["",""],
			"{Walk_Left}":["",""],
			"{Walk_Right}":["",""],
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

var local_inputs = []

func _physics_process(delta: float) -> void:
	#print(Current_Input["Mode"]) 
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
		
		for i in Data["Controls"]["Input_Translations"]:
			var event = InputEventKey.new()
			event.keycode = Data["Controls"]["Input_Translations"][i]
			InputMap.action_add_event(i,event)
			
		print(InputMap.action_get_events("Keyboard_Button_Down"))
		var newcontroller = InputController.new(self,0)
		add_child(newcontroller)
		local_inputs.append(newcontroller)

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
