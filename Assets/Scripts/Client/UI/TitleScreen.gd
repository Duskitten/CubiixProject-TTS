extends Control
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
##ApiCalls
@onready var Update_Check = $HTTPNodes/Update_Check
@onready var Update_Downloader = $HTTPNodes/Update_Downloader
@onready var Login_Create = $HTTPNodes/Login_Create
@onready var Login_Signin = $HTTPNodes/Login_Signin
@onready var API_Validate = $HTTPNodes/API_Validate

@onready var Main_Menu = $ScreenHolder/Main_Menu
@onready var Login_Menu = $ScreenHolder/Login_Menu
@onready var Devlog_Panel = $ScreenHolder/Main_Menu/Side_L/Devlog_Panel
@onready var Login_Text = $"ScreenHolder/Login_Menu/Side_L/GUI/Login/Login_Text"
@onready var Register_Text = $"ScreenHolder/Login_Menu/Side_L/GUI/Register/Register_Text"

@onready var Cam_Anim = $"../../Environment/Camera3D/AnimationPlayer/Cam_Anim"
@onready var Planet_Anim = $"../../Mobile_Scene/Mobile_Scene/Armature/Skeleton3D/AnimationPlayer/AnimationTree"

##Implement New Hexii UI
@onready var Hexii_UI = $Hexii_UI
@onready var Hexii_UI_Anim = $Hexii_UI/Overlay/AnimationPlayer

###TitleScreen UI
@onready var Hexii_UI_TitleScreen = $Hexii_UI/Overlay/Screens/Title_Screen
@onready var Hexii_TitleScreen_PlayButton = $Hexii_UI/Overlay/Screens/Title_Screen/Panel/VBoxContainer2/ScrollContainer/VBoxContainer/PlayButton
@onready var Hexii_TitleScreen_DevlogButton = $Hexii_UI/Overlay/Screens/Title_Screen/Panel/VBoxContainer2/ScrollContainer/VBoxContainer/DevlogButton
@onready var Hexii_TitleScreen_CommunityButton = $Hexii_UI/Overlay/Screens/Title_Screen/Panel/VBoxContainer2/ScrollContainer/VBoxContainer/CommunityButton
@onready var Hexii_TitleScreen_SettingsButton = $Hexii_UI/Overlay/Screens/Title_Screen/Panel/VBoxContainer2/ScrollContainer/VBoxContainer/SettingsButton
@onready var Hexii_TitleScreen_QuitButton = $Hexii_UI/Overlay/Screens/Title_Screen/Panel/VBoxContainer2/ScrollContainer/VBoxContainer/QuitButton

###Login Screen Stuff
@onready var Hexii_UI_LoginScreen = $Hexii_UI/Overlay/Screens/Login_Screen
@onready var Hexii_Login_LoginButton = $Hexii_UI/Overlay/Screens/Login_Screen/Panel/ScrollContainer/VBoxContainer/LoginButton
@onready var Hexii_Login_BackButton = $Hexii_UI/Overlay/Screens/Login_Screen/Panel/ScrollContainer/VBoxContainer/BackButton
@onready var Hexii_Login_RegisterButton = $Hexii_UI/Overlay/Screens/Login_Screen/Panel/ScrollContainer/VBoxContainer/RegisterButton
@onready var Hexii_Login_UsernameInput = $Hexii_UI/Overlay/Screens/Login_Screen/Panel/ScrollContainer/VBoxContainer/UsernameInput
@onready var Hexii_Login_PasswordInput = $Hexii_UI/Overlay/Screens/Login_Screen/Panel/ScrollContainer/VBoxContainer/PasswordInput
@onready var Hexii_Login_LoginText = $Hexii_UI/Overlay/Screens/Login_Screen/Panel/ScrollContainer/VBoxContainer/LoginText

###Server Management Stuff
@onready var Hexii_UI_ServerListScreen = $Hexii_UI/Overlay/Screens/ServerList_Screen
@onready var Hexii_UI_ServerSelectScreen = $Hexii_UI/Overlay/Screens/ServerSelect_Screen
@onready var Hexii_ServerSelect_BackButton = $Hexii_UI/Overlay/Screens/ServerSelect_Screen/Panel/ScrollContainer/VBoxContainer/BackButton
@onready var Hexii_ServerList_TemplateServer = $Hexii_UI/Overlay/Screens/ServerList_Screen/Panel/ScrollContainer/VBoxContainer/ScrollContainer/VBoxContainer/Server
@onready var Hexii_ServerList_ServerList = $Hexii_UI/Overlay/Screens/ServerList_Screen/Panel/ScrollContainer/VBoxContainer/ScrollContainer/VBoxContainer

##Devlog Screen Stuff
@onready var Hexii_UI_DevlogScreen = $Hexii_UI/Overlay/Screens/Devlog_Screen
@onready var Hexii_Devlog_BackButton = $Hexii_UI/Overlay/Screens/Devlog_Screen/Panel/ScrollContainer/VBoxContainer/BackButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Login_Signin.request_completed.connect(self.login_request_completed)
	#Login_Create.request_completed.connect(self.register_request_completed)
	#Update_Check.request_completed.connect(self.update_check_completed)
	API_Validate.request_completed.connect(self.api_validate_completed)
	
	#Show Our UI!
	
	##Add New Hooks
	Hexii_UI_TitleScreen.show()
	Hexii_TitleScreen_PlayButton.connect("pressed",_on_multiplayer_button_pressed)
	Hexii_TitleScreen_DevlogButton.connect("pressed",_on_devlog_button_pressed)
	Hexii_TitleScreen_CommunityButton.connect("pressed",_on_community_button_pressed)
	Hexii_TitleScreen_SettingsButton.connect("pressed",_on_settings_button_pressed)
	Hexii_TitleScreen_QuitButton.connect("pressed",_on_quit_button_pressed)
	
	Hexii_Login_LoginButton.connect("pressed",_on_login_button_pressed)
	Hexii_Login_BackButton.connect("pressed",_on_back_to_title_pressed)
	Hexii_Login_RegisterButton.connect("pressed",_on_register_button_pressed)
	
	Hexii_Devlog_BackButton.connect("pressed",_on_devlog_back_pressed)
	Hexii_ServerList_TemplateServer.get_node("LinkButton").connect("pressed",_server_list_button)
	Hexii_ServerList_TemplateServer.show()
	
	Hexii_ServerSelect_BackButton.connect("pressed",_on_server_select_back_button)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if Login_Menu.get_node("Side_L/GUI/Login/Email").has_focus() || Login_Menu.get_node("Side_L/GUI/Login/Password").has_focus()  || Login_Menu.get_node("Side_L/GUI/Register/Password").has_focus()  || Login_Menu.get_node("Side_L/GUI/Register/Username").has_focus()  || Login_Menu.get_node("Side_L/GUI/Register/Email").has_focus():
	if Input.is_key_pressed(KEY_ENTER):
		Hexii_Login_UsernameInput.release_focus()
		Hexii_Login_PasswordInput.release_focus()
		
		
		
		
			#Login_Menu.get_node("Side_L/GUI/Login/Email").release_focus()
			#Login_Menu.get_node("Side_L/GUI/Login/Password").release_focus()
			#Login_Menu.get_node("Side_L/GUI/Register/Username").release_focus()
			#Login_Menu.get_node("Side_L/GUI/Register/Password").release_focus()
			#Login_Menu.get_node("Side_L/GUI/Register/Email").release_focus()


func _on_community_button_pressed() -> void:
	OS.shell_open("https://cubiixproject.xyz/") 

func _on_settings_button_pressed() -> void:
	pass # Replace with function body.

func _on_quit_button_pressed() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()

func _on_devlog_button_pressed() -> void:
	Hexii_UI_DevlogScreen.get_node("AnimationPlayer").play("Enter")
	Hexii_UI_TitleScreen.get_node("AnimationPlayer").play("Exit")
	Hexii_UI_Anim.play("Tilt_R")
	#Devlog_Panel.visible = !Devlog_Panel.visible
	
func _on_devlog_back_pressed() -> void:
	print("Ack")
	Hexii_UI_DevlogScreen.get_node("AnimationPlayer").play("Exit_Back")
	Hexii_UI_TitleScreen.get_node("AnimationPlayer").play("Back")
	Hexii_UI_Anim.play("Tilt_L")

func _on_multiplayer_button_pressed() -> void:
	#Main_Menu.hide()
	Hexii_UI_LoginScreen.get_node("AnimationPlayer").play("Enter")
	Hexii_UI_TitleScreen.get_node("AnimationPlayer").play("Exit")
	Hexii_UI_Anim.play("Tilt_R")
	
	#Planet_Anim.set("parameters/Sand_Seek/seek_request", 0)
	#Planet_Anim.set("parameters/Sand_Blend/blend_amount", 1)
	#Planet_Anim.set("parameters/UnSand_Blend/blend_amount", 0)
	#var tween2 = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	#tween2.tween_property(Cam_Anim, "parameters/SandBlend/blend_amount", 1, 1.2)
		

func _on_update_button_pressed() -> void:
	pass # Replace with function body.

func _on_wiki_button_pressed() -> void:
	OS.shell_open("https://cubiixproject.xyz/")


func _on_back_to_title_pressed() -> void:
	#Login_Menu.hide()
	Hexii_UI_LoginScreen.get_node("AnimationPlayer").play("Exit_Back")
	Hexii_UI_TitleScreen.get_node("AnimationPlayer").play("Back")
	Hexii_UI_Anim.play("Tilt_L")
	#var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	#tween.tween_property(Cam_Anim, "parameters/SandBlend/blend_amount", 0, 1.2)
	#Planet_Anim.set("parameters/UnSand_Seek/seek_request", 0)
	#Planet_Anim.set("parameters/UnSand_Blend/blend_amount", 1)
	#Planet_Anim.set("parameters/Sand_Blend/blend_amount", 0)
	#tween.tween_callback(func():Main_Menu.show())
	

func _on_login_button_pressed() -> void:
	var login_Query = {
		"query" : "mutation ($username:String!, $password:String!, $strategy:String!) {authentication {login (username : $username, password : $password, strategy : $strategy){responseResult{errorCode, message}, jwt}}}",
		"variables" : {"username":Hexii_Login_UsernameInput.text,"password":Hexii_Login_PasswordInput.text,"strategy":"local"}
	}
	var json = JSON.new()
	Login_Signin.request(Core.Globals.ApiCalls["graphQl"],["Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGkiOjQsImdycCI6NSwiaWF0IjoxNzE3NzczNTQ0LCJleHAiOjE3NDkzMzExNDQsImF1ZCI6InVybjp3aWtpLmpzIiwiaXNzIjoidXJuOndpa2kuanMifQ.h8JSWyuzToOokv9qmr7-tn4L0VA_1lrzknDlSmqvYuU-c02MqABXc5H-xvmVrdqeFuYOt7FoSPWCI70e7JbXj8cSnFQIn_4ZMB2h5yxNZLbHXNzaPILL2UiJB0ac6yesn-G74jI3WuxHtCS6NK2wtKwisJbJAJJOvyw_Aj4wrmJFviXp9N8krjrKCwBzfr3O_3ucOVoDBuUrUwnYzUQjSb0lxqw6EQSwt-OnaAHKNssBkjm1_eO5kco8JnatVf0pJ8N7KvbiuItZ8mPWyTCU0bviVWmLpTIyQs_J5lqIHLgpO_iczBk41oQpJyBbqfLyu8OXsUCjKF0eha2Y2UXlRA",
	"Content-Type: application/json"]
	,HTTPClient.METHOD_POST,
	json.stringify(login_Query))
	

func login_request_completed(result, response_code, headers, body):
	print(result)
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	print(response)
	if response["data"]["authentication"]["login"]["responseResult"]["errorCode"] != 0:
		Hexii_Login_LoginText.text =  "[center][color=red]"  + response["data"]["authentication"]["login"]["responseResult"]["message"]
	else:
		Hexii_Login_LoginText.text =  "[center][color=green]"  + response["data"]["authentication"]["login"]["responseResult"]["message"]
		var jwt = response["data"]["authentication"]["login"]["jwt"]
		API_Validate.request(Core.Globals.ApiCalls["validateToken"],["userToken: "+jwt,
		"Content-Type: application/json"]
		,HTTPClient.METHOD_POST,"")
		Core.Globals.LocalUser["JWT"] = jwt
		
		

func _on_register_button_pressed() -> void:
	OS.shell_open("https://cubiixproject.xyz/register")
	#$ScreenHolder/Login_Menu/Side_L/GUI/Register.show()
	#$ScreenHolder/Login_Menu/Side_L/GUI/Login.hide()


#func _on_register_link_button_pressed() -> void:
	#var register_query = {
		#"query" : "mutation ($email:String!, $name:String!,$passwordRaw:String!, $providerKey:String!, $groups:[Int]!, $sendWelcomeEmail:Boolean!){ users{ create(email: $email, name:$name, passwordRaw: $passwordRaw ,providerKey:$providerKey, groups:$groups, sendWelcomeEmail: $sendWelcomeEmail){ responseResult{succeeded slug message} user{id}}}}",
		#"variables": {"email": Login_Menu.get_node("Side_L/GUI/Register/Email").text, "name": Login_Menu.get_node("Side_L/GUI/Register/Username").text ,"passwordRaw":Login_Menu.get_node("Side_L/GUI/Register/Password").text ,"providerKey": "local" ,  "groups": [3] ,"sendWelcomeEmail":false}
	#}
	#var json = JSON.new()
	#Login_Create.request("https://cubiixproject.xyz/graphql",["Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGkiOjQsImdycCI6NSwiaWF0IjoxNzE3NzczNTQ0LCJleHAiOjE3NDkzMzExNDQsImF1ZCI6InVybjp3aWtpLmpzIiwiaXNzIjoidXJuOndpa2kuanMifQ.h8JSWyuzToOokv9qmr7-tn4L0VA_1lrzknDlSmqvYuU-c02MqABXc5H-xvmVrdqeFuYOt7FoSPWCI70e7JbXj8cSnFQIn_4ZMB2h5yxNZLbHXNzaPILL2UiJB0ac6yesn-G74jI3WuxHtCS6NK2wtKwisJbJAJJOvyw_Aj4wrmJFviXp9N8krjrKCwBzfr3O_3ucOVoDBuUrUwnYzUQjSb0lxqw6EQSwt-OnaAHKNssBkjm1_eO5kco8JnatVf0pJ8N7KvbiuItZ8mPWyTCU0bviVWmLpTIyQs_J5lqIHLgpO_iczBk41oQpJyBbqfLyu8OXsUCjKF0eha2Y2UXlRA",
	#"Content-Type: application/json"]
	#,HTTPClient.METHOD_POST,
	#json.stringify(register_query))
	
#func register_request_completed(result, response_code, headers, body):
	#print(result)
	#var json = JSON.new()
	#json.parse(body.get_string_from_utf8())
	#var response = json.get_data()
	#if response["data"]["users"]["create"]["responseResult"]["succeeded"] != true:
		#Register_Text.text =  "[center][color=red]"  + response["data"]["users"]["create"]["responseResult"]["message"]
	#else:
		#Register_Text.text =  "[center][color=green]"  + response["data"]["users"]["create"]["responseResult"]["message"] +"\n Please return to login."

func api_validate_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	print(response)
	if response["status"] == 0:
		Core.Globals.LocalUser["UserID"] = response["userID"]
		Core.Globals.LocalUser["UserSecretCode"] = response["userSecretCode"]
		Core.Client.connect_to_server("localhost","5599")
		Hexii_UI_LoginScreen.get_node("AnimationPlayer").play("Exit")
		Hexii_UI_ServerListScreen.get_node("AnimationPlayer").play("Enter")
		

func _on_back_to_main_pressed() -> void:
	pass
	#$ScreenHolder/Login_Menu/Side_L/GUI/Login.show()
	#$ScreenHolder/Login_Menu/Side_L/GUI/Register.hide()
	
func _on_server_select_back_button() -> void:
	Hexii_UI_ServerListScreen.get_node("AnimationPlayer").play("Back")
	Hexii_UI_ServerSelectScreen.get_node("AnimationPlayer").play("Exit_Back")
	Hexii_UI_Anim.play("Tilt_L")
	
func _server_list_button() -> void:
	Hexii_UI_ServerListScreen.get_node("AnimationPlayer").play("Exit")
	Hexii_UI_ServerSelectScreen.get_node("AnimationPlayer").play("Enter")
	Hexii_UI_Anim.play("Tilt_R")
	
