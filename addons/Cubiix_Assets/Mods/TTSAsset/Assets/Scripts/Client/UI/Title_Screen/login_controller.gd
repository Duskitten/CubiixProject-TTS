extends Control
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
@onready var UsernameBox = $Login/VBoxContainer/TextureRect/VBoxContainer/Username
@onready var PasswordBox = $Login/VBoxContainer/TextureRect/VBoxContainer/Password
@onready var RegisterButton = $Login/VBoxContainer/TextureRect/VBoxContainer/HBoxContainer/Register
@onready var LoginButton = $Login/VBoxContainer/TextureRect/VBoxContainer/HBoxContainer/Login

@onready var Loader = $Login/VBoxContainer/TextureRect/Loader

@onready var Login_Request = $Login_Request
@onready var Register_Request = $Register_Request
@onready var API_Validate = $API_Validate

var ApiCalls = {
	"getUser":"/user/getUser", #Input:userID Header #Get
	"setUser":"/user/setUser", #Input:userID Header, userSecretCode Header #Post
	"validateToken":"/user/validateToken", #Input:userToken Header #Post
	"graphQl":"/graphql", #Input:Authorization Header
	"registerUser":"/user/registerUser" #Input:Username, Password
}

var URL:String
var API_URL:String
var login_URL:String
var jwt
var tryreset:bool

func _ready() -> void:
	Core.LoginData = self
	Login_Request.request_completed.connect(self.login_request_completed)
	API_Validate.request_completed.connect(self.api_validate_completed)
	Register_Request.request_completed.connect(self.register_request_completed)


func _on_login_pressed():
	disable_all()
	var login_Query = {}
	URL = Core.Globals.Data["Auth_URL"]
	API_URL = Core.Globals.Data["API_URL"]
	if Core.Globals.Data["Auth_URL"] == "https://cubiixproject.xyz":
		var AUTH = ""
		
		login_Query = {
		"query" : "mutation ($username:String!, $password:String!, $strategy:String!) {authentication {login (username : $username, password : $password, strategy : $strategy){responseResult{errorCode, message}, jwt}}}",
		"variables" : {"username":UsernameBox.text,"password":PasswordBox.text,"strategy":"local"}
		}
		login_URL = Core.Globals.Data["Auth_URL"] + ApiCalls["graphQl"]
		AUTH = "Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGkiOjUsImdycCI6NSwiaWF0IjoxNzMxODkyNzcwLCJleHAiOjE4MjY1NjU1NzAsImF1ZCI6InVybjpjdWJpaXhwcm9qZWN0Lnh5eiIsImlzcyI6InVybjp3aWtpLmpzIn0.AFfcQb0LMugPAcU_Gpg-vmv3O3b-Q3cAVtQRwka06Y53lzDMZCDmg7TzN1fsdI_vjbnZ2lAPKLoYB0gkYKRUpncJS9wOzZNgLrZ0Ho3Riu5K8AaUg1pHFvufGG0pjM7YHL92Cw8005dB55OrYMw67u-9ErqR68Q5qQSo3-DSwob_goTCJJ4c2kiPnomh8kE9nMV0e-_PofSoLzVfLx3fRdYoi8LUTgpdISpKmGMEO1E4nu2lL1Jk1E7JyzY5-VYfeyBsVBoUKiDAkECCfA9_3yqGW3DwuGVh2oL9-SqebuougopbeWuPOyw5cQ9c97OU3bAe01QS_CEh4eVFV3L8QQ"
		var json = JSON.new()
		Login_Request.request(login_URL,
			[AUTH,"Content-Type: application/json"]
			,HTTPClient.METHOD_POST,
			json.stringify(login_Query))

	else:
		login_URL = API_URL + ApiCalls["validateToken"]
		API_Validate.request(login_URL,["userName:"+UsernameBox.text,"userPassword:"+PasswordBox.text,
			"Content-Type: application/json"]
			,HTTPClient.METHOD_POST,"")

func login_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	print(response)
	var login_URL = ""
	if response != null:
		if response.has("data"):
			if response["data"]["authentication"]["login"]["responseResult"]["errorCode"] != 0:
				print("Error: User Login Error.")
				enable_all()
			else:
				login_URL = API_URL+ ApiCalls["validateToken"]
				print(login_URL)
				jwt = response["data"]["authentication"]["login"]["jwt"]
				
				API_Validate.request(login_URL,["userToken: "+jwt,
				"Content-Type: application/json"]
				,HTTPClient.METHOD_POST,"")
				tryreset = true
		elif response.has("status"):
			if response["status"] == 0:
				enable_all()
			else:
				enable_all()
				print("Error: User Login Error.")
		else:
			enable_all()
			print("Error: No Server Response.")
	else:
		enable_all()
		print("Error: Check SSL Cert.")

func api_validate_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	print(response)
	print("api Completed!")
	if response != null:
		if response["status"] == 0:
			Core.Globals.LocalUser["Username"] = str(response["userID"]).to_lower()
			Core.Globals.LocalUser["UserSecretCode"] = response["userSecretCode"]
			Core.Globals.LocalUser["URL"] = URL.to_lower()
			$ServerList.show()
			Core.ServerList_Updater.updatevalues()
			$Login.hide()
		elif response["status"] == 2 && tryreset:
			await get_tree().create_timer(1).timeout
			tryreset = false
			var login_URL = API_URL+ ApiCalls["validateToken"]
			API_Validate.request(login_URL,["userToken: "+jwt,
			"Content-Type: application/json"]
			,HTTPClient.METHOD_POST,"")
		else:
			enable_all()
			print("Error: User Failed To Validate.")

func _on_register_pressed() -> void:
	disable_all()
	var login_Query = {}
	var AUTH = ""
	URL = Core.Globals.Data["Auth_URL"]
	API_URL = Core.Globals.Data["API_URL"]
	if Core.Globals.Data["Auth_URL"] == "https://cubiixproject.xyz":
		login_URL = URL + ApiCalls["graphQl"]
		AUTH = "Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGkiOjUsImdycCI6NSwiaWF0IjoxNzMxODkyNzcwLCJleHAiOjE4MjY1NjU1NzAsImF1ZCI6InVybjpjdWJpaXhwcm9qZWN0Lnh5eiIsImlzcyI6InVybjp3aWtpLmpzIn0.AFfcQb0LMugPAcU_Gpg-vmv3O3b-Q3cAVtQRwka06Y53lzDMZCDmg7TzN1fsdI_vjbnZ2lAPKLoYB0gkYKRUpncJS9wOzZNgLrZ0Ho3Riu5K8AaUg1pHFvufGG0pjM7YHL92Cw8005dB55OrYMw67u-9ErqR68Q5qQSo3-DSwob_goTCJJ4c2kiPnomh8kE9nMV0e-_PofSoLzVfLx3fRdYoi8LUTgpdISpKmGMEO1E4nu2lL1Jk1E7JyzY5-VYfeyBsVBoUKiDAkECCfA9_3yqGW3DwuGVh2oL9-SqebuougopbeWuPOyw5cQ9c97OU3bAe01QS_CEh4eVFV3L8QQ"
		login_Query = {
			"query" : "mutation ($email:String!, $name:String!,$passwordRaw:String!, $providerKey:String!, $groups:[Int]!, $sendWelcomeEmail:Boolean!){ users{ create(email: $email, name:$name, passwordRaw: $passwordRaw ,providerKey:$providerKey, groups:$groups, sendWelcomeEmail: $sendWelcomeEmail){ responseResult{succeeded slug message} user{id}}}}",
			"variables": {"email": UsernameBox.text, "name": UsernameBox.text,"passwordRaw":PasswordBox.text ,"providerKey": "local" ,  "groups": [3] ,"sendWelcomeEmail":false}
		}
		var json = JSON.new()
		await get_tree().create_timer(1).timeout
		Register_Request.request(login_URL,[AUTH,
		"Content-Type: application/json"]
		,HTTPClient.METHOD_POST,
		json.stringify(login_Query))
	else:
		login_URL = URL+ApiCalls["registerUser"]
		Register_Request.request(login_URL,["userName:"+UsernameBox.text,"userPassword:"+PasswordBox.text,
			"Content-Type: application/json"]
			,HTTPClient.METHOD_POST,"")

func register_request_completed(result, response_code, headers, body):
	#print(result)
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	print(response)
	if response.has("data"):
		if response["data"]["users"]["create"].has("responseResult"):
			if response["data"]["users"]["create"]["responseResult"]["succeeded"] != true:
				print("Error: Failed To Register User.")
				enable_all()
			else:
				_on_login_pressed()
	elif response.has("status"):
		if response["status"] == 0:
			_on_login_pressed()
		else:
			enable_all()
			print("Error: Failed To Register User.")

func disable_all():
	Loader.show()
	RegisterButton.disabled = true
	LoginButton.disabled = true
	UsernameBox.editable = false
	PasswordBox.editable = false

func enable_all():
	Loader.hide()
	RegisterButton.disabled = false
	LoginButton.disabled = false
	UsernameBox.editable = true
	PasswordBox.editable = true
