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

var New_Shader = load("res://addons/Cubiix_Assets/Materials/Cubiix_Material.tres").duplicate(true)

##For Asset ID Purposes of what asset to use.
var Base_Eyes = 0
var Base_Ears = 0
var Base_Extras = 0
var Base_Tails = 0
var Base_Wings = 0

var Acc_Head = ""
var Acc_Face = ""
var Acc_Chest = ""
var Acc_Back = ""
var Acc_L_Hand = ""
var Acc_R_Hand = ""
var Acc_L_Hip = ""
var Acc_R_Hip = ""

var DynBones_Register = {}

func _ready() -> void:
	generate_character()

func generate_character() -> void:
	New_Shader.set_shader_parameter("Body_Color", Shader_Color)
	New_Shader.set_shader_parameter("Body_Emission", Shader_Emission)
	New_Shader.set_shader_parameter("Body_Metallic", Shader_Metallic)
	New_Shader.set_shader_parameter("Body_Roughness", Shader_Roughness)
	New_Shader.set_shader_parameter("Body_Emission_Str", Shader_Emission_Strength)
	New_Shader.set_shader_parameter("Body_Alpha", Shader_Alpha)
	
