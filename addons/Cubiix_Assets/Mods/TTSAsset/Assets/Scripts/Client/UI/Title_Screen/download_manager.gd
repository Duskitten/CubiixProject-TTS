extends Control
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
var loadscene = ResourceLoader.load("res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Objects/Client/UI/Update_Transition_Scene.tscn","",ResourceLoader.CACHE_MODE_REPLACE).instantiate()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HTTPRequest.download_file = OS.get_executable_path().get_base_dir() + "/update.zip"

func trigger_update() -> void:
	$HTTPRequest.request(Core.Globals.Data["API_URL"]+"/game/versionDownload2",PackedStringArray(["versionID:"+Core.Globals.NewGameVersion,"OS:"+(OS.get_name().to_lower())]))

func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	$VBoxContainer/TextureRect/VBoxContainer/Loader.hide()
	$VBoxContainer/TextureRect/VBoxContainer/Confirm.show()
	$VBoxContainer/TextureRect/VBoxContainer/Text.text = "Restart?"

func _on_confirm_pressed() -> void:
	var reader = ZIPReader.new()
	reader.open(OS.get_executable_path().get_base_dir() + "/update.zip")
	var root_dir = DirAccess.open(OS.get_executable_path().get_base_dir())
	var files = reader.get_files()
	for file_path in files:
		if file_path.ends_with("/"):
			root_dir.make_dir_recursive(file_path)
			continue
		root_dir.make_dir_recursive(root_dir.get_current_dir().path_join(file_path).get_base_dir())
		var file = FileAccess.open(root_dir.get_current_dir().path_join(file_path), FileAccess.WRITE)
		var buffer = reader.read_file(file_path)
		file.store_buffer(buffer)
	
	match OS.get_name().to_lower():
		"windows":
			OS.create_process(OS.get_executable_path().get_base_dir()+"/update/updater.bat",[])
		"linux":
			OS.create_process(OS.get_executable_path().get_base_dir()+"/update/updater.sh",[])
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	await get_tree().process_frame
	get_tree().quit()
