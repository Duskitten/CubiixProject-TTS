extends Node



func _ready() -> void:
	var CharModel = load("res://Assets/Scenes/Client/cubiix_base.tscn")
	V1_ConversionPath = {
		"Cubiix_Base:Cat_Ears":CharModel.EAR_ENUM.Cat,
		"Cubiix_Base:Fox_Ears":CharModel.EAR_ENUM.Fox,
		"Cubiix_Base:Mouse_Ears":CharModel.EAR_ENUM.Mouse,
		"Cubiix_Base:Bee_Ears":CharModel.EAR_ENUM.Bee,
		"Cubiix_Base:Bunny_Ears":CharModel.EAR_ENUM.Bunny,
		"Cubiix_Base:Deer_Ears":CharModel.EAR_ENUM.Deer,
		"Cubiix_Base:Dog_Ears":CharModel.EAR_ENUM.Dog,
		"Cubiix_Base:Fluffy_Ears":CharModel.EAR_ENUM.Fluffy,
		"Cubiix_Base:Entity_Ears":CharModel.EAR_ENUM.Entity,
		"Cubiix_Base:Moth1_Ears":CharModel.EAR_ENUM.Moth,
		"Cubiix_Base:Moth2_Ears":CharModel.EAR_ENUM.Moth,
		"Cubiix_Base:Alien_Ears":CharModel.EAR_ENUM.Alien,
		"Cubiix_Base:Wolf_Ears":CharModel.EAR_ENUM.Wolf,
		"Cubiix_Base:Goat_Ears":CharModel.EAR_ENUM.Goat,
		
		"Cubiix_Base:Shark_Fin":CharModel.EXTRA_ENUM.Shark,
		"Cubiix_Base:Dragon_Extra":CharModel.EXTRA_ENUM.Dragon,
		"Cubiix_Base:Narwal_Extra":CharModel.EXTRA_ENUM.Narwhal,
		"Cubiix_Base:Deer_Extra":CharModel.EXTRA_ENUM.Nub,
		"Cubiix_Base:Antlers_Extra":CharModel.EXTRA_ENUM.Antler,
		"Cubiix_Base:Fish_Extra":CharModel.EXTRA_ENUM.Fish,
		"Cubiix_Base:Ram_Extra":CharModel.EXTRA_ENUM.Ram,
		
		"Cubiix_Base:Cat_Tail":CharModel.TAIL_ENUM.Cat,
		"Cubiix_Base:Fox_Tail":CharModel.TAIL_ENUM.Fox,
		"Cubiix_Base:Mouse_Tail":CharModel.TAIL_ENUM.Mouse,
		"Cubiix_Base:Shark_Tail":CharModel.TAIL_ENUM.Shark,
		"Cubiix_Base:Bee_Tail":CharModel.TAIL_ENUM.Bee,
		"Cubiix_Base:Bunny_Tail":CharModel.TAIL_ENUM.Bunny,
		"Cubiix_Base:Dragon_Tail":CharModel.TAIL_ENUM.Dragon,
		"Cubiix_Base:Deer_Tail":CharModel.TAIL_ENUM.Deer,
		"Cubiix_Base:Dog_Tail":CharModel.TAIL_ENUM.Dog,
		"Cubiix_Base:Fluffy_Tail":CharModel.TAIL_ENUM.Fluffy,
		"Cubiix_Base:Moth_Tail":CharModel.TAIL_ENUM.Moth,
		"Cubiix_Base:Entity_Tail":CharModel.TAIL_ENUM.Entity,
		"Cubiix_Base:Bug_Tail":CharModel.TAIL_ENUM.Bug,
		"Cubiix_Base:Wolf_Tail":CharModel.TAIL_ENUM.Wolf,
		
		"Cubiix_Base:Entity_Wings":CharModel.WING_ENUM.Entity,
		"Cubiix_Base:Bee_Wings":CharModel.WING_ENUM.Wasp,
		"Cubiix_Base:Dragon_Wings":CharModel.WING_ENUM.Dragon,
		"Cubiix_Base:Angel_Wings":CharModel.WING_ENUM.Angel,
		"Cubiix_Base:Moth_Wings":CharModel.WING_ENUM.Butterfly,
		"Cubiix_Base:Butterfly_Wings":CharModel.WING_ENUM.Butterfly,
		
		"Cubiix_Base:Default_Eyes":CharModel.EYE_ENUM.Default,
		"Cubiix_Base:Nat_Eyes":CharModel.EYE_ENUM.Nat,
		"Cubiix_Base:Triangle_Eyes":CharModel.EYE_ENUM.Tri,
		"Cubiix_Base:Circle_Eyes":CharModel.EYE_ENUM.Circle,
		"Cubiix_Base:Mouse_Eyes":CharModel.EYE_ENUM.Mouse,
		"Cubiix_Base:Text_Eyes":CharModel.EYE_ENUM.Text,
		"Cubiix_Base:Fox_Eyes":CharModel.EYE_ENUM.Fox,
		"Cubiix_Base:Four_Eyes":CharModel.EYE_ENUM.Four,
		"Cubiix_Base:Chonk_Eyes":CharModel.EYE_ENUM.Chonk,
		"Cubiix_Base:Entity_Eyes":CharModel.EYE_ENUM.Entity,
		
		"Cubiix_Base:Empty_Socket":0
		}

	V2_ConversionPath = {
		"Ears":{
			"None":0,
			"Fox":CharModel.EAR_ENUM.Fox,
			"Wolf":CharModel.EAR_ENUM.Wolf,
			"Goat":CharModel.EAR_ENUM.Goat,
			"Bee":CharModel.EAR_ENUM.Bee,
			"Cat":CharModel.EAR_ENUM.Cat,
			"Moth":CharModel.EAR_ENUM.Moth,
			"Moth2":CharModel.EAR_ENUM.Moth,
			"Mouse":CharModel.EAR_ENUM.Mouse,
			"Alien":CharModel.EAR_ENUM.Alien,
			"Deer":CharModel.EAR_ENUM.Deer,
			"Entity":CharModel.EAR_ENUM.Entity,
			"Dog":CharModel.EAR_ENUM.Dog,
			"Bunny":CharModel.EAR_ENUM.Bunny,
			"Fluffy":CharModel.EAR_ENUM.Fluffy
		},
		"Extra":{
			"None":0,
			"Shark":CharModel.EXTRA_ENUM.Shark,
			"Antler":CharModel.EXTRA_ENUM.Antler,
			"Ram":CharModel.EXTRA_ENUM.Ram,
			"Fish":CharModel.EXTRA_ENUM.Fish,
			"Narlwal":CharModel.EXTRA_ENUM.Narwhal,
			"Dragon":CharModel.EXTRA_ENUM.Dragon,
			"Nub":CharModel.EXTRA_ENUM.Nub
		},
		"Eyes":{
			"Chonk":CharModel.EYE_ENUM.Chonk,
			"Tri":CharModel.EYE_ENUM.Tri,
			"Nat":CharModel.EYE_ENUM.Nat,
			"Default":CharModel.EYE_ENUM.Default,
			"Circle":CharModel.EYE_ENUM.Circle,
			"Fox":CharModel.EYE_ENUM.Fox,
			"Mouse":CharModel.EYE_ENUM.Nat,
			"Four":CharModel.EYE_ENUM.Four,
			"Entity":CharModel.EYE_ENUM.Entity,
			"Text":CharModel.EYE_ENUM.Text
		},
		"Tail":{
			"None":0,
			"Fox":CharModel.TAIL_ENUM.Fox,
			"Wolf":CharModel.TAIL_ENUM.Wolf,
			"Bug":CharModel.TAIL_ENUM.Bug,
			"Bee":CharModel.TAIL_ENUM.Bee,
			"Moth":CharModel.TAIL_ENUM.Moth,
			"Dog":CharModel.TAIL_ENUM.Dog,
			"Mouse":CharModel.TAIL_ENUM.Mouse,
			"Fluffy":CharModel.TAIL_ENUM.Fluffy,
			"Cat":CharModel.TAIL_ENUM.Cat,
			"Shark":CharModel.TAIL_ENUM.Shark,
			"Entity":CharModel.TAIL_ENUM.Entity,
			"Bunny":CharModel.TAIL_ENUM.Bunny,
			"Deer":CharModel.TAIL_ENUM.Deer,
			"Dragon":CharModel.TAIL_ENUM.Dragon
		},
		"Wings":{
			"None":0,
			"Entity":CharModel.WING_ENUM.Entity,
			"Angel":CharModel.WING_ENUM.Angel,
			"Butterfly":CharModel.WING_ENUM.Butterfly,
			"Bee":CharModel.WING_ENUM.Wasp,
			"Dragon":CharModel.WING_ENUM.Dragon,
			"Moth":CharModel.WING_ENUM.Butterfly
		}
	}


func export_char(character:Node3D) -> String:
	var V3Template = {
	"B1":character.Body_1.to_html(false),
	"B2":character.Body_2.to_html(false),
	"B3":character.Body_3.to_html(false),
	"B4":character.Body_4.to_html(false),
	"B1E":character.Body_1_Emiss.to_html(false),
	"B2E":character.Body_2_Emiss.to_html(false),
	"B3E":character.Body_3_Emiss.to_html(false),
	"B4E":character.Body_4_Emiss.to_html(false),
	"B1ES":character.Body_1_Emiss_S,
	"B2ES":character.Body_2_Emiss_S,
	"B3ES":character.Body_3_Emiss_S,
	"B4ES":character.Body_4_Emiss_S,
	"B1R":character.Body_1_Roughness,
	"B2R":character.Body_2_Roughness,
	"B3R":character.Body_3_Roughness,
	"B4R":character.Body_4_Roughness,
	"B1M":character.Body_1_Metallic,
	"B2M":character.Body_2_Metallic,
	"B3M":character.Body_3_Metallic,
	"B4M":character.Body_4_Metallic,
	"T":character.Tail,
	"W":character.Wings,
	"EA":character.Ears,
	"EX":character.Extra,
	"EY":character.Eyes,
	"S":character.Scale,
	"N":character.Name,
	"PA":character.Pronouns_A,
	"PB":character.Pronouns_B,
	"PC":character.Pronouns_C
	}
	
	return JSON.stringify(V3Template)

func clone_char(A:Node3D,B:Node3D) -> void:
	A.Eyes = B.Eyes
	A.Ears = B.Ears 
	A.Extra = B.Extra 
	A.Tail = B.Tail 
	A.Wings = B.Wings

	A.Head = B.Head 
	A.Face = B.Face 
	A.Chest = B.Chest 
	A.Back = B.Back
	A.L_Hand = B.L_Hand
	A.R_Hand = B.R_Hand
	A.L_Hip = B.L_Hip
	A.R_Hip = B.R_Hip
	
	A.Body_1 = B.Body_1 
	A.Body_2 = B.Body_2
	A.Body_3 = B.Body_3 
	A.Body_4 = B.Body_4

	A.Body_1_Emiss = B.Body_1_Emiss
	A.Body_2_Emiss = B.Body_2_Emiss
	A.Body_3_Emiss = B.Body_3_Emiss
	A.Body_4_Emiss = B.Body_4_Emiss
	
	A.Body_1_Emiss_S  = B.Body_1_Emiss_S 
	A.Body_2_Emiss_S  = B.Body_2_Emiss_S 
	A.Body_3_Emiss_S  = B.Body_3_Emiss_S 
	A.Body_4_Emiss_S  = B.Body_4_Emiss_S 
	
	A.Body_1_Roughness = B.Body_1_Roughness
	A.Body_2_Roughness = B.Body_2_Roughness
	A.Body_3_Roughness = B.Body_3_Roughness
	A.Body_4_Roughness = B.Body_4_Roughness
	
	A.Body_1_Metallic  = B.Body_1_Metallic 
	A.Body_2_Metallic  = B.Body_2_Metallic 
	A.Body_3_Metallic  = B.Body_3_Metallic 
	A.Body_4_Metallic  = B.Body_4_Metallic 
	
	A.Scale  = B.Scale
	A.Name  = B.Name
	
	A.Pronouns_A  = B.Pronouns_A
	A.Pronouns_B  = B.Pronouns_B
	A.Pronouns_C  = B.Pronouns_C
	
	A.Regen_Character()

var V1_Keywords = [
	"EarID",
	"ExtraID",
	"EyeCol",
	"EyeID",
	"GlowCol",
	"Height",
	"PrimCol",
	"TailID",
	"WingID",
	"WireCol",
	"WireInnerCol"
	]
	
var V2_Keywords = [
	"Color_Body",
	"Color_BodyGlow",
	"Color_Eye_1",
	"Color_Eye_2",
	"Ears",
	"Extra",
	"Eyes",
	"Size",
	"Tail",
	"Wings"
	]
	
var V3_Keywords = [
	"B1",
	"B2",
	"B3",
	"B4",
	"B1E",
	"B2E",
	"B3E",
	"B4E",
	"B1ES",
	"B2ES",
	"B3ES",
	"B4ES",
	"B1R",
	"B2R",
	"B3R",
	"B4R",
	"B1M",
	"B2M",
	"B3M",
	"B4M",
	"T",
	"W",
	"EA",
	"EX",
	"EY",
	"S",
	"N",
	"PA",
	"PB",
	"PC"
	]

##Since paths changed, we need to have a lookup index!
var V1_ConversionPath = {}

var V2_ConversionPath = {}
func generate_char_from_string(Data:String,Target:Node3D) -> void:
	var json = JSON.new()
	json.parse(Data)
	
	var data = json.data
	var keyversion = 0
	
	if data == null:
		data = str_to_var(Data)

	if typeof(data) == TYPE_DICTIONARY:
		
		if keyversion == 0:
			for i in V1_Keywords:
				if data.has(i):
					keyversion = 1
					break
		if keyversion == 0:
			for i in V2_Keywords:
				if data.has(i):
					keyversion = 2
					break
					
		if keyversion == 0:
			for i in V3_Keywords:
				if data.has(i):
					keyversion = 3
					break
		
		
		match keyversion:
			1:
				print("Version 1 Save!")
				Target.Body_1_Roughness = 1
				Target.Body_2_Roughness = 1
				Target.Body_3_Roughness = 1
				Target.Body_4_Roughness = 1
				
				Target.Body_1_Metallic = 1
				Target.Body_2_Metallic = 1
				Target.Body_3_Metallic = 1
				Target.Body_4_Metallic = 1
				for i in data.keys():
					match i:
						"EarID":
							if V1_ConversionPath.keys().has(data["EarID"]):
								if V1_ConversionPath.keys().has(data["ExtraID"]):
									if data["EarID"] == "Cubiix_Base:Shark_Fin" && data["ExtraID"] != "Cubiix_Base:Empty_Socket" :
										pass
										
								Target.Ears = V1_ConversionPath[data["EarID"]]
						"ExtraID":
							if V1_ConversionPath.keys().has(data["ExtraID"]):
								Target.Extra = V1_ConversionPath[data["ExtraID"]]
						"EyeCol":
							if data["EyeCol"] is Color:
								Target.Body_3 = Color(0,0,0,1)
								Target.Body_4 = Color(0,0,0,1)
								Target.Body_3_Emiss = Color(data["EyeCol"].to_html(false))
								Target.Body_4_Emiss = Color(data["EyeCol"].to_html(false))
								Target.Body_3_Emiss_S = 1.0
								Target.Body_4_Emiss_S = 1.0
						"EyeID":
							if V1_ConversionPath.keys().has(data["EyeID"]):
								Target.Eyes = V1_ConversionPath[data["EyeID"]]
						"GlowCol":
							pass
						"Height":
							Target.Scale = clampf(float(data["Height"])+ 1.0, 0.8, 1.2)
						"PrimCol":
							if data["PrimCol"] is Color:
								Target.Body_1 = Color(data["PrimCol"].to_html(false))
								Target.Body_1_Emiss = Color(0,0,0,1)
								Target.Body_1_Emiss_S = 0.0
						"TailID":
							if V1_ConversionPath.keys().has(data["TailID"]):
								Target.Tail = V1_ConversionPath[data["TailID"]]
						"WingID":
							if V1_ConversionPath.keys().has(data["WingID"]):
								Target.Wings = V1_ConversionPath[data["WingID"]]
						"WireCol":
							if data["WireCol"] is Color:
								Target.Body_2 = Color(0,0,0,1)
								if data["WireCol"].r > 1.0 || data["WireCol"].g > 1.0 || data["WireCol"].b > 1.0:
									var sortedValues = [snapped(data["WireCol"].r,0.01),snapped(data["WireCol"].g,0.01),snapped(data["WireCol"].b,0.01)]
									var sortarray = sortedValues.duplicate(true)
									var percentage = (sortarray[2] - 1) * 100
									var newArray = [0,0,0]
									for x in sortarray.size():
										newArray[x] = sortedValues[x] / (percentage/100)
									
									print(newArray)
										
									data["WireCol"] = Color(newArray[0],newArray[1],newArray[2],1.0)
									
									pass
								Target.Body_2_Emiss =  Color(data["WireCol"].to_html(false))
								Target.Body_2_Emiss_S = 1.0
						"WireInnerCol":
							pass
						"Name":
							pass
			2:
				print("Version 2 Save!")
				Target.Body_1_Roughness = 1
				Target.Body_2_Roughness = 1
				Target.Body_3_Roughness = 1
				Target.Body_4_Roughness = 1
				
				Target.Body_1_Metallic = 1
				Target.Body_2_Metallic = 1
				Target.Body_3_Metallic = 1
				Target.Body_4_Metallic = 1
				for i in data.keys():
					match i:
						"Color_Body":
							Target.Body_1 = Color(Color(str(data["Color_Body"])).to_html(false))
							Target.Body_1_Emiss = Color(0,0,0,1)
							Target.Body_1_Emiss_S = 0.0
						"Color_BodyGlow":
							Target.Body_2 = Color(Color(str(data["Color_BodyGlow"])).to_html(false))
							Target.Body_2_Emiss = Color(Color(str(data["Color_BodyGlow"])).to_html(false))
							Target.Body_2_Emiss_S = 1
						"Color_Eye_1":
							Target.Body_3 = Color(0,0,0,1)
							Target.Body_3_Emiss = Color(Color(str(data["Color_Eye_1"])).to_html(false))
							Target.Body_3_Emiss_S = 1
						"Color_Eye_2":
							Target.Body_4 = Color(0,0,0,1)
							Target.Body_4_Emiss = Color(Color(str(data["Color_Eye_2"])).to_html(false))
							Target.Body_4_Emiss_S = 1
						"Ears":
							if V2_ConversionPath["Ears"].keys().has(data["Ears"]):
								Target.Ears =  V2_ConversionPath["Ears"][data["Ears"]]
						"Extra":
							if V2_ConversionPath["Extra"].keys().has(data["Extra"]):
								Target.Extra =  V2_ConversionPath["Extra"][data["Extra"]]
						"Eyes":
							if V2_ConversionPath["Eyes"].keys().has(data["Eyes"]):
								Target.Eyes =  V2_ConversionPath["Eyes"][data["Eyes"]]
						"Size":
							Target.Scale = clampf(float(data["Size"])+ 1.0, 0.8, 1.2)
						"Tail":
							if V2_ConversionPath["Tail"].keys().has(data["Tail"]):
								Target.Tail =  V2_ConversionPath["Tail"][data["Tail"]]
						"Wings":
							if V2_ConversionPath["Wings"].keys().has(data["Wings"]):
								Target.Wings =  V2_ConversionPath["Wings"][data["Wings"]]
						"Name":
							pass
			3:
				print("Version 3 Save!")
				for i in data.keys():
					match i:
						"B1":
							Target.Body_1 = Color(Color(str(data["B1"])).to_html(false))
						"B2":
							Target.Body_2 = Color(Color(str(data["B2"])).to_html(false))
						"B3":
							Target.Body_3 = Color(Color(str(data["B3"])).to_html(false))
						"B4":
							Target.Body_4 = Color(Color(str(data["B4"])).to_html(false))
						"B1E":
							Target.Body_1_Emiss = Color(Color(str(data["B1E"])).to_html(false))
						"B2E":
							Target.Body_2_Emiss = Color(Color(str(data["B2E"])).to_html(false))
						"B3E":
							Target.Body_3_Emiss = Color(Color(str(data["B3E"])).to_html(false))
						"B4E":
							Target.Body_4_Emiss = Color(Color(str(data["B4E"])).to_html(false))
						"B1ES":
							Target.Body_1_Emiss_S = clampf(float(data["B1ES"]), 0.0, 1.0)
						"B2ES":
							Target.Body_2_Emiss_S = clampf(float(data["B2ES"]), 0.0, 1.0)
						"B3ES":
							Target.Body_3_Emiss_S = clampf(float(data["B3ES"]), 0.0, 1.0)
						"B4ES":
							Target.Body_4_Emiss_S = clampf(float(data["B4ES"]), 0.0, 1.0)
						"B1R":
							Target.Body_1_Roughness = clampf(float(data["B1R"]), 0.0, 1.0)
						"B2R":
							Target.Body_2_Roughness = clampf(float(data["B2R"]), 0.0, 1.0)
						"B3R":
							Target.Body_3_Roughness = clampf(float(data["B3R"]), 0.0, 1.0)
						"B4R":
							Target.Body_4_Roughness = clampf(float(data["B4R"]), 0.0, 1.0)
						"B1M":
							Target.Body_1_Metallic = clampf(float(data["B1M"]), 0.0, 1.0)
						"B2M":
							Target.Body_2_Metallic = clampf(float(data["B2M"]), 0.0, 1.0)
						"B3M":
							Target.Body_3_Metallic = clampf(float(data["B3M"]), 0.0, 1.0)
						"B4M":
							Target.Body_4_Metallic = clampf(float(data["B4M"]), 0.0, 1.0)
						"T":
							Target.Tail = int(data["T"])
						"W":
							Target.Wings = int(data["W"])
						"EA":
							Target.Ears = int(data["EA"])
						"EX":
							Target.Extra = int(data["EX"])
						"EY":
							Target.Eyes = int(data["EY"])
						"S":
							Target.Scale = clampf(float(data["S"]), 0.8, 1.2)
						"N":
							Target.Name = str(data["N"])
						"PA":
							Target.Pronouns_A = str(data["PA"])
						"PB":
							Target.Pronouns_B = str(data["PB"])
						"PC":
							Target.Pronouns_C = str(data["PC"])
	Target.Regen_Character()
