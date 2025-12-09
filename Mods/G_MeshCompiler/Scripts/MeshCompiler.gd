extends Node


func compile_mesh(meshfrom:ArrayMesh, meshto:ArrayMesh) -> Dictionary:
	##All of our replacement variables
	var replacementmesh = ArrayMesh.new()
	var replacementaabb = AABB()
	var replacementsurfacetool = SurfaceTool.new()

	
	var replacementmeshcommit = [PackedVector3Array(),PackedVector3Array(),PackedFloat32Array(),null,PackedVector2Array(),null,null,null,null,null,PackedInt32Array(),PackedFloat32Array(),PackedInt32Array()]
	var blendshapes = []
	
	replacementsurfacetool.append_from(meshfrom,0,Transform3D())
	replacementsurfacetool.append_from(meshto,0,Transform3D())
	
	replacementmeshcommit = replacementsurfacetool.commit_to_arrays()
	
	replacementmesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES,replacementmeshcommit,blendshapes)
	
	##Bundle everything together to send back!
	var replacementdict = {
		"mesh":replacementmesh,
		"aabb":replacementaabb
	}
	
	return  replacementdict
