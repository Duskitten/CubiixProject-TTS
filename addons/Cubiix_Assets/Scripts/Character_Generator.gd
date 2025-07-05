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
@export var Shader_Color : Array[Color]
@export var Shader_Emission : Array[Color]
@export_range(0,1) var Shader_Metallic : Array[float]
@export_range(0,1) var Shader_Roughness : Array[float]
@export_range(0,1) var Shader_Emission_Strength : Array[float]
@export_range(0,1) var Shader_Alpha : Array[float]

## Just a nice little key so I dont have to memorize stuff
var Keylist = {
	"Body":{"Body1":0,"Body2":2,"Eye1":1,"Eye2":3},
	#"Head":[4,6,5,7],
	#"Face":[8,10,9,11],
	#"Chest":[12,14,13,15],
	#"Back":[16,18,17,19],
	#"L_Hand":[20,22,21,23],
	#"R_Hand":[24,26,25,27],
	#"L_Hip":[28,30,29,31],
	#"R_Hip":[32,34,33,35],

}

var new_Keylist = {
	"Body":{"Body1":Vector2i(0,0),"Body2":Vector2i(0,1),"Eye1":Vector2i(1,0),"Eye2":Vector2i(1,1)},
	"Head":[Vector2i(0,2),Vector2i(0,3),Vector2i(1,2),Vector2i(1,3)],
	"Face":[Vector2i(0,4),Vector2i(0,5),Vector2i(1,4),Vector2i(1,5)],
	"Chest":[Vector2i(0,6),Vector2i(0,7),Vector2i(1,6),Vector2i(1,7)],
	"Back":[Vector2i(0,8),Vector2i(0,9),Vector2i(1,8),Vector2i(1,9)],
	"L_Hand":[Vector2i(0,10),Vector2i(0,11),Vector2i(1,10),Vector2i(1,11)],
	"R_Hand":[Vector2i(0,12),Vector2i(0,13),Vector2i(1,12),Vector2i(1,13)],
	"L_Hip":[Vector2i(0,14),Vector2i(0,15),Vector2i(1,14),Vector2i(1,15)],
	"R_Hip":[Vector2i(0,16),Vector2i(0,17),Vector2i(1,16),Vector2i(1,17)],
}

var New_Shader:StandardMaterial3D
var New_Texture:Image
var Current_Texture_Color:Image
var Current_Texture_Emission:Image
var Current_Texture_Metallic:Image

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
var Faction:int = 0

var Scale:float = 1

var DynBones_Register = {}
signal Mesh_Finished
signal Skeleton_Added
var DynBones : Cubiix_DynBone

var Animator:AnimationPlayer
var Animator_Tree:AnimationTree
var old_animation:Array = ["Idle", 0.0]
var Character_Skeleton

var node_storage = []

func _ready() -> void:
	New_Shader = load("res://addons/Cubiix_Assets/Materials/New_Cubiix_Material.tres").duplicate(true)
	New_Texture = Image.load_from_file("res://addons/Cubiix_Assets/Textures/Shader_TestStrip.png")
	Current_Texture_Color = New_Texture.duplicate(true)
	Current_Texture_Emission = New_Texture.duplicate(true)
	Current_Texture_Metallic = New_Texture.duplicate(true)
	
	Shader_Color.resize(4)
	Shader_Color.fill(Color(0,0,0,1))
	Shader_Emission.resize(4)
	Shader_Emission.fill(Color(0,0,0,1))
	Shader_Metallic.resize(4)
	Shader_Metallic.fill(0.0)
	Shader_Roughness.resize(4)
	Shader_Roughness.fill(1.0)
	Shader_Emission_Strength.resize(4)
	#await get_parent().Loaded
	#generate_character()
func adjust_scale() -> void:
	print(get_parent().name+"Aaa")
	self.scale = Vector3(Scale,Scale,Scale)

func generate_colors() -> void:
	ColorCheck_Accessory(Acc_Head)
	ColorCheck_Accessory(Acc_Face)
	ColorCheck_Accessory(Acc_Chest)
	ColorCheck_Accessory(Acc_Back)
	ColorCheck_Accessory(Acc_L_Hand)
	ColorCheck_Accessory(Acc_R_Hand)
	ColorCheck_Accessory(Acc_L_Hip)
	ColorCheck_Accessory(Acc_R_Hip)
	Current_Texture_Color.save_png("user://te3.png")
	
	for p in new_Keylist["Body"]:
		var InputLocation = new_Keylist["Body"][p] * 57
		InputLocation = Vector2i(InputLocation.y,InputLocation.x)
		var roughness_metallic_compilation = Color(Shader_Roughness[Keylist["Body"][p]],0,Shader_Metallic[Keylist["Body"][p]],1)
		Current_Texture_Color.fill_rect(Rect2i(InputLocation,Vector2i(57,57)),Shader_Color[Keylist["Body"][p]])
		Current_Texture_Emission.fill_rect(Rect2i(InputLocation,Vector2i(57,57)),Shader_Emission[Keylist["Body"][p]]*Shader_Emission_Strength[Keylist["Body"][p]])
		Current_Texture_Metallic.fill_rect(Rect2i(InputLocation,Vector2i(57,57)),roughness_metallic_compilation)
	
	
	
	New_Shader.albedo_texture = ImageTexture.create_from_image(Current_Texture_Color)
	New_Shader.roughness_texture = ImageTexture.create_from_image(Current_Texture_Metallic)
	New_Shader.metallic_texture = ImageTexture.create_from_image(Current_Texture_Metallic)
	New_Shader.emission_texture = ImageTexture.create_from_image(Current_Texture_Emission)

func generate_character() -> void:
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
	generate_colors()
	if get_node_or_null("Animations") != null:
		Animator = get_node_or_null("Animations/AnimationPlayer")
		if Animator != null:
			Animator.active = false
	if get_node_or_null("Cubiix_Model/Armature/Skeleton3D") != null:
		if DynBones != null:
			DynBones.free()
		for i in Skeleton.get_children():
			if i is Cubiix_LookAtBone:
				node_storage.append(i)
				Skeleton.remove_child(i)
		$Cubiix_Model/Armature/Skeleton3D.free()
	$Cubiix_Model/Armature.add_child(Skeleton)
	
	DynBones = Cubiix_DynBone.new()
	DynBones.DynBones_Register = DynBones_Register.duplicate()
	Skeleton.add_child(DynBones)
	#add_child(load("res://addons/Cubiix_Assets/Animations/TTS_Animations.tscn").instantiate())
	await get_tree().process_frame
	
	DynBones.first_run()
	Character_Skeleton = Skeleton
	
	for i in node_storage:
		Skeleton.add_child(i)
		if i is Cubiix_LookAtBone:
			i.setup()
		node_storage.erase(i)
	if Animator != null:
		Animator.active = true
		update_animation_bypass(old_animation)
	#$Cubiix_Model/Armature/Skeleton3D/MeshInstance3D.cast_shadow = false
	$Cubiix_Model/Armature/Skeleton3D/MeshInstance3D.visibility_range_begin = 0.4
	$Cubiix_Model/Armature/Skeleton3D/MeshInstance3D.visibility_range_end = 40
	$Cubiix_Model/Armature/Skeleton3D/MeshInstance3D.set_layer_mask_value(19,true)
	await get_tree().create_timer(0.2).timeout
	emit_signal("Skeleton_Added")
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

func ColorCheck_Accessory(ID:String):
	if ID != "":
		var data = get_parent().Assets.find_asset(ID)
		
		if data != {}:
			if data.has("Material_Overrides"):
				var colordata = data["Material_Overrides"]
				for i in colordata.keys():
					var Key = i.split("/")
					var InputLocation = new_Keylist[Key[0]][int(Key[1])]*57
					InputLocation = Vector2i(InputLocation.y,InputLocation.x)
					var roughness_metallic_compilation = Color(0,0,0,1)
					var compiled_emission = Color(0,0,0,1)
					if colordata[i].has("Color"):
						var NewColor = Color(colordata[i]["Color"])
						if colordata[i].has("Alpha"):
							NewColor.a = colordata[i]["Alpha"]
						Current_Texture_Color.fill_rect(Rect2i(InputLocation,Vector2i(57,57)),NewColor)
					
					if colordata[i].has("Roughness") && colordata[i].has("Metallic"):
						roughness_metallic_compilation.r = float(colordata[i]["Roughness"])
						roughness_metallic_compilation.b = float(colordata[i]["Metallic"])
						Current_Texture_Metallic.fill_rect(Rect2i(InputLocation,Vector2i(57,57)),roughness_metallic_compilation)
					
					if colordata[i].has("Emission") :
						var NewColor = Color(colordata[i]["Emission"])
						if colordata[i].has("Emission_Strength"):
							NewColor *= colordata[i]["Emission_Strength"]
						Current_Texture_Emission.fill_rect(Rect2i(InputLocation,Vector2i(57,57)),NewColor)
			if data.has("Texture_Overrides"):
				var texturedata = data["Texture_Overrides"]
				var startpos = new_Keylist[data["Tag"]][0]*57
				startpos = Vector2i(startpos.y, startpos.x)
				var current_rect = Rect2i(Vector2(0,0),Vector2i(114,114))
				if texturedata.has("Color_Path"):
					print(get_parent().name+"aaaaaaaaa")
					#print(texturedata["Color_Path"])
					var newimg = Image.load_from_file(texturedata["Color_Path"])
					Current_Texture_Color.blit_rect(newimg,current_rect,startpos)
				else:
					Current_Texture_Color.fill_rect(current_rect,Color("000"))
					
				if texturedata.has("Metallic_Path"):
					#print(texturedata["Color_Path"])
					var newimg = Image.load_from_file(texturedata["Metallic_Path"])
					Current_Texture_Metallic.blit_rect(newimg,current_rect,startpos)
				else:
					Current_Texture_Metallic.fill_rect(current_rect,Color("000"))
					
				if texturedata.has("Emission_Path"):
					#print(texturedata["Color_Path"])
					var newimg = Image.load_from_file(texturedata["Emission_Path"])
					Current_Texture_Emission.blit_rect(newimg,current_rect,startpos)
				else:
					Current_Texture_Emission.fill_rect(current_rect,Color("000"))
