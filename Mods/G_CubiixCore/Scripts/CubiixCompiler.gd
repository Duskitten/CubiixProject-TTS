extends Node

var coreobj = null

var cubiixrenderorder = {
	"Ears":[1,0,1],
	"Extra":[2,0,1],
	"Wings":[3,0,1],
	"Eyes_Open":[0,1,1],
	"Eyes_Closed":[1,1,1],
	"Tail":[2,1,2],
	"Eyes_Squint":[0,2,1],
	"Eyes_Confused":[1,2,1],
	"Hat":[3,2,1],
	"Back":[4,2,1],
	"Hip_R":[0,3,1],
	"Hip_L":[1,3,1],
	"Hand_R":[2,3,1],
	"Hand_L":[3,3,1]
}

func setup(core:Node):
	coreobj = core

func compile_cubiix(cubiixdata:Dictionary) -> Dictionary:
	var newcubiixdata = {
		"cubiixmesh":null,
		"cubiixtexture":null
	}
	
	##First we want to setup our mesh to be compiled based on the data.
	var core = load("res://Mods/G_CubiixCore/Meshes/Cubiix_Base_MK4_Core.gltf").instantiate()
	
	var newmeshdict:Dictionary = {
		"mesh":core.get_node("Armature/Skeleton3D/Body").mesh,
		"aabb":null
	}
	for i in cubiixrenderorder:
		##Put the new mesh here
		var newmesh = load(cubiixdata[i]["meshurl"]).instantiate().get_node(cubiixdata[i]["meshobj"])
		newmeshdict = coreobj.gmeshcompiler.compile_mesh(newmeshdict["mesh"],newmesh, newmeshdict["mesh"] != null )
		##Merge the texture onto the spritesheet
	
	return newcubiixdata
	
