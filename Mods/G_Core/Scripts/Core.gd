extends Node

var gassetmanager = preload("res://Mods/G_AssetManager/Scripts/AssetManager.gd").new()
var gmodloader = preload("res://Mods/G_Modloader/Scripts/Modloader.gd").new()
var gmeshcompiler = preload("res://Mods/G_MeshCompiler/Scripts/MeshCompiler.gd").new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gassetmanager.setup(self)
	gmodloader.setup(self)
	var earmesh = load("res://Mods/G_CubiixCore/Meshes/Cubiix_Base_MK4_Ears_1.gltf").instantiate()
	var newmeshdict:Dictionary = gmeshcompiler.compile_mesh($Node3D/Cubiix_Base_MK4_Core/Armature/Skeleton3D/Body.mesh,earmesh.get_node("Armature/Skeleton3D/Ears_1").mesh)
	var oldmat = $Node3D/Cubiix_Base_MK4_Core/Armature/Skeleton3D/Body.mesh.surface_get_material(0)
	newmeshdict["mesh"].surface_set_material(0,load("res://Mods/G_CubiixCore/Meshes/new_standard_material_3d.tres"))
	RenderingServer.mesh_set_custom_aabb(newmeshdict["mesh"].get_rid(), newmeshdict["aabb"])
	$Node3D/Cubiix_Base_MK4_Core/Armature/Skeleton3D/Body.mesh = newmeshdict["mesh"]
	
	

func reload_mods_and_assets():
	gassetmanager.reset_asset_table()
	gmodloader.reset_current_modlist()
	gmodloader.run_parser()
