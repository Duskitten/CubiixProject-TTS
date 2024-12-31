extends Node3D

## These are the shader values that will be used for loading a character.
## The Pattern for them is as follows:
## A - C
## B - D

##Or in the case of an Array 
## 0 - 2
## 1 - 3
## and so on.

## For each 2X2 is a new "Material" representing a part on the overall mesh
## in order it will go:
	## Character
	## Head Object
	## Face Object
	## Chest Object
	## Back Object
	## Left Hand Object
	## Right Hand Object
	## Left Hip Object
	## Right Hip Object

## This pattern should hopefully not be too dissimilar to the current one, and allow for all assets to share 1 material.
## Which will hopefully drop drawcalls even lower.
@export var Shader_Color : PackedColorArray
@export var Shader_Emission : PackedColorArray
@export_range(0,1) var Shader_Metallic : PackedFloat32Array
@export_range(0,1) var Shader_Roughness : PackedFloat32Array
@export_range(0,1) var Shader_Emission_Strength : PackedFloat32Array
@export_range(0,1) var Shader_Alpha : PackedFloat32Array

## Just a nice little key so I dont have to memorize stuff
var Keylist = {
	"Body":{"Body1":0,"Body2":2,"Eye1":1,"Eye2":3},
	"Head":[4,6,5,7],
	"Face":[8,10,9,11],
	"Chest":[12,14,13,15],
	"Back":[16,18,17,19],
	"L_Hand":[20,22,21,23],
	"R_Hand":[24,26,25,27],
	"L_Hip":[28,30,29,31],
	"R_Hip":[32,34,33,35],
}

var New_Shader:Material = load("res://addons/Cubiix_Assets/Materials/Cubiix_Material.tres").duplicate(true)

##For Asset ID Purposes of what asset to use.
var Base_Eyes:String  = ""
var Base_Ears:String  = ""
var Base_Extras:String  = ""
var Base_Tails:String  = ""
var Base_Wings:String  = ""

var Acc_Head:String  = ""
var Acc_Face:String  = ""
var Acc_Chest:String  = ""
var Acc_Back:String  = ""
var Acc_L_Hand:String  = ""
var Acc_R_Hand:String  = ""
var Acc_L_Hip:String  = ""
var Acc_R_Hip:String  = ""

var Name:String  = ""
var Pronouns_A:String  = ""
var Pronouns_B:String  = ""
var Pronouns_C:String = ""
var Faction:int = 1

var Scale:float = 1

var DynBones_Register = {}
signal Mesh_Finished
var DynBones : DynBone

var Animator:AnimationPlayer
var Animator_Tree:AnimationTree
var old_animation:Array = ["Idle", 0.0]

func _ready() -> void:
	pass
	#await get_parent().Loaded
	#generate_character()
func adjust_scale() -> void:
	self.scale = Vector3(Scale,Scale,Scale)

func generate_colors() -> void:
	New_Shader.set_shader_parameter("Body_Color", Shader_Color)
	New_Shader.set_shader_parameter("Body_Emission", Shader_Emission)
	New_Shader.set_shader_parameter("Body_Metallic", Shader_Metallic)
	New_Shader.set_shader_parameter("Body_Roughness", Shader_Roughness)
	New_Shader.set_shader_parameter("Body_Emission_Str", Shader_Emission_Strength)
	New_Shader.set_shader_parameter("Body_Alpha", Shader_Alpha)

func generate_character() -> void:
	generate_colors()
	adjust_scale()
	var Skeleton = Skeleton3D.new()
	Skeleton.name = "Skeleton3D"
	var MeshInstance = MeshInstance3D.new()
	MeshInstance.name = "MeshInstance3D"
	Skeleton.add_child(MeshInstance)
	get_parent().Assets.generate_character_mesh([
		"CoreAssets/Base_Model",
		Base_Eyes,
		Base_Ears,
		Base_Extras, 
		Base_Tails,
		Base_Wings,
		Acc_Head,
		Acc_Face,
		Acc_Chest,
		Acc_Back,
		Acc_L_Hand,
		Acc_R_Hand,
		Acc_L_Hip,
		Acc_R_Hip,],
		MeshInstance,
		Skeleton,
		self)
	await Mesh_Finished
	if get_node_or_null("Animations") != null:
		Animator = get_node_or_null("Animations/AnimationPlayer")
		if Animator != null:
			Animator.active = false
	if get_node_or_null("Cubiix_Model/Armature/Skeleton3D") != null:
		$Cubiix_Model/Armature/Skeleton3D.free()
	$Cubiix_Model/Armature.add_child(Skeleton)
	DynBones = DynBone.new()
	Skeleton.add_child(DynBones)
	#add_child(load("res://addons/Cubiix_Assets/Animations/TTS_Animations.tscn").instantiate())
	
	DynBones.DynBones_Register = DynBones_Register.duplicate(true)
	DynBones.first_run()
	if Animator != null:
		Animator.active = true
		update_animation_bypass(old_animation)
	await get_tree().create_timer(0.2).timeout
	
	DynBones.call_deferred("emit_signal","RePositioned")

## This is where we update our animations
func update_animation(animation:Array) -> void:
	if animation != old_animation:
		old_animation = animation
		if Animator != null:
			Animator.play(animation[0], animation[1])

## This is where we update our animations on regen
func update_animation_bypass(animation:Array) -> void:
	if Animator != null:
		Animator.play(animation[0], animation[1])
