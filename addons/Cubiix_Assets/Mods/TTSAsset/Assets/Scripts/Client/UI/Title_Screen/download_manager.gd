extends Control
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
var loadscene = ResourceLoader.load("res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Objects/Client/UI/Update_Transition_Scene.tscn","",ResourceLoader.CACHE_MODE_REPLACE).instantiate()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HTTPRequest.download_file = OS.get_executable_path().get_base_dir() + "/Cubiix_Project.pck"

func trigger_update() -> void:
	$HTTPRequest.request(Core.Globals.Data["UpdateServer_URL"]+"/game/versionDownload",PackedStringArray(["versionID:"+Core.Globals.NewGameVersion]))

func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	$VBoxContainer/TextureRect/VBoxContainer/Loader.hide()
	$VBoxContainer/TextureRect/VBoxContainer/Confirm.show()
	$VBoxContainer/TextureRect/VBoxContainer/Text.text = "Restart?"

func finished_download() -> void:
	get_node("/root/").add_child(loadscene)

func _on_confirm_pressed() -> void:
	finished_download()
