extends Node3D

var sploosh:StandardMaterial3D = ResourceLoader.load("res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Materials/Effects/sploosh.tres","",ResourceLoader.CACHE_MODE_REPLACE).duplicate(true)
@export var Alpha = 1.0
func _ready() -> void:
	$Water_Sploosh2/Sphere.material_override = sploosh
	$Water_Sploosh/Sphere.material_override = sploosh

func _process(delta: float) -> void:
	sploosh.albedo_color.a = Alpha
