extends Node3D
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

var charmat = load("res://Assets/Materials/Characters/Cubiix_Base_Shader_Material.tres").duplicate()
var custommat_head = load("res://Assets/Materials/Characters/Cubiix_Base_Shader_Material.tres").duplicate()
var custommat_face = load("res://Assets/Materials/Characters/Cubiix_Base_Shader_Material.tres").duplicate()
var custommat_chest = load("res://Assets/Materials/Characters/Cubiix_Base_Shader_Material.tres").duplicate()
var custommat_back = load("res://Assets/Materials/Characters/Cubiix_Base_Shader_Material.tres").duplicate()
var custommat_l_hand = load("res://Assets/Materials/Characters/Cubiix_Base_Shader_Material.tres").duplicate()
var custommat_r_hand = load("res://Assets/Materials/Characters/Cubiix_Base_Shader_Material.tres").duplicate()
var custommat_l_hip = load("res://Assets/Materials/Characters/Cubiix_Base_Shader_Material.tres").duplicate()
var custommat_r_hip = load("res://Assets/Materials/Characters/Cubiix_Base_Shader_Material.tres").duplicate()

var custom_locks = {
	"User_Custom_Head":[custommat_head,{"Body1":"","Body2":"","Body3":"","Body4":""}],
	"User_Custom_Face":[custommat_face,{"Body1":"","Body2":"","Body3":"","Body4":""}],
	"User_Custom_Chest":[custommat_chest,{"Body1":"","Body2":"","Body3":"","Body4":""}],
	"User_Custom_Back":[custommat_back,{"Body1":"","Body2":"","Body3":"","Body4":""}],
	"User_Custom_L_Hand":[custommat_l_hand,{"Body1":"","Body2":"","Body3":"","Body4":""}],
	"User_Custom_R_Hand":[custommat_r_hand,{"Body1":"","Body2":"","Body3":"","Body4":""}],
	"User_Custom_L_Hip":[custommat_l_hip,{"Body1":"","Body2":"","Body3":"","Body4":""}],
	"User_Custom_R_Hip":[custommat_r_hip,{"Body1":"","Body2":"","Body3":"","Body4":""}],
}

enum EYE_ENUM {Default,Chonk,Tri,Nat,Circle,Fox,Four,Entity,Text,Mouse}
enum EAR_ENUM {None,Cat, Fox, Wolf, Goat, Bee, Moth,Mouse,Alien,Deer, Entity, Dog, Bunny, Fluffy}
enum EXTRA_ENUM {None, Shark, Nub, Antler, Ram, Fish, Narwhal, Dragon}
enum TAIL_ENUM {None,Cat, Fox, Wolf, Bug, Bee, Moth, Dog, Mouse, Fluffy, Shark, Entity, Bunny, Deer, Dragon}
enum WING_ENUM {None, Entity, Angel, Butterfly, Wasp, Dragon}
#--
enum HEAD_ENUM {
	None,
	#Goggle_Test,
	#Orb_Test,
	DotMouse_Hat,
	Pumpkin_Head_Cute_1, 
	Devil_Head, 
	Witch_Head}
enum FACE_ENUM {None}
enum CHEST_ENUM {None,Trad_Pride_Bandanna,Trans_Pride_Bandanna}
enum BACK_ENUM {None, Trad_Pride_Cape}
enum L_HAND_ENUM {None}
enum R_HAND_ENUM {None}
enum L_HIP_ENUM {None, HipSkirt}
enum R_HIP_ENUM {None, HipSkirt}


@export var character_string : String = ""
@export var accessories_string : String = ""
var chardirty = false

@export var Randomize : bool

@export var Eyes : EYE_ENUM = EYE_ENUM.Default
@export var Ears : EAR_ENUM = EAR_ENUM.None
@export var Extra : EXTRA_ENUM = EXTRA_ENUM.None
@export var Tail : TAIL_ENUM = TAIL_ENUM.None
@export var Wings : WING_ENUM = WING_ENUM.None

@export var Head : HEAD_ENUM = HEAD_ENUM.None
@export var Face : FACE_ENUM = FACE_ENUM.None
@export var Chest : CHEST_ENUM = CHEST_ENUM.None
@export var Back : BACK_ENUM = BACK_ENUM.None
@export var L_Hand : L_HAND_ENUM = L_HAND_ENUM.None
@export var R_Hand : R_HAND_ENUM = R_HAND_ENUM.None
@export var L_Hip : L_HIP_ENUM = L_HIP_ENUM.None
@export var R_Hip: R_HIP_ENUM = R_HIP_ENUM.None


@export_color_no_alpha var Body_1 = Color(0,0,0)
@export_color_no_alpha var Body_2 = Color(0,0,0)
@export_color_no_alpha var Body_3 = Color(0,0,0)
@export_color_no_alpha var Body_4 = Color(0,0,0)

@export_color_no_alpha var Body_1_Emiss = Color(0,0,0)
@export_color_no_alpha var Body_2_Emiss = Color(0,0,0)
@export_color_no_alpha var Body_3_Emiss = Color(0,0,0)
@export_color_no_alpha var Body_4_Emiss = Color(0,0,0)

@export var Body_1_Emiss_S = 1.0
@export var Body_2_Emiss_S = 1.0
@export var Body_3_Emiss_S = 1.0
@export var Body_4_Emiss_S = 1.0

@export var Body_1_Roughness = 1.0
@export var Body_2_Roughness = 1.0
@export var Body_3_Roughness = 1.0
@export var Body_4_Roughness = 1.0

@export var Body_1_Metallic = 0.0
@export var Body_2_Metallic= 0.0
@export var Body_3_Metallic = 0.0
@export var Body_4_Metallic = 0.0

@export var Name = ""
@export var Pronouns_A = ""
@export var Pronouns_B = ""
@export var Pronouns_C = ""
@export_enum("Hexii","Nullvii","Octii","Tixii","Trii") var Faction = "Hexii"

@export var Scale = 1.0

var DynBones_Register = {}
var Skeleton_Values = {}

var CharSetup = false
@export var Is_Player = false
@export var Is_Networked = false
@export var Is_UI = false

@onready var Skeleton:Skeleton3D = $Hub/Cubiix_Model/Skeleton3D
@onready var MeshObj = $Hub/Cubiix_Model/Skeleton3D/Cube
@onready var DynBones = null
@onready var Model = $Hub/Cubiix_Model

signal MeshFinished


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_char_from_string()
	#$Hub/Cubiix_Model/AnimationTree.active = true

func set_char_from_string():
	Core.Character_Gen.set_accessory_data(accessories_string,self)
	Core.Character_Gen.generate_char_from_string(character_string,self)
	


func Regen_Color():
	charmat.set_shader_parameter("Body1",Body_1)
	charmat.set_shader_parameter("emiss_Body1",Body_1_Emiss*Body_1_Emiss_S)
	charmat.set_shader_parameter("Body1_metallic",Body_1_Metallic)
	charmat.set_shader_parameter("Body1_roughness",Body_1_Roughness)
	
	charmat.set_shader_parameter("Body2",Body_2)
	charmat.set_shader_parameter("emiss_Body2",Body_2_Emiss*Body_2_Emiss_S)
	charmat.set_shader_parameter("Body2_metallic",Body_2_Metallic)
	charmat.set_shader_parameter("Body2_roughness",Body_2_Roughness)
	
	charmat.set_shader_parameter("Body3",Body_3)
	charmat.set_shader_parameter("Body3_metallic",Body_3_Metallic)
	charmat.set_shader_parameter("emiss_Body3",Body_3_Emiss*Body_3_Emiss_S)
	charmat.set_shader_parameter("Body3_roughness",Body_3_Roughness)

	
	charmat.set_shader_parameter("Body4",Body_4)
	charmat.set_shader_parameter("emiss_Body4",Body_4_Emiss*Body_4_Emiss_S)
	charmat.set_shader_parameter("Body4_metallic",Body_4_Metallic)
	charmat.set_shader_parameter("Body4_roughness",Body_4_Roughness)
	
	for i in custom_locks.keys():
		for x in custom_locks[i][1].keys():
			if custom_locks[i][1][x] != "":
				custom_locks[i][0].set("shader_parameter/"+x, charmat.get("shader_parameter/"+custom_locks[i][1][x]))
				custom_locks[i][0].set("shader_parameter/"+"emiss_"+x, charmat.get("shader_parameter/"+"emiss_"+custom_locks[i][1][x]))
				custom_locks[i][0].set("shader_parameter/"+x+"_metallic", charmat.get("shader_parameter/"+custom_locks[i][1][x]))
				custom_locks[i][0].set("shader_parameter/"+x+"_roughness",  charmat.get("shader_parameter/"+custom_locks[i][1][x]))
						
	
	
func Adjust_Scale():
	Model.scale = Vector3(Scale,Scale,Scale)

var swapping = false

func Regen_Character():
	swapping = true
	CharSetup = false
	

	Model.name = "replaceMe"
	var base_model = Core.AssetData.Cubiix_Anim_Model.duplicate(true)
	base_model.hide()
	$Hub.add_child(base_model)
	base_model.global_position = Vector3(0,0,0)
	await get_tree().process_frame
	base_model.name = "Cubiix_Model"
	base_model.scale = Vector3(Scale,Scale,Scale)
	Skeleton = base_model.get_node("Skeleton3D")
	MeshObj = Skeleton.get_node("Cube")
	DynBones = DynBone.new()
	#for i in stored_items.keys():
		#stored_items[i]["object"].external_skeleton = Skeleton.get_path()
		#stored_items[i]["object"].bone_name = Core.AssetData.Item_Data_Assets[stored_items[i]["type"]]["target"]
		#
	await get_tree().process_frame

	var compiled = Core.AssetData.register_meshlist(
	["Body",
	Core.AssetData.Eye_Slot[Eyes],
	Core.AssetData.Ear_Slot[Ears]
	,Core.AssetData.Extra_Slot[Extra],
	Core.AssetData.Tail_Slot[Tail],
	Core.AssetData.Wing_Slot[Wings],
	
	Core.AssetData.Head_Slot[Head],
	Core.AssetData.Face_Slot[Face],
	Core.AssetData.Chest_Slot[Chest],
	Core.AssetData.Back_Slot[Back],
	Core.AssetData.L_Hand_Slot[L_Hand],
	Core.AssetData.R_Hand_Slot[R_Hand],
	Core.AssetData.L_Hip_Slot[L_Hip],
	Core.AssetData.R_Hip_Slot[R_Hip]
	],
	{
		"User":charmat,
		"User_Custom_Head":custommat_head,
		"User_Custom_Face":custommat_face,
		"User_Custom_Chest":custommat_chest,
		"User_Custom_Back":custommat_back,
		"User_Custom_L_Hand":custommat_l_hand,
		"User_Custom_R_Hand":custommat_r_hand,
		"User_Custom_L_Hip":custommat_l_hip,
		"User_Custom_R_Hip":custommat_r_hip},
	self
	)
	var parent = Skeleton.get_parent()
	
	Skeleton.get_parent().remove_child(Skeleton)
	
	Core.AssetData.add_to_mesh_queue(compiled["MeshList"],compiled["MaterialList"],MeshObj,Skeleton,self)
	
	await MeshFinished
	Model.queue_free()
	parent.add_child(Skeleton)
	Model = base_model
	
	Regen_Color()
	Skeleton.add_child(DynBones)
	DynBones.DynBones_Register = DynBones_Register.duplicate(true)
	DynBones.first_run()
	base_model.position = Vector3(0,0,0)
	base_model.show()
	CharSetup = true
	await get_tree().create_timer(0.2).timeout
	swapping = false
	DynBones.emit_signal("RePositioned")
	#if Is_Player:
		#add_new_item("Tech_Sword")
