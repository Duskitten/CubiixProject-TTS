extends Node

var coreobj = null
var cubiixobj = null

var charactertexture = Image.create_empty(128,128,false, Image.FORMAT_RGBA8)
var charactermaterial = load("res://Mods/G_CubiixCore/Meshes/CubiixMat.tres").duplicate(true)

var cubiixrenderorder = {
	"Palette":[Vector2i(0,0),true],
	"Ears":[Vector2i(1,0),true],
	"Extra":[Vector2i(2,0),true],
	"Wings":[Vector2i(3,0),true],
	"Eyes":[Vector2i(0,1),true],
	"Tail":[Vector2i(2,1),true],
	"Hat":[Vector2i(3,2),false],
	"Back":[Vector2i(4,2),false],
	"Hip_R":[Vector2i(1,3),false],
	"Hip_L":[Vector2i(0,3),false],
	"Hand_R":[Vector2i(3,3),false],
	"Hand_L":[Vector2i(2,3),false]
}
var colormaps = [
	Color("31a2f2"),
	Color("005784"),
	Color("a3ce27"),
	Color("44891a")
]
const texturesize = 128
var masks:PackedByteArray

func setup(core:Node, cbxobj:Node3D):
	coreobj = core
	cubiixobj = cbxobj
	masks.resize(texturesize*texturesize)
	compile_cubiix()
	
func set_mask_bit(position:Vector2, value:int):
	masks[(position.y * texturesize) + position.x] = value

func compile_cubiix():
	var compileddict = []
	var blacklist = []
	##This is the first pass, this will compile the whole sheet
	##Then we'll record the pixels needed to change colors
	var core = load("res://Mods/G_CubiixCore/Meshes/Cubiix_Base_MK4_Core.gltf").instantiate()
	
	var newmeshdict:Dictionary = {
		"mesh":core.get_node("Armature/Skeleton3D/Body").mesh,
		"aabb":null
	}
	var cnt = 0
	for value in cubiixobj.cubiixcharacter.keys():
		if  cubiixobj.cubiixcharacter[value] != "":
			var data = coreobj.gassetmanager.get_value(cubiixobj.cubiixcharacter[value])
			var imagetex :CompressedTexture2D = load(data["modpath"] + data["data"]["texturepath"])
			var image:Image = imagetex.get_image()
			charactertexture.blit_rect(image,Rect2i(0,0,image.get_width(),image.get_height()),cubiixrenderorder[value][0] * (texturesize/4))
			var offset = cubiixrenderorder[value][0] * (texturesize/4)
			if cubiixrenderorder[value][1]:
				for y in image.get_height():
					for x in image.get_width():
						if colormaps.has(image.get_pixel(x,y)):
							set_mask_bit(Vector2(x+offset.x, y+offset.y), colormaps.find(image.get_pixel(x,y))+1)
						else:
							set_mask_bit(Vector2(x+offset.x, y+offset.y), -1)
			if data["data"]["meshtype"] != "none":
				var mesh = coreobj.gassetmanager.get_value(data["data"]["meshtype"])
				var newmesh = load(mesh["modpath"]+mesh["data"]["meshpath"]).instantiate()
				var meshobj = newmesh.get_node("Armature/Skeleton3D").get_child(0).mesh
				newmeshdict = coreobj.gmeshcompiler.compile_mesh(newmeshdict["mesh"],meshobj, cnt != 0)
				RenderingServer.mesh_set_custom_aabb(newmeshdict["mesh"].get_rid(), newmeshdict["aabb"])
				cnt += 1
	for x in texturesize:
		for y in texturesize:
			match masks[(y * texturesize) + x]:
				1:
					charactertexture.set_pixel(x,y,cubiixobj.cubiixcolors["EyeA"])
				2:
					charactertexture.set_pixel(x,y,cubiixobj.cubiixcolors["EyeB"])
				3:
					charactertexture.set_pixel(x,y,cubiixobj.cubiixcolors["Primary"])
				4:
					charactertexture.set_pixel(x,y,cubiixobj.cubiixcolors["Secondary"])

	$"../../TextureRect".texture = ImageTexture.create_from_image(charactertexture)
	charactermaterial.albedo_texture = ImageTexture.create_from_image(charactertexture)
	cubiixobj.get_node("Model/Armature/Skeleton3D/Body").mesh = newmeshdict["mesh"]
	cubiixobj.get_node("Model/Armature/Skeleton3D/Body").material_override = charactermaterial
	cubiixobj.get_node("Model/Armature/Skeleton3D/Body").set_blend_shape_value(0, 1.0)
#	
#func compile_cubiix(cubiixdata:Dictionary):
	#var newcubiixdata = {
		#"cubiixmesh":null,
		#"cubiixtexture":null
	#}
	#
	###First we want to setup our mesh to be compiled based on the data.
	#var core = load("res://Mods/G_CubiixCore/Meshes/Cubiix_Base_MK4_Core.gltf").instantiate()
	#
	#var newmeshdict:Dictionary = {
		#"mesh":core.get_node("Armature/Skeleton3D/Body").mesh,
		#"aabb":null
	#}
	#
	#for i in cubiixdata:
		###Put the new mesh here
		#var newmesh = load(cubiixdata[i]["meshurl"]).instantiate().get_node(cubiixdata[i]["meshobj"])
		#newmeshdict = coreobj.gmeshcompiler.compile_mesh(newmeshdict["mesh"],newmesh, newmeshdict["mesh"] != null )
		###Merge the texture onto the spritesheet
	#
	#return newcubiixdata
	#
