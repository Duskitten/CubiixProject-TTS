extends Node

var gassetmanager = null
var gmodloader = null
var gmeshcompiler = null
var gservermanager=null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if OS.has_feature("Client"):
		gassetmanager = load("res://Mods/G_AssetManager/Scripts/AssetManager.gd").new()
		gmodloader = load("res://Mods/G_Modloader/Scripts/Modloader.gd").new()
		gmeshcompiler = load("res://Mods/G_MeshCompiler/Scripts/MeshCompiler.gd").new()
		gassetmanager.setup(self)
		gmodloader.setup(self)
		
		var clientcore = load("res://Mods/G_Core/Scenes/Client_Core.tscn").instantiate()
		add_child(clientcore)
	elif OS.has_feature("Server"):
		print("Server Loading!")
		gservermanager = load("res://Mods/G_ServerManager/Scripts/ServerManager.gd").new()
		gservermanager.setup(self)

func reload_mods_and_assets():
	gassetmanager.reset_asset_table()
	gmodloader.reset_current_modlist()
	gmodloader.run_parser()
	
func _process(delta: float) -> void:
	if Input.is_joy_button_pressed(0,JOY_BUTTON_A):
		print("hi")
