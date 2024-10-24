extends Node

@onready var Dialogue = $CanvasLayer/Dialogue
@onready var Transitioner = $CanvasLayer/Transitioner
@onready var Transitioner_AnimationPlayer = Transitioner.get_node("AnimationPlayer")
var Mouse_In_UI = false
@onready var Player = $Node3D/Player

func _ready() -> void:
###### Signal Connections ######
	$CanvasLayer/CrossHair.position = Vector2(get_viewport().size/2) - ($CanvasLayer/CrossHair.size/2)
	#TitleScreen
	Hexii_Ui_Tablet_QuitButton.pressed.connect(QuitButton_Pressed.bind())
	Hexii_Ui_Tablet_TitleButton.pressed.connect(Hexii_UI_Transition.bind("Exit_Back","Hexii_Ui_Tablet_TitleScreen_Anim","Back","", false))
	Hexii_Ui_Tablet_PlayButton.pressed.connect(Hexii_UI_Transition.bind("Exit_Back","Hexii_Ui_Tablet_LoginScreen_Anim","Back","", false))
	Hexii_Ui_Tablet_DevlogButton.pressed.connect(Hexii_UI_Transition.bind("Exit_Back","Hexii_Ui_Tablet_DevlogScreen_Anim","Back","", false))
	Hexii_Ui_Tablet_SettingsButton.pressed.connect(Hexii_UI_Transition.bind("Exit_Back","Hexii_Ui_Tablet_SettingsScreen_Anim","Back","", false))
	Hexii_Ui_Tablet_CharacterButton.pressed.connect(Hexii_UI_Transition.bind("Exit_Back","Hexii_Ui_Tablet_CharacterScreen_Anim","Back","", false))
	Hexii_Ui_Tablet_CommunityButton.pressed.connect(CommunityButton_Pressed.bind())
	
	
	#Chat
	Hexii_Ui_Chat_TextInput.text_submitted.connect(send_text.bind())
	
	await Player.MeshFinished
	
	Hexii_Ui_Tablet_Character.Eyes = Player.Eyes
	Hexii_Ui_Tablet_Character.Ears = Player.Ears 
	Hexii_Ui_Tablet_Character.Extra = Player.Extra 
	Hexii_Ui_Tablet_Character.Tail = Player.Tail 
	Hexii_Ui_Tablet_Character.Wings = Player.Wings

	Hexii_Ui_Tablet_Character.Head = Player.Head 
	Hexii_Ui_Tablet_Character.Chest = Player.Chest 
	Hexii_Ui_Tablet_Character.Back = Player.Back

	Hexii_Ui_Tablet_Character.Body_1 = Player.Body_1 
	Hexii_Ui_Tablet_Character.Body_2 = Player.Body_2
	Hexii_Ui_Tablet_Character.Body_3 = Player.Body_3 
	Hexii_Ui_Tablet_Character.Body_4 = Player.Body_4

	Hexii_Ui_Tablet_Character.Body_Emiss_1 = Player.Body_Emiss_1 
	Hexii_Ui_Tablet_Character.Body_Emiss_2 = Player.Body_Emiss_2 
	Hexii_Ui_Tablet_Character.Body_Emiss_3 = Player.Body_Emiss_3 
	Hexii_Ui_Tablet_Character.Body_Emiss_4 = Player.Body_Emiss_4
	
	Hexii_Ui_Tablet_Character.Regen_Character()
	
func SpawnAt(Location:Vector3,Rotation:Vector3) -> void:
	$Node3D/Player.position = Location
	$Node3D/Player.CameraLength = -4.0
	$Node3D/Player/Hub.rotation = Rotation
	$Node3D/Core_Follow/Rot_Y.rotation = Rotation
	$Node3D/Core_Follow/Rot_Y/Rot_X.rotation = Vector3(deg_to_rad(15),0,0)
	
func _process(delta: float) -> void:
	if (($CanvasLayer/Hexii_Tablet_UI/Overlay.get_global_rect().grow(-32).has_point(get_viewport().get_mouse_position()) && $CanvasLayer/Hexii_Tablet_UI.visible) || ($CanvasLayer/Hexii_UI/Overlay.get_global_rect().grow(-32).has_point(get_viewport().get_mouse_position()) && $CanvasLayer/Hexii_UI.visible)):
		_on_area_2d_mouse_entered()
	elif (!$CanvasLayer/Hexii_Tablet_UI/Overlay.get_global_rect().grow(-32).has_point(get_viewport().get_mouse_position()) && !$CanvasLayer/Hexii_UI/Overlay.get_global_rect().grow(-32).has_point(get_viewport().get_mouse_position())):
		_on_area_2d_mouse_exited()
#############################
###### Hexii UI System ######
#############################
@onready var Hexii_Ui = $CanvasLayer/Hexii_UI
@onready var Hexii_Ui_Anim = Hexii_Ui.get_node("Overlay/AnimationPlayer")
@onready var Hexii_Ui_NullScreen_Anim =  Hexii_Ui.get_node("Overlay/Screens/Null_Screen/AnimationPlayer")

@onready var Hexii_Ui_Tablet = $CanvasLayer/Hexii_Tablet_UI
@onready var Hexii_Ui_Tablet_DevlogScreen_Anim = Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Panel/Devlog_Screen/AnimationPlayer")
@onready var Hexii_Ui_Tablet_SettingsScreen_Anim = Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Panel/Settings_Screen/AnimationPlayer")
@onready var Hexii_Ui_Tablet_Character = Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Panel/Character_Screen/Control/HBoxContainer/VBoxContainer/Panel/HBoxContainer/Character_Editor_Screen/Container/VBoxContainer/HBoxContainer/SubViewportContainer/SubViewport/Character_Editor/Cubiix_Base")

func _on_area_2d_mouse_entered() -> void:
	Mouse_In_UI = true

func _on_area_2d_mouse_exited() -> void:
	Mouse_In_UI = false

var IsInBounds = false
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("shiftlock"):
		$CanvasLayer/CrossHair.visible = !$CanvasLayer/CrossHair.visible

func Hexii_UI_Transition(anim_1,  componentName, anim_2, component2Name, device:bool)-> void:
	
	if device:
		if anim_1 == "Back":
			Hexii_Ui_Anim.play("Tilt_L")
		elif anim_1 == "Enter":
			Hexii_Ui_Anim.play("Tilt_R")
		if componentName in self && component2Name in self:
			get(componentName).play(anim_1)
			get(component2Name).play(anim_2)
	else:
		if componentName in self && Active_Hexii_Ui_Tablet_Screen_Anim in self && Active_Hexii_Ui_Tablet_Screen_Anim != componentName:
			get(componentName).play(anim_1)
			get(Active_Hexii_Ui_Tablet_Screen_Anim).play(anim_2)
			Active_Hexii_Ui_Tablet_Screen_Anim = componentName

#################################
###### Title Screen System ######
#################################
var Active_Hexii_Ui_Tablet_Screen_Anim = "Hexii_Ui_Tablet_NullScreen_Anim"
@onready var Hexii_Ui_Tablet_NullScreen_Anim =  Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Panel/Null_Screen/AnimationPlayer")
@onready var Hexii_Ui_Tablet_TitleButton =  Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Title_Bar/VBoxContainer/TitleButton")
@onready var Hexii_Ui_Tablet_TitleScreen_Anim =  Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Panel/Title_Screen/AnimationPlayer")
@onready var Hexii_Ui_Tablet_UpdateButton =  Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Title_Bar/VBoxContainer/UpdateButton")
@onready var Hexii_Ui_Tablet_PlayButton =  Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Title_Bar/VBoxContainer/PlayButton")
@onready var Hexii_Ui_Tablet_DevlogButton =   Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Title_Bar/VBoxContainer/DevlogButton")
@onready var Hexii_Ui_Tablet_CommunityButton =   Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Title_Bar/VBoxContainer/CommunityButton")
@onready var Hexii_Ui_Tablet_SettingsButton =   Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Title_Bar/VBoxContainer/SettingsButton")
@onready var Hexii_Ui_Tablet_QuitButton =   Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Title_Bar/VBoxContainer/QuitButton")

func QuitButton_Pressed():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
	
func CommunityButton_Pressed():
	OS.shell_open("https://cubiixproject.xyz/") 
#################################
###### In-Game Screen System ######
#################################
@onready var Hexii_Ui_Tablet_CharacterButton =  Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/In_Game_Bar/VBoxContainer2/CharacterButton")
@onready var Hexii_Ui_Tablet_CharacterScreen_Anim =  Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Panel/Character_Screen/AnimationPlayer")


###################################
###### Update Checker System ######
###################################

#################################
###### Login Screen System ######
#################################
@onready var Hexii_Ui_Tablet_LoginScreen_Anim = Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Panel/Login_Screen/AnimationPlayer")



################################
###### Server List System ######
################################
@onready var Hexii_Ui_ServerListScreen_Anim = Hexii_Ui.get_node("Overlay/Screens/ServerList_Screen/AnimationPlayer")
@onready var Hexii_Ui_ServerSelectScreen_Anim = Hexii_Ui.get_node("Overlay/Screens/ServerSelect_Screen/AnimationPlayer")

#########################
###### Character Editor System ######
#########################

#########################
###### Chat System ######
#########################
@onready var Hexii_Ui_ChatScreen_Anim = Hexii_Ui.get_node("Overlay/Screens/Chat_Screen/AnimationPlayer")
@onready var Hexii_Ui_Chat_List = Hexii_Ui.get_node("Overlay/Screens/Chat_Screen/Panel/ScrollContainer/ChatArea")
@onready var Hexii_Ui_Chat_Scroll = Hexii_Ui.get_node("Overlay/Screens/Chat_Screen/Panel/ScrollContainer")
@onready var Hexii_Ui_Chat_TextTemplate = Hexii_Ui.get_node("Overlay/Screens/Chat_Screen/Panel/Template_Text")
@onready var Hexii_Ui_Chat_TextInput = Hexii_Ui.get_node("Overlay/Screens/Chat_Screen/Panel/LineEdit")

func add_new_message(user:String, text:String) -> void:
	var template_text = "[url]>%s:[/url] %s"
	var built_message = template_text % [user, text]
	var template_object = Hexii_Ui_Chat_TextTemplate.duplicate()
	
	template_object.text = built_message
	Hexii_Ui_Chat_List.add_child(template_object)
	template_object.show()
	await get_tree().process_frame
	Hexii_Ui_Chat_Scroll.set_deferred("scroll_vertical", 99999999999999)
	

func send_text(new_text:String) -> void:
	if new_text.begins_with("/"):
		#Go To CommandParser Instead
		add_new_message("[color=red]System[/color]", "[color=red]Error Invalid Command[/color]")
		Hexii_Ui_Chat_TextInput.text = ""
		Hexii_Ui_Chat_TextInput.release_focus()
	else:
		add_new_message("Dusk", new_text)
		Hexii_Ui_Chat_TextInput.text = ""
		Hexii_Ui_Chat_TextInput.release_focus()

func parse_command(text:String) -> void:
	pass
