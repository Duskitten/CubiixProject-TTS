extends Node3D

var sploosh:StandardMaterial3D = load("res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Materials/Effects/sploosh.tres")
@export var Alpha = 1.0
func _ready() -> void:
	$Water_Sploosh2/Sphere.material_override = sploosh
	$Water_Sploosh/Sphere.material_override = sploosh
	get_node("AnimationPlayer").animation_finished.connect(anim_finished.bind())

func _process(delta: float) -> void:
	sploosh.albedo_color.a = Alpha

func anim_finished(string:String) -> void:
	self.queue_free()
