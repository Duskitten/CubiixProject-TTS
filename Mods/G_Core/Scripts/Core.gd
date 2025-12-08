extends Node

var G_AssetManager = preload("res://Mods/G_AssetManager/Scripts/AssetManager.gd").new()
var G_Modloader = preload("res://Mods/G_Modloader/Scripts/Modloader.gd").new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	G_AssetManager.setup(self)
	G_Modloader.setup(self)

func reload_mods_and_assets():
	G_AssetManager.reset_asset_table()
	G_Modloader.reset_current_modlist()
	G_Modloader.run_parser()
