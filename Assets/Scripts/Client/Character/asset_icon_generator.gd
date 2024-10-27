extends SubViewport
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

var charmat = load("res://Assets/Materials/Characters/Cubiix_Base_Shader_Material.tres").duplicate()

enum EYE_ENUM {Default,Chonk,Tri,Nat,Circle,Fox,Four,Entity,Text}
enum EAR_ENUM {None,Cat, Fox, Wolf, Goat, Bee, Moth,Mouse,Alien,Deer, Entity, Dog, Bunny, Fluffy}
enum EXTRA_ENUM {None, Shark, Nub, Antler, Ram, Fish, Narwhal, Dragon}
enum TAIL_ENUM {None,Cat, Fox, Wolf, Bug, Bee, Moth, Dog, Mouse, Fluffy, Shark, Entity, Bunny, Deer, Dragon}
enum WING_ENUM {None, Entity, Angel, Butterfly, Wasp, Dragon}
#--
enum HEAD_ENUM {None,Goggle_Test,Orb_Test,DotMouse_Hat, Pumpkin_Head_Cute_1, Devil_Head, Witch_Head}
enum CHEST_ENUM {None,Trad_Pride_Bandanna,Trans_Pride_Bandanna}
enum BACK_ENUM {None, Trad_Pride_Cape}

@export var Eyes : EYE_ENUM = EYE_ENUM.Default
@export var Ears : EAR_ENUM = EAR_ENUM.None
@export var Extra : EXTRA_ENUM = EXTRA_ENUM.None
@export var Tail : TAIL_ENUM = TAIL_ENUM.None
@export var Wings : WING_ENUM = WING_ENUM.None

@export var Head : HEAD_ENUM = HEAD_ENUM.None
@export var Chest : CHEST_ENUM = CHEST_ENUM.None
@export var Back : BACK_ENUM = BACK_ENUM.None

var DynBones_Register = {}
var Skeleton_Values = {}
func _ready() -> void:
	#for i in TAIL_ENUM.size():
	Ears = EAR_ENUM.Fluffy
	Regen_Character(Core.AssetData.Ear_Slot[EAR_ENUM.Fluffy])
		#await Screenshotted

@onready var Skeleton:Skeleton3D = $Cubiix_Base/Armature/Skeleton3D
@onready var MeshObj = $Cubiix_Base/Armature/Skeleton3D/Cube
@onready var DynBones = null
@onready var Model = $Cubiix_Base
@onready var Camera = $Camera3D

signal MeshFinished
signal Screenshotted


func Regen_Character(What:String):
	Model.name = "replaceMe"
	var base_model = Core.AssetData.Cubiix_Model.duplicate(true)
	base_model.get_node("AnimationTree").queue_free()
	base_model.hide()
	add_child(base_model)
	base_model.global_position = Vector3(0,0,0)
	await get_tree().process_frame
	base_model.name = "Cubiix_Model"

	Skeleton = base_model.get_node("Skeleton3D")
	MeshObj = Skeleton.get_node("Cube")
	await get_tree().process_frame

	var compiled = Core.AssetData.register_meshlist(
	["Body",Core.AssetData.Eye_Slot[Eyes],Core.AssetData.Ear_Slot[Ears],Core.AssetData.Extra_Slot[Extra],Core.AssetData.Tail_Slot[Tail],Core.AssetData.Wing_Slot[Wings],Core.AssetData.Head_Slot[Head],Core.AssetData.Chest_Slot[Chest],Core.AssetData.Back_Slot[Back]],
	{"User":charmat}
	)
	var parent = Skeleton.get_parent()
	
	Skeleton.get_parent().remove_child(Skeleton)
	
	Core.AssetData.add_to_mesh_queue(compiled["MeshList"],compiled["MaterialList"],MeshObj,Skeleton,self)
	
	await MeshFinished
	Model.queue_free()
	parent.add_child(Skeleton)
	Model = base_model
	
	base_model.position = Vector3(0,0,0)
	base_model.show()
	
	await get_tree().create_timer(1).timeout
	print("Screenshotting")
	get_texture().get_image().save_png("user://"+What.replace("/","_")+".png")
	emit_signal("Screenshotted")
	#if Is_Player:
		#add_new_item("Tech_Sword")
