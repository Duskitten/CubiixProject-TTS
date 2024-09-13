extends Node

@onready var Dialogue = $CanvasLayer/Dialogue
@onready var Transitioner = $CanvasLayer/Transitioner
@onready var Transitioner_AnimationPlayer = Transitioner.get_node("AnimationPlayer")


func _ready() -> void:
###### Signal Connections ######
	#TitleScreen
	Hexii_Ui_QuitButton.pressed.connect(QuitButton_Pressed.bind())
	Hexii_Ui_PlayButton.pressed.connect(Hexii_UI_Transition.bind("Enter","Hexii_Ui_LoginScreen_Anim","Exit","Hexii_Ui_TitleScreen_Anim"))
	Hexii_Ui_DevlogButton.pressed.connect(Hexii_UI_Transition.bind("Enter","Hexii_Ui_DevlogScreen_Anim","Exit","Hexii_Ui_TitleScreen_Anim"))
	Hexii_Ui_SettingsButton.pressed.connect(Hexii_UI_Transition.bind("Enter","Hexii_Ui_SettingsScreen_Anim","Exit","Hexii_Ui_TitleScreen_Anim"))
	Hexii_Ui_CommunityButton.pressed.connect(CommunityButton_Pressed.bind())
	#Chat
	Hexii_Ui_Chat_TextInput.text_submitted.connect(send_text.bind())

#############################
###### Hexii UI System ######
#############################
@onready var Hexii_Ui = $CanvasLayer/Hexii_UI
@onready var Hexii_Ui_Anim = Hexii_Ui.get_node("Overlay/AnimationPlayer")
@onready var Hexii_Ui_SettingsScreen_Anim = Hexii_Ui.get_node("Overlay/Screens/Settings_Screen/AnimationPlayer")
@onready var Hexii_Ui_DevlogScreen_Anim = Hexii_Ui.get_node("Overlay/Screens/Devlog_Screen/AnimationPlayer")

func Hexii_UI_Transition(anim_1,  componentName, anim_2, component2Name)-> void:
	if anim_1 == "Back":
		Hexii_Ui_Anim.play("Tilt_L")
	elif anim_1 == "Enter":
		Hexii_Ui_Anim.play("Tilt_R")

	if componentName in self && component2Name in self:
		get(componentName).play(anim_1)
		get(component2Name).play(anim_2)

#################################
###### Title Screen System ######
#################################
@onready var Hexii_Ui_TitleScreen = Hexii_Ui.get_node("Overlay/Screens/Title_Screen")
@onready var Hexii_Ui_TitleScreen_Anim = Hexii_Ui.get_node("Overlay/Screens/Title_Screen/AnimationPlayer")
@onready var Hexii_Ui_UpdateButton = Hexii_Ui.get_node("Overlay/Screens/Title_Screen/Panel/VBoxContainer2/ScrollContainer/VBoxContainer/UpdateButton")
@onready var Hexii_Ui_PlayButton = Hexii_Ui.get_node("Overlay/Screens/Title_Screen/Panel/VBoxContainer2/ScrollContainer/VBoxContainer/PlayButton")
@onready var Hexii_Ui_DevlogButton =  Hexii_Ui.get_node("Overlay/Screens/Title_Screen/Panel/VBoxContainer2/ScrollContainer/VBoxContainer/DevlogButton")
@onready var Hexii_Ui_CommunityButton =  Hexii_Ui.get_node("Overlay/Screens/Title_Screen/Panel/VBoxContainer2/ScrollContainer/VBoxContainer/CommunityButton")
@onready var Hexii_Ui_SettingsButton =  Hexii_Ui.get_node("Overlay/Screens/Title_Screen/Panel/VBoxContainer2/ScrollContainer/VBoxContainer/SettingsButton")
@onready var Hexii_Ui_QuitButton =  Hexii_Ui.get_node("Overlay/Screens/Title_Screen/Panel/VBoxContainer2/ScrollContainer/VBoxContainer/QuitButton")

func QuitButton_Pressed():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
	
func CommunityButton_Pressed():
	OS.shell_open("https://cubiixproject.xyz/") 
	
###################################
###### Update Checker System ######
###################################

#################################
###### Login Screen System ######
#################################
@onready var Hexii_Ui_LoginScreen_Anim = Hexii_Ui.get_node("Overlay/Screens/Login_Screen/AnimationPlayer")



################################
###### Server List System ######
################################
@onready var Hexii_Ui_ServerListScreen_Anim = Hexii_Ui.get_node("Overlay/Screens/ServerList_Screen/AnimationPlayer")
@onready var Hexii_Ui_ServerSelectScreen_Anim = Hexii_Ui.get_node("Overlay/Screens/ServerSelect_Screen/AnimationPlayer")

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
