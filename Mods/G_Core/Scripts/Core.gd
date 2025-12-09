extends Node

var gassetmanager = preload("res://Mods/G_AssetManager/Scripts/AssetManager.gd").new()
var gmodloader = preload("res://Mods/G_Modloader/Scripts/Modloader.gd").new()
var gmeshcompiler = preload("res://Mods/G_MeshCompiler/Scripts/MeshCompiler.gd").new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gassetmanager.setup(self)
	gmodloader.setup(self)

func reload_mods_and_assets():
	gassetmanager.reset_asset_table()
	gmodloader.reset_current_modlist()
	gmodloader.run_parser()
