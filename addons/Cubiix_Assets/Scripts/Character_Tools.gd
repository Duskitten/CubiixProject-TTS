class_name cubiix_tool
extends Node

var Assets



func generate_character_from_string(Data:String,Target:Node3D) -> void:
	var V1_ConversionPath = Assets.assets["CoreAssets"]["Override_Binds"]["V1"]
	var V2_ConversionPath = Assets.assets["CoreAssets"]["Override_Binds"]["V2"]
	var V3_ConversionPath = Assets.assets["CoreAssets"]["Override_Binds"]["V3"]
	var json = JSON.new()
	json.parse(Data)
	
	var data = json.data
	var keyversion = 0
	
	if data == null:
		data = str_to_var(Data)
	
	if typeof(data) == TYPE_DICTIONARY:
		if keyversion == 0:
			for i in Assets.assets["CoreAssets"]["IDList"]["V1"]:
				if data.has(i):
					keyversion = 1
					break
		if keyversion == 0:
			for i in Assets.assets["CoreAssets"]["IDList"]["V2"]:
				if data.has(i):
					keyversion = 2
					break
					
		if keyversion == 0:
			for i in Assets.assets["CoreAssets"]["IDList"]["V3"]:
				if data.has(i):
					keyversion = 3
					break
		
		print(keyversion)
		
	match keyversion:
		1:
			for i in Target.Keylist["Body"].keys():
				Target.Shader_Metallic[Target.Keylist["Body"][i]] = 0
				Target.Shader_Roughness[Target.Keylist["Body"][i]] = 1
				
			for i in data.keys():
				match i:
					"EarID":
						if V1_ConversionPath.keys().has(data["EarID"]):
							if V1_ConversionPath.keys().has(data["ExtraID"]):
								if data["EarID"] == "Cubiix_Base:Shark_Fin":
									if data["ExtraID"] != "Cubiix_Base:Empty_Socket" :
										Target.Base_Extras = V1_ConversionPath[data["EarID"]]
									else:
										pass
								else:
									Target.Base_Ears = V1_ConversionPath[data["EarID"]]
					"ExtraID":
						if V1_ConversionPath.keys().has(data["ExtraID"]):
							Target.Base_Extras = V1_ConversionPath[data["ExtraID"]]
					"EyeCol":
						if data["EyeCol"] is Color:
							Target.Shader_Color[Target.Keylist["Body"]["Eye1"]] = Color(0,0,0,1)
							Target.Shader_Color[Target.Keylist["Body"]["Eye2"]] = Color(0,0,0,1)
							
							Target.Shader_Emission[Target.Keylist["Body"]["Eye1"]] = Color(data["EyeCol"].to_html(false))
							Target.Shader_Emission[Target.Keylist["Body"]["Eye2"]] = Color(data["EyeCol"].to_html(false))
							
							Target.Shader_Emission_Strength[Target.Keylist["Body"]["Eye1"]] = 1.0
							Target.Shader_Emission_Strength[Target.Keylist["Body"]["Eye2"]] = 1.0
					"EyeID":
						if V1_ConversionPath.keys().has(data["EyeID"]):
							Target.Base_Eyes = V1_ConversionPath[data["EyeID"]]
					"GlowCol":
						pass
					"Height":
						Target.Scale = clampf(float(data["Height"])+ 1.0, 0.8, 1.2)
					"PrimCol":
						if data["PrimCol"] is Color:
							Target.Shader_Color[Target.Keylist["Body"]["Body1"]] = Color(data["PrimCol"].to_html(false))
							Target.Shader_Emission[Target.Keylist["Body"]["Body1"]] = Color(0,0,0,1)
							Target.Shader_Emission_Strength[Target.Keylist["Body"]["Body1"]] = 0.0
					"TailID":
						if V1_ConversionPath.keys().has(data["TailID"]):
							Target.Base_Tails = V1_ConversionPath[data["TailID"]]
					"WingID":
						if V1_ConversionPath.keys().has(data["WingID"]):
							Target.Base_Wings = V1_ConversionPath[data["WingID"]]
					"WireCol":
						if data["WireCol"] is Color:
							Target.Shader_Color[Target.Keylist["Body"]["Body2"]] = Color(0,0,0,1)
							
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
							Target.Shader_Emission[Target.Keylist["Body"]["Body2"]] =  Color(data["WireCol"].to_html(false))
							Target.Shader_Emission_Strength[Target.Keylist["Body"]["Body2"]] = 1.0
					"WireInnerCol":
						pass
					"Name":
						if data["Name"] is String:
							Target.Name = data["Name"]
				
			Target.generate_character()
		2:
			for i in Target.Keylist["Body"].keys():
				Target.Shader_Metallic[Target.Keylist["Body"][i]] = 0
				Target.Shader_Roughness[Target.Keylist["Body"][i]] = 1
				
			for i in data.keys():
				match i:
					"Color_Body":
						Target.Shader_Color[Target.Keylist["Body"]["Body1"]] = Color(Color(str(data["Color_Body"])).to_html(false))
						Target.Shader_Emission[Target.Keylist["Body"]["Body1"]] = Color(0,0,0,1)
						Target.Shader_Emission_Strength[Target.Keylist["Body"]["Body1"]] = 0.0
					"Color_BodyGlow":
						Target.Shader_Color[Target.Keylist["Body"]["Body2"]] = Color(Color(str(data["Color_BodyGlow"])).to_html(false))
						Target.Shader_Emission[Target.Keylist["Body"]["Body2"]] = Color(Color(str(data["Color_BodyGlow"])).to_html(false))
						Target.Shader_Emission_Strength[Target.Keylist["Body"]["Body2"]] = 1
					"Color_Eye_1":
						Target.Shader_Color[Target.Keylist["Body"]["Eye1"]] = Color(Color(str(data["Color_Eye_1"])).to_html(false))
						Target.Shader_Emission[Target.Keylist["Body"]["Eye1"]] = Color(0,0,0,1)
						Target.Shader_Emission_Strength[Target.Keylist["Body"]["Eye1"]] = 1
					"Color_Eye_2":
						Target.Shader_Color[Target.Keylist["Body"]["Eye2"]] = Color(Color(str(data["Color_Eye_2"])).to_html(false))
						Target.Shader_Emission[Target.Keylist["Body"]["Eye2"]] = Color(0,0,0,1)
						Target.Shader_Emission_Strength[Target.Keylist["Body"]["Eye2"]] = 1
					"Ears":
						if V2_ConversionPath["Ears"].keys().has(data["Ears"]):
							Target.Base_Ears =  V2_ConversionPath["Ears"][data["Ears"]]
					"Extra":
						if V2_ConversionPath["Extras"].keys().has(data["Extra"]):
							Target.Base_Extras =  V2_ConversionPath["Extras"][data["Extra"]]
					"Eyes":
						if V2_ConversionPath["Eyes"].keys().has(data["Eyes"]):
							Target.Base_Eyes =  V2_ConversionPath["Eyes"][data["Eyes"]]
					"Size":
						Target.Scale = clampf(float(data["Size"])+ 1.0, 0.8, 1.2)
					"Tail":
						if V2_ConversionPath["Tails"].keys().has(data["Tail"]):
							Target.Base_Tails =  V2_ConversionPath["Tails"][data["Tail"]]
					"Wings":
						if V2_ConversionPath["Wings"].keys().has(data["Wings"]):
							Target.Base_Wings =  V2_ConversionPath["Wings"][data["Wings"]]
					"Name":
						if data["Name"] is String:
							Target.Name = data["Name"]
			Target.generate_character()
		3:
			for i in data.keys():
				match i:
					"B1":
						Target.Shader_Color[Target.Keylist["Body"]["Body1"]] = Color(Color(str(data["B1"])).to_html(false))
					"B2":
						Target.Shader_Color[Target.Keylist["Body"]["Body2"]] = Color(Color(str(data["B2"])).to_html(false))
					"B3":
						Target.Shader_Color[Target.Keylist["Body"]["Eye1"]] = Color(Color(str(data["B3"])).to_html(false))
					"B4":
						Target.Shader_Color[Target.Keylist["Body"]["Eye2"]] = Color(Color(str(data["B4"])).to_html(false))
					"B1E":
						Target.Shader_Emission[Target.Keylist["Body"]["Body1"]] = Color(Color(str(data["B1E"])).to_html(false))
					"B2E":
						Target.Shader_Emission[Target.Keylist["Body"]["Body2"]] = Color(Color(str(data["B2E"])).to_html(false))
					"B3E":
						Target.Shader_Emission[Target.Keylist["Body"]["Eye1"]] = Color(Color(str(data["B3E"])).to_html(false))
					"B4E":
						Target.Shader_Emission[Target.Keylist["Body"]["Eye2"]] = Color(Color(str(data["B4E"])).to_html(false))
					"B1ES":
						Target.Shader_Emission_Strength[Target.Keylist["Body"]["Body1"]] = clampf(float(data["B1ES"]), 0.0, 1.0)
					"B2ES":
						Target.Shader_Emission_Strength[Target.Keylist["Body"]["Body2"]] = clampf(float(data["B2ES"]), 0.0, 1.0)
					"B3ES":
						Target.Shader_Emission_Strength[Target.Keylist["Body"]["Eye1"]] = clampf(float(data["B3ES"]), 0.0, 1.0)
					"B4ES":
						Target.Shader_Emission_Strength[Target.Keylist["Body"]["Eye2"]] = clampf(float(data["B4ES"]), 0.0, 1.0)
					"B1R":
						Target.Shader_Roughness[Target.Keylist["Body"]["Body1"]] = clampf(float(data["B1R"]), 0.0, 1.0)
					"B2R":
						Target.Shader_Roughness[Target.Keylist["Body"]["Body2"]] = clampf(float(data["B2R"]), 0.0, 1.0)
					"B3R":
						Target.Shader_Roughness[Target.Keylist["Body"]["Eye1"]] = clampf(float(data["B3R"]), 0.0, 1.0)
					"B4R":
						Target.Shader_Roughness[Target.Keylist["Body"]["Eye2"]] = clampf(float(data["B4R"]), 0.0, 1.0)
					"B1M":
						Target.Shader_Metallic[Target.Keylist["Body"]["Body1"]] = clampf(float(data["B1M"]), 0.0, 1.0)
					"B2M":
						Target.Shader_Metallic[Target.Keylist["Body"]["Body2"]] = clampf(float(data["B2M"]), 0.0, 1.0)
					"B3M":
						Target.Shader_Metallic[Target.Keylist["Body"]["Eye1"]] = clampf(float(data["B3M"]), 0.0, 1.0)
					"B4M":
						Target.Shader_Metallic[Target.Keylist["Body"]["Eye2"]] = clampf(float(data["B4M"]), 0.0, 1.0)
					"T":
						if data["T"] is float:
							if int(data["T"]) < V3_ConversionPath["Tails"].size():
								Target.Base_Tails = V3_ConversionPath["Tails"][int(data["T"])]
						elif  data["T"] is String:
							if Assets.assets_tagged["Tails"].has(data["T"]):
								Target.Base_Tails = data["T"]
					"W":
						if data["W"] is float:
							if int(data["W"]) < V3_ConversionPath["Wings"].size():
								Target.Base_Wings = V3_ConversionPath["Wings"][int(data["W"])]
						elif  data["W"] is String:
							if Assets.assets_tagged["Wings"].has(data["W"]):
								Target.Base_Wings = data["W"]
					"EA":
						if data["EA"] is float:
							if int(data["EA"]) < V3_ConversionPath["Ears"].size():
								Target.Base_Ears = V3_ConversionPath["Ears"][int(data["EA"])]
						elif  data["EA"] is String:
							if Assets.assets_tagged["Ears"].has(data["EA"]):
								Target.Base_Ears = data["EA"]
					"EX":
						if data["EX"] is float:
							if int(data["EX"]) < V3_ConversionPath["Extras"].size():
								Target.Base_Extras = V3_ConversionPath["Extras"][int(data["EX"])]
						elif  data["EX"] is String:
							if Assets.assets_tagged["Extras"].has(data["EX"]):
								Target.Base_Extras = data["EX"]
					"EY":
						if data["EY"] is float:
							if int(data["EY"]) < V3_ConversionPath["Eyes"].size():
								Target.Base_Eyes = V3_ConversionPath["Eyes"][int(data["EY"])]
						elif  data["EY"] is String:
							if Assets.assets_tagged["Eyes"].has(data["EY"]):
								Target.Base_Eyes = data["EY"]
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
			Target.generate_character()

func clone_character(A:Node3D, B:Node3D) -> void:
	B.Shader_Color[B.Keylist["Body"]["Body1"]] = A.Shader_Color[B.Keylist["Body"]["Body1"]]
	B.Shader_Color[B.Keylist["Body"]["Body2"]] = A.Shader_Color[B.Keylist["Body"]["Body2"]]
	B.Shader_Color[B.Keylist["Body"]["Eye1"]] = A.Shader_Color[B.Keylist["Body"]["Eye1"]]
	B.Shader_Color[B.Keylist["Body"]["Eye2"]] = A.Shader_Color[B.Keylist["Body"]["Eye2"]]
	
	B.Shader_Emission[B.Keylist["Body"]["Body1"]] = A.Shader_Emission[B.Keylist["Body"]["Body1"]]
	B.Shader_Emission[B.Keylist["Body"]["Body2"]] = A.Shader_Emission[B.Keylist["Body"]["Body2"]]
	B.Shader_Emission[B.Keylist["Body"]["Eye1"]] = A.Shader_Emission[B.Keylist["Body"]["Eye1"]]
	B.Shader_Emission[B.Keylist["Body"]["Eye2"]] = A.Shader_Emission[B.Keylist["Body"]["Eye2"]]
	
	B.Shader_Emission_Strength[B.Keylist["Body"]["Body1"]] = A.Shader_Emission_Strength[B.Keylist["Body"]["Body1"]]
	B.Shader_Emission_Strength[B.Keylist["Body"]["Body2"]] = A.Shader_Emission_Strength[B.Keylist["Body"]["Body2"]]
	B.Shader_Emission_Strength[B.Keylist["Body"]["Eye1"]] = A.Shader_Emission_Strength[B.Keylist["Body"]["Eye1"]]
	B.Shader_Emission_Strength[B.Keylist["Body"]["Eye2"]] = A.Shader_Emission_Strength[B.Keylist["Body"]["Eye2"]]
	
	B.Shader_Roughness[B.Keylist["Body"]["Body1"]] = A.Shader_Roughness[B.Keylist["Body"]["Body1"]]
	B.Shader_Roughness[B.Keylist["Body"]["Body2"]] = A.Shader_Roughness[B.Keylist["Body"]["Body2"]]
	B.Shader_Roughness[B.Keylist["Body"]["Eye1"]] = A.Shader_Roughness[B.Keylist["Body"]["Eye1"]]
	B.Shader_Roughness[B.Keylist["Body"]["Eye2"]] = A.Shader_Roughness[B.Keylist["Body"]["Eye2"]]
	
	B.Shader_Metallic[B.Keylist["Body"]["Body1"]] = A.Shader_Metallic[B.Keylist["Body"]["Body1"]]
	B.Shader_Metallic[B.Keylist["Body"]["Body2"]] = A.Shader_Metallic[B.Keylist["Body"]["Body2"]]
	B.Shader_Metallic[B.Keylist["Body"]["Eye1"]] = A.Shader_Metallic[B.Keylist["Body"]["Eye1"]]
	B.Shader_Metallic[B.Keylist["Body"]["Eye2"]] = A.Shader_Metallic[B.Keylist["Body"]["Eye2"]]
	
	B.Base_Tails = A.Base_Tails
	B.Base_Wings = A.Base_Wings
	B.Base_Ears = A.Base_Ears
	B.Base_Extras = A.Base_Extras
	B.Base_Eyes = A.Base_Eyes
	B.Scale = A.Scale
	B.generate_character()

func export_character(Target:Node3D) -> String:
	var V3Template = {
	"B1":Target.Shader_Color[Target.Keylist["Body"]["Body1"]].to_html(false),
	"B2":Target.Shader_Color[Target.Keylist["Body"]["Body2"]].to_html(false),
	"B3":Target.Shader_Color[Target.Keylist["Body"]["Eye1"]].to_html(false),
	"B4":Target.Shader_Color[Target.Keylist["Body"]["Eye2"]].to_html(false),
	"B1E":Target.Shader_Emission[Target.Keylist["Body"]["Body1"]].to_html(false),
	"B2E":Target.Shader_Emission[Target.Keylist["Body"]["Body2"]].to_html(false),
	"B3E":Target.Shader_Emission[Target.Keylist["Body"]["Eye1"]].to_html(false),
	"B4E":Target.Shader_Emission[Target.Keylist["Body"]["Eye2"]].to_html(false),
	"B1ES":Target.Shader_Emission_Strength[Target.Keylist["Body"]["Body1"]],
	"B2ES":Target.Shader_Emission_Strength[Target.Keylist["Body"]["Body2"]],
	"B3ES":Target.Shader_Emission_Strength[Target.Keylist["Body"]["Eye1"]],
	"B4ES":Target.Shader_Emission_Strength[Target.Keylist["Body"]["Eye2"]],
	"B1R":Target.Shader_Roughness[Target.Keylist["Body"]["Body1"]],
	"B2R":Target.Shader_Roughness[Target.Keylist["Body"]["Body2"]],
	"B3R":Target.Shader_Roughness[Target.Keylist["Body"]["Eye1"]],
	"B4R":Target.Shader_Roughness[Target.Keylist["Body"]["Eye2"]],
	"B1M":Target.Shader_Metallic[Target.Keylist["Body"]["Body1"]],
	"B2M":Target.Shader_Metallic[Target.Keylist["Body"]["Body2"]],
	"B3M":Target.Shader_Metallic[Target.Keylist["Body"]["Eye1"]],
	"B4M":Target.Shader_Metallic[Target.Keylist["Body"]["Eye2"]],
	"T":Target.Base_Tails,
	"W":Target.Base_Wings,
	"EA":Target.Base_Ears,
	"EX":Target.Base_Extras,
	"EY":Target.Base_Eyes,
	"S":Target.Scale,
	"N":Target.Name,
	"PA":Target.Pronouns_A,
	"PB":Target.Pronouns_B,
	"PC":Target.Pronouns_C
	}
	
	return JSON.stringify(V3Template)
