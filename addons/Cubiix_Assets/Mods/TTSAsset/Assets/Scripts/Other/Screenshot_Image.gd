extends SubViewport

var AssetData

func _ready() -> void:
	AssetData = load("res://addons/Cubiix_Assets/Scripts/Asset_Manager.gd").new()
	AssetData.runsetup()
	AssetData.name = "AssetData"
	await AssetData.FinishedLoad
	get_parent().add_child(AssetData)
	await get_tree().create_timer(.5).timeout
	var map = load("res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Maps/SnapshotImageMap/MapS.tscn").instantiate()
	add_child(map)
	await get_tree().create_timer(5).timeout
	get_texture().get_image().save_png("user://editor.png")
