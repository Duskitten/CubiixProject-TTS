extends Node


func compile_mesh(meshfrom:ArrayMesh, mergeto:ArrayMesh) -> Dictionary:
	var replacementmesh = ArrayMesh.new()
	var replacementskin = Skin.new()
	
	var replacementmeshcommit = [PackedVector3Array(),PackedVector3Array(),PackedFloat32Array(),null,PackedVector2Array(),null,null,null,null,null,PackedInt32Array(),PackedFloat32Array(),PackedInt32Array()]
	var Blendshapes = []
	
	var meshfromdata = SurfaceTool.new()
	meshfromdata.create_from_surface(meshfrom, 0)
	
	var meshtodata = SurfaceTool.new()
	meshtodata.create_from_surface(meshfrom, 0)
	
	
	replacementmesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES,replacementmeshcommit,Blendshapes)
	
	var returndict = {
		"mesh":replacementmesh,
		"skin":replacementskin
	}
	
	return  returndict
