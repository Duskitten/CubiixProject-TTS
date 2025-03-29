extends HTTPRequest
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.request(Core.Globals.Data["UpdateServer_URL"]+"/game/versionUrl")

func _on_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	if response.has("API"):
		Core.Globals.NewGameVersion = response["API"]
		
		if Core.Globals.GameVersion != Core.Globals.NewGameVersion:
			get_parent().show()


func _on_texture_button_pressed() -> void:
	if Core.Globals.GameVersion != Core.Globals.NewGameVersion:
		Core.Globals.emit_signal("Update_Triggered")
