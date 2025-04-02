class_name DatabaseManager
extends Node

@onready var Database : SQLite = SQLite.new()

func _ready() -> void:
	Database.path=OS.get_executable_path().get_base_dir()+"/PlayerDB.db"
	Database.open_db()
	
	var table = {
		"phoneid":{"data_type":"text", "not_null":true}, 
		"userid" : {"data_type":"text", "not_null":true}, ## This will be user_id@website.end
		"character" : {"data_type":"text", "not_null":true}, ## This will be a simple merging of the user's Character Dict + Accessory Dict
		"last_interaction" : {"data_type":"text", "not_null":true},
		"mailbox" : {"data_type":"text", "not_null":true},
		"extradata":  {"data_type":"text", "not_null":true}
		}
	
	Database.create_table("PlayerInfo",table)

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
