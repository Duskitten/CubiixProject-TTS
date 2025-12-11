extends Node


func compile_mesh(meshfrom:ArrayMesh, meshto:ArrayMesh) -> Dictionary:
	##All of our replacement variables
	var replacementmesh = ArrayMesh.new()
	var replacementaabb = AABB()
	var replacementsurfacetool = SurfaceTool.new()
	var replacementmeshcommit = [PackedVector3Array(),PackedVector3Array(),PackedFloat32Array(),null,PackedVector2Array(),null,null,null,null,null,PackedInt32Array(),PackedFloat32Array(),PackedInt32Array()]
	
	replacementsurfacetool.append_from(meshfrom,0,Transform3D())
	replacementsurfacetool.append_from(meshto,0,Transform3D())
	
	var mesha = SurfaceTool.new()
	mesha.create_from(meshfrom,0)
	var meshaarray = mesha.commit_to_arrays()
	var meshb = SurfaceTool.new()
	meshb.create_from(meshto,0)
	var meshbarray = meshb.commit_to_arrays()
	var blendshapes: Array[Array] = []
	var blendshapenamed = {}
	
	for i in meshfrom.get_blend_shape_count():
		blendshapenamed[meshfrom.get_blend_shape_name(i)] = {}
		blendshapenamed[meshfrom.get_blend_shape_name(i)]["a"] = i
		blendshapenamed[meshfrom.get_blend_shape_name(i)]["b"] = null
		replacementmesh.add_blend_shape(meshfrom.get_blend_shape_name(i))
		
	for i in meshto.get_blend_shape_count():
		if blendshapenamed.has(!meshto.get_blend_shape_name(i)):
			blendshapenamed[meshto.get_blend_shape_name(i)] = {}
			blendshapenamed[meshto.get_blend_shape_name(i)]["a"] = null
			blendshapenamed[meshto.get_blend_shape_name(i)]["b"] = i
			replacementmesh.add_blend_shape(meshto.get_blend_shape_name(i))
		else:
			blendshapenamed[meshto.get_blend_shape_name(i)]["b"] = i
	
	blendshapes.resize(blendshapenamed.size())
	
	for shape in blendshapenamed.keys().size():
		## Build the blendshape parser here,
		## we want it so we get the original blendshape, then parse between the two to see if they share said ID
		## Then we want to splice in the different blendshapes, we can compare with the shapenames for A, B, or Both
		## if A or B we apply base first (A + Static B) or (Static A + B)
		## if both, we apply as (A + B)
		## then we commit to blendshapes variable
		var shapenames = blendshapenamed[blendshapenamed.keys()[shape]]
		var compiledblendarray = [PackedVector3Array(),PackedVector3Array(),PackedFloat32Array()]
		if shapenames["a"] != null:
			var surfacetoola = SurfaceTool.new()
			surfacetoola.create_from_blend_shape(meshfrom,0,blendshapenamed.keys()[shape])
			var blendshapea = surfacetoola.commit_to_arrays()
			for x in blendshapea[0].size():
				blendshapea[0][x] -=   meshaarray[0][x]

			compiledblendarray[0].append_array(blendshapea[0])
			compiledblendarray[1].append_array(meshaarray[1])
			compiledblendarray[2].append_array(meshaarray[2])
		else:
			var newpackedvec3 = PackedVector3Array()
			newpackedvec3.resize(meshaarray[0].size())
			compiledblendarray[0].append_array(newpackedvec3)
			compiledblendarray[1].append_array(meshaarray[1])
			compiledblendarray[2].append_array( meshaarray[2])
			
		if shapenames["b"] != null:
			var surfacetoolb = SurfaceTool.new()
			surfacetoolb.create_from_blend_shape(meshto,0,blendshapenamed.keys()[shape])
			var blendshapeb = surfacetoolb.commit_to_arrays()
			
			for x in blendshapeb[0].size():
				blendshapeb[0][x] -=   meshbarray[0][x]
			
			compiledblendarray[0].append_array(blendshapeb[0])
			compiledblendarray[1].append_array(meshbarray[1])
			compiledblendarray[2].append_array(meshbarray[2])
		else:
			var newpackedvec3 = PackedVector3Array()
			newpackedvec3.resize(meshbarray[0].size())
			compiledblendarray[0].append_array(newpackedvec3)
			compiledblendarray[1].append_array(meshbarray[1])
			compiledblendarray[2].append_array( meshbarray[2])
		
		blendshapes[shape] = compiledblendarray
		print(compiledblendarray[0].size())
	replacementmeshcommit = replacementsurfacetool.commit_to_arrays()
	
	replacementmesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES,replacementmeshcommit,blendshapes)
	
	##Bundle everything together to send back!
	var replacementdict = {
		"mesh":replacementmesh,
		"aabb":replacementaabb
	}
	
	return  replacementdict
