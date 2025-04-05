class_name DatabaseManager
extends Node

@onready var Database : SQLite = SQLite.new()

var gamedata_versions = ["gamedata_VB_01_00"]

func _ready() -> void:
	Database.path=OS.get_executable_path().get_base_dir()+"/PlayerDB.db"
	Database.open_db()
	
	var table = {
		"phoneid":{"data_type":"text","default":"''"}, ## This will be a 10 digit number
		"userid" : {"data_type":"text","default":"''"}, ## This will be user_id@website.end
		"last_interaction" : {"data_type":"text","default":"''"},
		"mailbox" : {"data_type":"text","default":"'{}'"}, ## This will hold a dictionary of all messeges sent to user
		}
	
	Database.create_table("PlayerInfo",table)
	Database.query("pragma table_info(PlayerInfo);")
	var result = Database.query_result
	for i in gamedata_versions:
		add_new_column(i, result)


func add_new_column(version:String, result:Array[Dictionary]) -> void:
	var hasTable = false
	for i in result:
		if i["name"] == version:
			hasTable = true
			break

	if !hasTable:
		print("Adding Table!")
		Database.query("alter table PlayerInfo add column "+version+" text default '{}';")
	else:
		print("Has Table!")

func generate_new_phonenumber() -> String:
	const validints = "0123456789"
	const length = 10
	var result = ""
	for i in length:
		result += validints[randi() % validints.length()]
	var compiled_url = "select * from PlayerInfo where phoneid is '"+result+"';"
	Database.query(compiled_url)
	var DB:Array = Database.query_result
	if !DB.is_empty():
		result = generate_new_phonenumber()
	return result
	
func is_valid_phonenumber(Number:String) -> bool:
	var is_valid = false
	var validchars = 0
	for i in Number:
		if i.is_valid_int():
			validchars += 1
	
	if validchars == 10 && Number.length() == 10:
		is_valid = true
	
	return is_valid
