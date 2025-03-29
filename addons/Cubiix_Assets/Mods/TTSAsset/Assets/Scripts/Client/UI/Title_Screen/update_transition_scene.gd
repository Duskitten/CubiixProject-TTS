extends CanvasLayer
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("/root/Main_Scene/").propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	await get_tree().create_timer(1).timeout
	var scene = get_node("/root/Main_Scene")
	scene.queue_free()
	await get_tree().create_timer(3).timeout
	print("ReLoading!")
	var success = ProjectSettings.load_resource_pack(OS.get_executable_path().get_base_dir()+"/Cubiix_Project.pck",true)
	print(success)
	await get_tree().create_timer(3).timeout
	var newCore = ResourceLoader.load("res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Objects/Shared/main_scene.tscn","",ResourceLoader.CACHE_MODE_REPLACE).instantiate()
	get_node("/root").add_child(newCore)
	self.queue_free()
