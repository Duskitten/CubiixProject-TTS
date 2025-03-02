extends Node

## How to load:
	#AssetData = load("res://addons/Cubiix_Assets/Scripts/Asset_Manager.gd").new()
	#AssetData.runsetup()
	#AssetData.name = "AssetData"
	#await AssetData.FinishedLoad
	#add_child(AssetData)

var mod_files = []
var mods = {}
var assets = {}
var compiled_assets = {}
var assets_tagged = {}

signal FinishedLoad
signal load_finished

var InitThread:Thread
var Tools = cubiix_tool.new()

func runsetup():
	Tools.Assets = self
	InitThread = Thread.new()
	InitThread.start(Init_ThreadRun)
	
	
func Init_ThreadRun():
	scan_for_mods("res://addons/Cubiix_Assets/Mods/")
	append_pck_mod(OS.get_executable_path().get_base_dir() + "/Mods/")
	scan_for_mods("res://addons/Cubiix_Assets/Mods/")
	compile_mod_assets()
	await self.load_finished
	load_mod_assets()
	await self.load_finished
	call_deferred("Init_Finish")
	
func Init_Finish():
	InitThread.wait_to_finish()
	emit_signal("FinishedLoad")
	
func append_pck_mod(location:String) -> void:
	var dir = DirAccess.open(location)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				scan_for_mods(location + file_name)
			else:
				if file_name.to_lower().ends_with(".pck"):
					ProjectSettings.load_resource_pack(location+"/"+file_name)
			file_name = dir.get_next()


func scan_for_mods(location:String) -> void:
	var dir = DirAccess.open(location)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				scan_for_mods(location + file_name)
			else:
				if file_name == "Mod.json":
					if !mod_files.has(location+"/"+file_name):
						mod_files.append(location+"/"+file_name)
						break
			file_name = dir.get_next()

func compile_mod_assets() -> void:
	for i in mod_files:
		var file = FileAccess.open(i, FileAccess.READ)
		var content = JSON.parse_string(file.get_as_text())
		var modarray = {
			"ModID":"",
			"ModName":"",
			"ModDesc":""
		}
		if content.has("ModID") && !mods.has(content["ModID"]):
			for x in content.keys():
				match x:
					"ModID", "ModName", "ModDesc":
						modarray[x] = content[x]
			mods[content["ModID"]] = modarray
			if content.has("Assets"):
				for n in content["Assets"].keys():
					for x in content["Assets"][n].keys():
						
						if content["Assets"][n][x].has("Path"):
							content["Assets"][n][x]["Path"] = i.rstrip("Mod.json")+content["Assets"][n][x]["Path"]
						if content["Assets"][n][x].has("Server_Path"):
							content["Assets"][n][x]["Server_Path"] = i.rstrip("Mod.json")+content["Assets"][n][x]["Server_Path"]
						if content["Assets"][n][x].has("Client_Path"):
							content["Assets"][n][x]["Client_Path"] = i.rstrip("Mod.json")+content["Assets"][n][x]["Client_Path"]
						if content["Assets"][n][x].has("Image_Preview"):
							content["Assets"][n][x]["Image_Preview"] = i.rstrip("Mod.json")+content["Assets"][n][x]["Image_Preview"]
						if content["Assets"][n][x].has("Tag"):
							if !assets_tagged.has(content["Assets"][n][x]["Tag"]) :
								assets_tagged[content["Assets"][n][x]["Tag"]] = []
							assets_tagged[content["Assets"][n][x]["Tag"]].append(content["ModID"]+"/"+x)
						#print(content["Assets"][n][x])
				assets[content["ModID"]] = content["Assets"]
			
				if content["Assets"].has("Override_Binds") && content["ModID"] == "CoreAssets":
					if content["Assets"]["Override_Binds"].has("V3"):
						for xc in content["Assets"]["Override_Binds"]["V3"].keys():
							if !assets_tagged.has(xc):
								#print(content["Assets"]["Override_Binds"]["V3"][xc])
								assets_tagged[xc] = content["Assets"]["Override_Binds"]["V3"][xc]
		
		else:
			if content.has("ModID"):
				print("Error: Conflicting Mod ID:"+content["ModID"])
			else:
				print("Error: Error Invalid Mod")
	
	call_deferred("emit_signal","load_finished")

func load_mod_assets() -> void:
	for i in assets.keys():
		for x in assets[i].keys():
			for y in assets[i][x]:
				if assets[i][x][y].has("Path"):
					if compiled_assets.keys().has(assets[i][x][y]["Path"]):
						assets[i][x][y]["Node"] = compiled_assets[assets[i][x][y]["Path"]]
					else:
						if x != "Scripts":
							compiled_assets[assets[i][x][y]["Path"]] = load(assets[i][x][y]["Path"]).instantiate()
							assets[i][x][y]["Node"] = compiled_assets[assets[i][x][y]["Path"]]
						
	call_deferred("emit_signal","load_finished")

var MeshRenderQueue = []
var MeshGenThread = Thread.new()
var MeshGenSemaphore = Semaphore.new()
var KillThreads = false


	
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		KillThreads = true
		
func _exit_tree() -> void:
	MeshGenThread.wait_to_finish()

func thread_force_post():
	MeshGenSemaphore.post()

func _ready() -> void:
	MeshGenThread.start(gen_thread_run)
	thread_force_post()

func gen_thread_run():
	while true:
		MeshGenSemaphore.wait()
		if KillThreads:
			break
		
		var Queue = MeshRenderQueue.pop_front()
		if Queue != null:
			generate_character_mesh(Queue[0],Queue[1],Queue[2],Queue[3])
		
	print("Killing Mesh Thread!")
	
	
func queue_character_mesh(AssetIDList:Array, TargetMesh:MeshInstance3D = null, TargetSkeleton:Skeleton3D = null, MainNode:Node = null) -> void:
	MeshRenderQueue.append([AssetIDList,TargetMesh,TargetSkeleton,MainNode])
	
func generate_character_mesh(AssetIDList:Array, TargetMesh:MeshInstance3D = null, TargetSkeleton:Skeleton3D = null, MainNode:Node = null) -> void:
	
	##This will replace the final model
	var Final_Mesh : ArrayMesh = ArrayMesh.new()
	
	## This is for the skeleton later for our bound stuff.
	var TargetSkin : Skin = Skin.new()
	
	## This is for keeping track of the blendshapes themselves if they need to exist.
	var Blendshape_Key : Array = []
	
	## This is for the bones we will need to replace after we create merge into a singular skeleton 
	## So that the vertex are bound correctly
	var Replace_Bone_Key : Dictionary = {}
	
	##This is for our dynamic bones when we finish loading the character
	var DynBoneList : Dictionary  = {}
	var Compiled_Dynbones:Array = []
	
	## This is pretty important, it's what will allow us to have a bounding box for the character
	var Compiled_AABB : AABB = AABB()
	
	## The key of this is as follows:
		## Mesh Validator (We need to see if it exists)
		## Mesh Initial Compile (This will set up our blendshapes, Skeleton, etc.)
		## Bone Re-Adjustment and compilation of mesh itself.
		## Blendshape Compilation
	
	## 1. Mesh Validator
	## So first we're going to validate all the models exist properly and compile them here.
	var Asset_List = {}
	
	for AssetID in AssetIDList:
		var node = find_asset(AssetID)
		if node != {}:
			if node.has("Mesh_Path") && node.has("Node"):
				Asset_List[AssetID] = node
				Asset_List[AssetID]["IDPath"] = AssetID 
	#print(Asset_List)
	#await get_tree().process_frame
	## 2. Mesh Initial Compile 
	## From here we're going to begin parsing through what we need, adding bones to a skeleton, etc.
	for Asset in Asset_List.values():
		var RealAsset = Asset
		var Mesh_Path = RealAsset["Mesh_Path"]
		var Node_Path = RealAsset["Node"]
		var DynBones = {}
		Replace_Bone_Key[Asset["IDPath"]] = [[],[]]
		var mesh = Node_Path.get_node(Mesh_Path ).mesh
		var node = Node_Path.get_node(Mesh_Path )
		var nodeskeleton = node.get_parent()
		
		## This is where we add blendshape count for later
		if RealAsset.has("Has_Blendshapes"):
			for blendshape in mesh.get_blend_shape_count():
				Final_Mesh.call_deferred("add_blend_shape",mesh.get_blend_shape_name(blendshape))
				Blendshape_Key.append(mesh.get_blend_shape_name(blendshape))
		
		## This is where we add the dynbone list for later
		if RealAsset.has("Has_DynBones"):
			DynBones = RealAsset["DynBone_Data"]["DynBone_Sets"].duplicate(true)
			Compiled_Dynbones.append(RealAsset["DynBone_Data"].duplicate(true))
			#print(RealAsset["DynBone_Data"]["DynBone_Sets"])
		
		## This is where we initially build the skeleton we will need + 
		if TargetSkeleton != null:
			for Bone in nodeskeleton.get_bone_count():
				var BoneName = nodeskeleton.get_bone_name(Bone)
				var Ms_Bone_Location = nodeskeleton.find_bone(BoneName)
				if TargetSkeleton.find_bone(BoneName) == -1:
					var Sk_Bone_Location = TargetSkeleton.add_bone(BoneName)
					var Sk_Bone_Parent = ""
					var Sk_Bone_Parent_Location = -1
					if nodeskeleton.get_bone_parent(Ms_Bone_Location) != -1:
						Sk_Bone_Parent = nodeskeleton.get_bone_name(nodeskeleton.get_bone_parent(Ms_Bone_Location))
						Sk_Bone_Parent_Location = TargetSkeleton.find_bone(Sk_Bone_Parent)
					TargetSkeleton.set_bone_parent(Sk_Bone_Location,Sk_Bone_Parent_Location)
					TargetSkeleton.set_bone_pose(Sk_Bone_Location,nodeskeleton.get_bone_rest(Bone))
					TargetSkeleton.set_bone_rest(Sk_Bone_Location,nodeskeleton.get_bone_rest(Bone))
					TargetSkin.add_named_bind(BoneName,node.skin.get_bind_pose(Bone))
					Replace_Bone_Key[Asset["IDPath"]][0].append(Ms_Bone_Location)
					Replace_Bone_Key[Asset["IDPath"]][1].append(Sk_Bone_Location)
					if RealAsset.has("Has_DynBones"):
						if MainNode != null:
							for x in DynBones.keys():
								for y in DynBones[x].size():
									if str(DynBones[x][y]) == BoneName:
										DynBones[x][y] = Sk_Bone_Location
			
	if MainNode != null:
		MainNode.DynBones_Register = Compiled_Dynbones
		#print(DynBoneList)
	
	## 3. 
	var CoreMesh_Commit = [PackedVector3Array(),PackedVector3Array(),PackedFloat32Array(),null,PackedVector2Array(),null,null,null,null,null,PackedInt32Array(),PackedFloat32Array(),PackedInt32Array()]
	var Bone_Rewrite = PackedInt32Array()
	var st = SurfaceTool.new()
	var Meshes = {}
	
	for Asset in Asset_List.values():
		var RealAsset = Asset
		var Mesh_Path = RealAsset["Mesh_Path"]
		var Node_Path = RealAsset["Node"]
		var mesh = [
			Node_Path.get_node(Mesh_Path).mesh,
			SurfaceTool.new()
		]
		Meshes[Asset["IDPath"]] = mesh
		mesh[1].append_from(mesh[0],0,Transform3D())
		mesh[1] = mesh[1].commit_to_arrays()
		var Mesh_Commit = mesh[1]
		st.append_from(mesh[0],0,Transform3D())
		Compiled_AABB = mesh[0].get_aabb().merge(Compiled_AABB)
		var Key = Replace_Bone_Key[Asset["IDPath"]]
		var IgnoreList = {}
		if !Key.is_empty():
			for CC in Mesh_Commit[Mesh.ARRAY_BONES].size():
				if Key[0].has(Mesh_Commit[Mesh.ARRAY_BONES][CC]) && !IgnoreList.has(CC):
					IgnoreList[CC] = 0
					Mesh_Commit[Mesh.ARRAY_BONES][CC] = Key[1][Key[0].find(Mesh_Commit[Mesh.ARRAY_BONES][CC])]
		#print(IgnoreList)
		for x in CoreMesh_Commit.size():
				if x == 10:
					Bone_Rewrite.append_array(Mesh_Commit[x])
					
	CoreMesh_Commit = st.commit_to_arrays()
	CoreMesh_Commit[10] = Bone_Rewrite
	
	var Blendshapes = []
	Blendshapes.resize(Blendshape_Key.size())
	
	for Asset in Asset_List.values():
		var RealAsset = Asset
		var Mesh_Path = RealAsset["Mesh_Path"]
		var Node_Path = RealAsset["Node"]
		var mesh = Node_Path.get_node(Mesh_Path).mesh
		var node = Node_Path.get_node(Mesh_Path)
		
		if RealAsset.has("Has_Blendshapes"):
				#print("Mesh: ",MeshSubList[i]," has Blendshapes")
				for b in Meshes[Asset["IDPath"]][0].get_blend_shape_count():
					##Compile Blended Mesh
					var New_Blend_Array
					var Blend_Name = Meshes[Asset["IDPath"]][0].get_blend_shape_name(b)
					
					var New_Blend_Array_Tool = SurfaceTool.new()
					New_Blend_Array_Tool.create_from_blend_shape(Meshes[Asset["IDPath"]][0],0,Blend_Name)
					New_Blend_Array = New_Blend_Array_Tool.commit_to_arrays()
	
					var Blend_Array_Compiled = [New_Blend_Array[0],Meshes[Asset["IDPath"]][1][1],Meshes[Asset["IDPath"]][1][2]]
					##Remove the values to get raw changed value
					for x in Blend_Array_Compiled[0].size():
						Blend_Array_Compiled[0][x] -= Meshes[Asset["IDPath"]][1][0][x]
					
					var Compiled_Blend_Array = [PackedVector3Array(),PackedVector3Array(),PackedFloat32Array()]
						
					for m in Asset_List:
						if Asset["IDPath"] == m:
							Compiled_Blend_Array[0].append_array(Blend_Array_Compiled[0])
							Compiled_Blend_Array[1].append_array(Blend_Array_Compiled[1])
							Compiled_Blend_Array[2].append_array(Blend_Array_Compiled[2])
						else:
							##Zero out mesh as we dont want it to interact with blendshape, but RETAIN normals and tangents
							var newpackedVec3 = PackedVector3Array()
							newpackedVec3.resize(Meshes[m][1][0].size())
							Compiled_Blend_Array[0].append_array(newpackedVec3)
							Compiled_Blend_Array[1].append_array(Meshes[m][1][1])
							Compiled_Blend_Array[2].append_array(Meshes[m][1][2])
							
					Blendshapes[Blendshape_Key.find(Meshes[Asset["IDPath"]][0].get_blend_shape_name(b))] = Compiled_Blend_Array
					
		for n in (Blendshapes.size()):
			var empty_blendshape = [PackedVector3Array(),PackedVector3Array(),PackedFloat32Array()]
			for m in Asset_List.keys():
				var newpackedVec3 = PackedVector3Array()
				newpackedVec3.resize(Meshes[m][1][0].size())

				empty_blendshape[0].append_array(newpackedVec3)
				empty_blendshape[1].append_array(Meshes[m][1][1])
				empty_blendshape[2].append_array(Meshes[m][1][2])
			if Blendshapes[n] == null:
				Blendshapes[n] = empty_blendshape

	Final_Mesh.call_deferred("add_surface_from_arrays", Mesh.PRIMITIVE_TRIANGLES,CoreMesh_Commit,Blendshapes)
				
	TargetMesh.call_deferred("set_mesh",Final_Mesh)
	TargetMesh.call_deferred("set_skin",TargetSkin)
	#print(Compiled_AABB)
	TargetMesh.set_custom_aabb(Compiled_AABB)
	##Apply materials to mesh surfaces as required
	TargetMesh.call_deferred("set_surface_override_material",0,MainNode.New_Shader)
	MainNode.call_deferred("emit_signal","Mesh_Finished")
	thread_force_post()

func find_script(ID:String, ApplyNode:Node3D, ParentNode:Node3D) -> void:
	var path = ""
	var AssetParts = ID.split("/")
	if assets.has(AssetParts[0]) &&\
		assets[AssetParts[0]].has("Scripts") &&\
		assets[AssetParts[0]]["Scripts"].has(AssetParts[1]) &&\
		assets[AssetParts[0]]["Scripts"][AssetParts[1]].has("Path"):
			ApplyNode.set_script(load(assets[AssetParts[0]]["Scripts"][AssetParts[1]]["Path"]))
			ApplyNode.name = AssetParts[1]

func find_animation(ID:String, ApplyNode:Node3D) -> void:
	var path = ""
	var AssetParts = ID.split("/")
	if assets.has(AssetParts[0]) &&\
		assets[AssetParts[0]].has("Animations") &&\
		assets[AssetParts[0]]["Animations"].has(AssetParts[1]) &&\
		assets[AssetParts[0]]["Animations"][AssetParts[1]].has("Node"):
			ApplyNode.add_child(assets[AssetParts[0]]["Animations"][AssetParts[1]]["Node"].duplicate())

func find_map(ID:String) -> Dictionary:
	var path = ""
	var AssetParts = ID.split("/")
	if assets.has(AssetParts[0]) &&\
		assets[AssetParts[0]].has("Maps") &&\
		assets[AssetParts[0]]["Maps"].has(AssetParts[1]):
			return assets[AssetParts[0]]["Maps"][AssetParts[1]]
	
	return {}

func find_log(ID:String) -> Dictionary:
	var path = ""
	var AssetParts = ID.split("/")
	if assets.has(AssetParts[0]) &&\
		assets[AssetParts[0]].has("Devlog_Entries") &&\
		assets[AssetParts[0]]["Devlog_Entries"].has(AssetParts[1]):
			return assets[AssetParts[0]]["Devlog_Entries"][AssetParts[1]]
	
	return {}

func find_asset(ID:String) -> Dictionary:
	var path = ""
	var AssetParts = ID.split("/")
	if assets.has(AssetParts[0]) &&\
		assets[AssetParts[0]].has("Models") &&\
		assets[AssetParts[0]]["Models"].has(AssetParts[1]):
			return assets[AssetParts[0]]["Models"][AssetParts[1]]
	
	return {}
