extends Node

var Model_Data_Assets = {
	##Body
	"Body":"res://Assets/Mesh/Cubiix/Cubiix_Base.gltf",
	##Eyes
	"Eyes/Default":"res://Assets/Mesh/Cubiix/Peices/Eyes/Eyes_Default.gltf",
	"Eyes/Chonk":"res://Assets/Mesh/Cubiix/Peices/Eyes/Eyes_Chonk.gltf",
	"Eyes/Tri":"res://Assets/Mesh/Cubiix/Peices/Eyes/Eyes_Tri.gltf",
	"Eyes/Nat":"res://Assets/Mesh/Cubiix/Peices/Eyes/Eyes_Nat.gltf",
	"Eyes/Circle":"res://Assets/Mesh/Cubiix/Peices/Eyes/Eyes_Circle.gltf",
	"Eyes/Fox":"res://Assets/Mesh/Cubiix/Peices/Eyes/Eyes_Fox.gltf",
	"Eyes/Four":"res://Assets/Mesh/Cubiix/Peices/Eyes/Eyes_Four.gltf",
	"Eyes/Entity":"res://Assets/Mesh/Cubiix/Peices/Eyes/Eyes_Entity.gltf",
	"Eyes/Text":"res://Assets/Mesh/Cubiix/Peices/Eyes/Eyes_Text.gltf",
	"Eyes/Mouse":"res://Assets/Mesh/Cubiix/Peices/Eyes/Eyes_Mouse.gltf",
	##Ears
	"Ears/Cat":"res://Assets/Mesh/Cubiix/Peices/Ears/Cat_Ears.gltf",
	"Ears/Fox":"res://Assets/Mesh/Cubiix/Peices/Ears/Fox_Ears.gltf",
	"Ears/Wolf":"res://Assets/Mesh/Cubiix/Peices/Ears/Wolf_Ears.gltf",
	"Ears/Goat":"res://Assets/Mesh/Cubiix/Peices/Ears/Goat_Ears.gltf",
	"Ears/Bee":"res://Assets/Mesh/Cubiix/Peices/Ears/Bee_Ears.gltf",
	"Ears/Moth":"res://Assets/Mesh/Cubiix/Peices/Ears/Moth_Ears.gltf",
	"Ears/Mouse":"res://Assets/Mesh/Cubiix/Peices/Ears/Mouse_Ears.gltf",
	"Ears/Alien":"res://Assets/Mesh/Cubiix/Peices/Ears/Alien_Ears.gltf",
	"Ears/Deer":"res://Assets/Mesh/Cubiix/Peices/Ears/Deer_Ears.gltf",
	"Ears/Entity":"res://Assets/Mesh/Cubiix/Peices/Ears/Entity_Ears.gltf",
	"Ears/Dog":"res://Assets/Mesh/Cubiix/Peices/Ears/Dog_Ears.gltf",
	"Ears/Bunny":"res://Assets/Mesh/Cubiix/Peices/Ears/Bunny_Ears.gltf",
	"Ears/Fluffy":"res://Assets/Mesh/Cubiix/Peices/Ears/Fluffy_Ears.gltf",
	##Extra
	"Extra/Shark":"res://Assets/Mesh/Cubiix/Peices/Extra/Shark_Extra.gltf",
	"Extra/Nub":"res://Assets/Mesh/Cubiix/Peices/Extra/Nub_Extra.gltf",
	"Extra/Antler":"res://Assets/Mesh/Cubiix/Peices/Extra/Antler_Extra.gltf",
	"Extra/Ram":"res://Assets/Mesh/Cubiix/Peices/Extra/Ram_Extra.gltf",
	"Extra/Fish":"res://Assets/Mesh/Cubiix/Peices/Extra/Fish_Extra.gltf",
	"Extra/Narwhal":"res://Assets/Mesh/Cubiix/Peices/Extra/Narwhal_Extra.gltf",
	"Extra/Dragon":"res://Assets/Mesh/Cubiix/Peices/Extra/Dragon_Extra.gltf",
	##Wings
	"Wings/Entity":"res://Assets/Mesh/Cubiix/Peices/Wings/Entity_Wings.gltf",
	"Wings/Angel":"res://Assets/Mesh/Cubiix/Peices/Wings/Angel_Wings.gltf",
	"Wings/Butterfly":"res://Assets/Mesh/Cubiix/Peices/Wings/Butterfly_Wings.gltf",
	"Wings/Wasp":"res://Assets/Mesh/Cubiix/Peices/Wings/Wasp_Wings.gltf",
	"Wings/Dragon":"res://Assets/Mesh/Cubiix/Peices/Wings/Dragon_Wings.gltf",
	##Tail
	"Tails/Cat":"res://Assets/Mesh/Cubiix/Peices/Tails/Cat_Tail.gltf",
	"Tails/Fox":"res://Assets/Mesh/Cubiix/Peices/Tails/Fox_Tail.gltf",
	"Tails/Wolf":"res://Assets/Mesh/Cubiix/Peices/Tails/Wolf_Tail.gltf",
	"Tails/Bug":"res://Assets/Mesh/Cubiix/Peices/Tails/Bug_Tail.gltf",
	"Tails/Bee":"res://Assets/Mesh/Cubiix/Peices/Tails/Bee_Tail.gltf",
	"Tails/Moth":"res://Assets/Mesh/Cubiix/Peices/Tails/Moth_Tail.gltf",
	"Tails/Dog":"res://Assets/Mesh/Cubiix/Peices/Tails/Dog_Tail.gltf",
	"Tails/Mouse":"res://Assets/Mesh/Cubiix/Peices/Tails/Mouse_Tail.gltf",
	"Tails/Fluffy":"res://Assets/Mesh/Cubiix/Peices/Tails/Fluffy_Tail.gltf",
	"Tails/Shark":"res://Assets/Mesh/Cubiix/Peices/Tails/Shark_Tail.gltf",
	"Tails/Entity":"res://Assets/Mesh/Cubiix/Peices/Tails/Entity_Tail.gltf",
	"Tails/Bunny":"res://Assets/Mesh/Cubiix/Peices/Tails/Bunny_Tail.gltf",
	"Tails/Deer":"res://Assets/Mesh/Cubiix/Peices/Tails/Deer_Tail.gltf",
	"Tails/Dragon":"res://Assets/Mesh/Cubiix/Peices/Tails/Dragon_Tail.gltf",
	##Head Clothes
	"Head_Clothes/Goggle_Test":"res://Assets/Mesh/Cubiix/Peices/Clothes_Head/Goggle_Test.gltf",
	"Head_Clothes/Orb_Test":"res://Assets/Mesh/Cubiix/Peices/Clothes_Head/Orb_Test.gltf",
	"Head_Clothes/DotMouse_Hat":"res://Assets/Mesh/Cubiix/Peices/Clothes_Head/DotMouse_Hat.gltf",
	"Head_Clothes/Pumpkin_Head":"res://Assets/Mesh/Cubiix/Peices/Clothes_Head/Pumpkin_Head.gltf",
	"Head_Clothes/Devil_Head":"res://Assets/Mesh/Cubiix/Peices/Clothes_Head/Devil_Head.gltf",
	"Head_Clothes/Witch_Head":"res://Assets/Mesh/Cubiix/Peices/Clothes_Head/Witch_Head.gltf",
	"Head_Clothes/Generic_Helmet":"res://Assets/Mesh/Cubiix/Peices/Clothes_Head/Generic_Helmet.gltf",
	##Face Clothes
	"Face_Clothes/Nerd_Glasses":"res://Assets/Mesh/Cubiix/Peices/Clothes_Face/Nerd_Glasses.gltf",

	##Chest Clothes
	"Chest_Clothes/Pride_Bandana":"res://Assets/Mesh/Cubiix/Peices/Clothes_Chest/Pride_Bandana.gltf",
	##L_Hip Clothes
	"L_Hip/HipSkirt":"res://Assets/Mesh/Cubiix/Peices/Clothes_Hip_L/HipSkirt_L.gltf",
	##R_Hip Clothes
	"R_Hip/HipSkirt":"res://Assets/Mesh/Cubiix/Peices/Clothes_Hip_R/HipSkirt_R.gltf",
	##Back Clothes
	"Back_Clothes/Cape_1":"res://Assets/Mesh/Cubiix/Peices/Clothes_Back/Cape_1.gltf",
	
	
	#Madness Stuff:
	"Face_Clothes/MC_Agent_Glasses":"res://Assets/Mesh/Cubiix/Peices/Clothes_Face/Agent_Glasses.gltf",
	"Head_Clothes/MC_Deimos_Visor":"res://Assets/Mesh/Cubiix/Peices/Clothes_Head/Deimos_Visor.gltf",
}

var InitThread:Thread
signal FinishedLoad
func runsetup(CoreNode) -> void:
	Core = CoreNode
	InitThread = Thread.new()
	InitThread.start(Init_ThreadRun)
	
func Init_ThreadRun():
	var assetcount = Model_Data_Assets.keys().size()
	var currentAsset = 0
	for i in Model_Data_Assets.keys():
		currentAsset += 1
		Model_Data_Assets[i] = load(Model_Data_Assets[i]).instantiate()
		Core.call_deferred("Update_LogoText","Loading Character Assets: "+str(currentAsset)+"/"+str(assetcount))
		await Core.get_tree().process_frame
		
	call_deferred("Init_Finish")
	
func Init_Finish():
	InitThread.wait_to_finish()
	emit_signal("FinishedLoad")

var Mesh_Data_Assets = {
	##Body
	"Body":{
		"Mesh_Node":"Armature/Skeleton3D/Cube",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":false,
		"Has_DynBones":false,
		"Data":[]
		},
	##Eyes
	"Eyes/Default":{
		"Name": "Default",
		"Mesh_Node":"Armature/Skeleton3D/Eyes_Default",
		"MaterialID":"User",
		"Has_Blendshapes":true,
		"Has_Bones":false,
		"Has_DynBones":false,
		"Data":[],
		"BlendData":{}
	},
	"Eyes/Chonk":{
		"Name": "Chonk",
		"Mesh_Node":"Armature/Skeleton3D/Eyes_Chonk",
		"MaterialID":"User",
		"Has_Blendshapes":true,
		"Has_Bones":false,
		"Has_DynBones":false,
		"Data":[],
		"BlendData":{}
	},
	"Eyes/Tri":{
		"Name": "Tri",
		"Mesh_Node":"Armature/Skeleton3D/Eyes_Tri",
		"MaterialID":"User",
		"Has_Blendshapes":true,
		"Has_Bones":false,
		"Has_DynBones":false,
		"Data":[],
		"BlendData":{}
	},
	"Eyes/Nat":{
		"Name": "Nat",
		"Mesh_Node":"Armature/Skeleton3D/Eyes_Nat",
		"MaterialID":"User",
		"Has_Blendshapes":true,
		"Has_Bones":false,
		"Has_DynBones":false,
		"Data":[],
		"BlendData":{}
	},
	"Eyes/Circle":{
		"Name": "Circle",
		"Mesh_Node":"Armature/Skeleton3D/Eyes_Circle",
		"MaterialID":"User",
		"Has_Blendshapes":true,
		"Has_Bones":false,
		"Has_DynBones":false,
		"Data":[],
		"BlendData":{}
	},
	"Eyes/Fox":{
		"Name": "Fox",
		"Mesh_Node":"Armature/Skeleton3D/Eyes_Fox",
		"MaterialID":"User",
		"Has_Blendshapes":true,
		"Has_Bones":false,
		"Has_DynBones":false,
		"Data":[],
		"BlendData":{}
	},
	"Eyes/Four":{
		"Name": "Four",
		"Mesh_Node":"Armature/Skeleton3D/Eyes_Four",
		"MaterialID":"User",
		"Has_Blendshapes":true,
		"Has_Bones":false,
		"Has_DynBones":false,
		"Data":[],
		"BlendData":{}
	},
	"Eyes/Entity":{
		"Name": "Entity",
		"Mesh_Node":"Armature/Skeleton3D/Eyes_Entity",
		"MaterialID":"User",
		"Has_Blendshapes":true,
		"Has_Bones":false,
		"Has_DynBones":false,
		"Data":[],
		"BlendData":{}
	},
	"Eyes/Text":{
		"Name": "Text",
		"Mesh_Node":"Armature/Skeleton3D/Eyes_Text",
		"MaterialID":"User",
		"Has_Blendshapes":true,
		"Has_Bones":false,
		"Has_DynBones":false,
		"Data":[],
		"BlendData":{}
	},
	"Eyes/Mouse":{
		"Name": "Mouse",
		"Mesh_Node":"Armature/Skeleton3D/Eyes_Mouse",
		"MaterialID":"User",
		"Has_Blendshapes":true,
		"Has_Bones":false,
		"Has_DynBones":false,
		"Data":[],
		"BlendData":{}
	},
	##Ears
	"Ears/Cat":{
		"Name": "Cat",
		"Mesh_Node":"Cat_Ear_Armature/Skeleton3D/Cat_Ears",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":true,
		"Has_DynBones":true,
		"Data":[],
		"DynBone_Data":{
			"DynBone_Sets":{
				"Cat_Ear_L":["Ear_L"],
				"Cat_Ear_R":["Ear_R"]
			},
			"DynBone_Settings":{
				"Cat_Ear_L":{
					"osc_ps":19,
					"dampening": .1,
					"damp_time":.5,
					"extension_damp_time":.3,
				},
				"Cat_Ear_R":{
					"osc_ps":19,
					"dampening": .1,
					"damp_time":.5,
					"extension_damp_time":.3,
				}
			}
		}
	},
	"Ears/Fox":{
		"Name": "Fox",
		"Mesh_Node":"Fox_Ear_Armature/Skeleton3D/Fox_Ears",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":true,
		"Has_DynBones":true,
		"Data":[],
		"DynBone_Data":{
			"DynBone_Sets":{
				"Fox_Ear_L":["Ear_L"],
				"Fox_Ear_R":["Ear_R"]
			},
			"DynBone_Settings":{
				"Fox_Ear_L":{
					"osc_ps":19,
					"dampening": .1,
					"damp_time":.5,
					"extension_damp_time":.3,
				},
				"Fox_Ear_R":{
					"osc_ps":19,
					"dampening": .1,
					"damp_time":.5,
					"extension_damp_time":.3,
				}
			}
		}
	},
	"Ears/Wolf":{
		"Name": "Wolf",
		"Mesh_Node":"Wolf_Ear_Armature/Skeleton3D/Wolf_Ears",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":true,
		"Has_DynBones":true,
		"Data":[],
		"DynBone_Data":{
			"DynBone_Sets":{
				"Wolf_Ear_L":["Ear_L"],
				"Wolf_Ear_R":["Ear_R"]
			},
			"DynBone_Settings":{
				"Wolf_Ear_L":{
					"osc_ps":19,
					"dampening": .1,
					"damp_time":.5,
					"extension_damp_time":.3,
				},
				"Wolf_Ear_R":{
					"osc_ps":19,
					"dampening": .1,
					"damp_time":.5,
					"extension_damp_time":.3,
				}
			}
		}
	},
	"Ears/Goat":{
		"Name": "Goat",
		"Mesh_Node":"Goat_Ear_Armature/Skeleton3D/Goat_Ears",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":true,
		"Has_DynBones":true,
		"Data":[],
		"DynBone_Data":{
			"DynBone_Sets":{
				"Goat_Ear_L":["Ear_L"],
				"Goat_Ear_R":["Ear_R"]
			},
			"DynBone_Settings":{
				"Goat_Ear_L":{
					"osc_ps":19,
					"dampening": .1,
					"damp_time":.5,
					"extension_damp_time":.3,
				},
				"Goat_Ear_R":{
					"osc_ps":19,
					"dampening": .1,
					"damp_time":.5,
					"extension_damp_time":.3,
				}
			}
		}
	},
	"Ears/Bee":{
		"Name": "Bee",
		"Mesh_Node":"Bee_Ear_Armature/Skeleton3D/Bee_Ears",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":true,
		"Has_DynBones":true,
		"Data":[],
		"DynBone_Data":{
			"DynBone_Sets":{
				"Bee_Ear_L":["Ear_L","Ear_L.001","Ear_L.002","Ear_L.003","Ear_L.004","Ear_L.005"],
				"Bee_Ear_R":["Ear_R","Ear_R.001","Ear_R.002","Ear_R.003","Ear_R.004","Ear_R.005"]
			},
			"DynBone_Settings":{
				"Bee_Ear_L":{
					"osc_ps":19,
					"dampening": .1,
					"damp_time":.5,
					"extension_damp_time":.3,
				},
				"Bee_Ear_R":{
					"osc_ps":19,
					"dampening": .1,
					"damp_time":.5,
					"extension_damp_time":.3,
				}
			}
		}
	},
	"Ears/Moth":{
		"Name": "Moth",
		"Mesh_Node":"Moth_Ear_Armature/Skeleton3D/Moth_Ears",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":true,
		"Has_DynBones":true,
		"Data":[],
		"DynBone_Data":{
			"DynBone_Sets":{
				"Moth_Ear_L":["Ear_L","Ear_L.001","Ear_L.002","Ear_L.003","Ear_L.004","Ear_L.005"],
				"Moth_Ear_R":["Ear_R","Ear_R.001","Ear_R.002","Ear_R.003","Ear_R.004","Ear_R.005"]
			},
			"DynBone_Settings":{
				"Moth_Ear_L":{
					"osc_ps":19,
					"dampening": .1,
					"damp_time":.5,
					"extension_damp_time":.3,
				},
				"Moth_Ear_R":{
					"osc_ps":19,
					"dampening": .1,
					"damp_time":.5,
					"extension_damp_time":.3,
				}
			}
		}
	},
	"Ears/Mouse":{
		"Name": "Mouse",
		"Mesh_Node":"Mouse_Ear_Armature/Skeleton3D/Mouse_Ears",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":true,
		"Has_DynBones":true,
		"Data":[],
		"DynBone_Data":{
			"DynBone_Sets":{
				"Mouse_Ear_L":["Ear_L"],
				"Mouse_Ear_R":["Ear_R"]
			},
			"DynBone_Settings":{
				"Mouse_Ear_L":{
					"osc_ps":19,
					"dampening": .1,
					"damp_time":.5,
					"extension_damp_time":.3,
				},
				"Mouse_Ear_R":{
					"osc_ps":19,
					"dampening": .1,
					"damp_time":.5,
					"extension_damp_time":.3,
				}
			}
		}
	},
	"Ears/Alien":{
		"Name": "Alien",
		"Mesh_Node":"Alien_Ear_Armature/Skeleton3D/Alien_Ears",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":true,
		"Has_DynBones":true,
		"Data":[],
		"DynBone_Data":{
			"DynBone_Sets":{
				"Alien_Ear_L":["Ear_L","Ear_L.001"],
				"Alien_Ear_R":["Ear_R","Ear_R.001"]
			},
			"DynBone_Settings":{
				"Alien_Ear_L":{
					"osc_ps":19,
					"dampening": .1,
					"damp_time":.5,
					"extension_damp_time":.3,
				},
				"Alien_Ear_R":{
					"osc_ps":19,
					"dampening": .1,
					"damp_time":.5,
					"extension_damp_time":.3,
				}
			}
		}
	},
	"Ears/Deer":{
		"Name": "Deer",
		"Mesh_Node":"Deer_Ear_Armature/Skeleton3D/Deer_Ears",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":true,
		"Has_DynBones":true,
		"Data":[],
		"DynBone_Data":{
			"DynBone_Sets":{
				"Deer_Ear_L":["Ear_L"],
				"Deer_Ear_R":["Ear_R"]
			},
			"DynBone_Settings":{
				"Deer_Ear_L":{
					"osc_ps":19,
					"dampening": .1,
					"damp_time":.5,
					"extension_damp_time":.3,
				},
				"Deer_Ear_R":{
					"osc_ps":19,
					"dampening": .1,
					"damp_time":.5,
					"extension_damp_time":.3,
				}
			}
		}
	},
	"Ears/Entity":{
		"Name": "Entity",
		"Mesh_Node":"Entity_Ear_Armature/Skeleton3D/Entity_Ears",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":true,
		"Has_DynBones":true,
		"Data":[],
		"DynBone_Data":{
			"DynBone_Sets":{
				"Entity_Ear_L":["Ear_L"],
				"Entity_Ear_R":["Ear_R"]
			},
			"DynBone_Settings":{
				"Entity_Ear_L":{
					"osc_ps":19,
					"dampening": .1,
					"damp_time":.5,
					"extension_damp_time":.3,
				},
				"Entity_Ear_R":{
					"osc_ps":19,
					"dampening": .1,
					"damp_time":.5,
					"extension_damp_time":.3,
				}
			}
		}
	},
	"Ears/Dog":{
		"Name": "Dog",
		"Mesh_Node":"Dog_Ear_Armature/Skeleton3D/Dog_Ears",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":true,
		"Has_DynBones":true,
		"Data":[],
		"DynBone_Data":{
			"DynBone_Sets":{
				"Dog_Ear_L":["Ear_L","Ear_L.001","Ear_L.002"],
				"Dog_Ear_R":["Ear_R","Ear_R.001","Ear_R.002"]
			},
			"DynBone_Settings":{
				"Dog_Ear_L":{
					"osc_ps":19,
					"dampening": .1,
					"damp_time":.5,
					"extension_damp_time":.3,
				},
				"Dog_Ear_R":{
					"osc_ps":19,
					"dampening": .1,
					"damp_time":.5,
					"extension_damp_time":.3,
				}
			}
		}
	},
	"Ears/Bunny":{
		"Name": "Bunny",
		"Mesh_Node":"Bunny_Ear_Armature/Skeleton3D/Bunny_Ears",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":true,
		"Has_DynBones":true,
		"Data":[],
		"DynBone_Data":{
			"DynBone_Sets":{
				"Bunny_Ear_L":["Ear_L","Ear_L.001","Ear_L.002"],
				"Bunny_Ear_R":["Ear_R","Ear_R.001","Ear_R.002"]
			},
			"DynBone_Settings":{
				"Bunny_Ear_L":{
					"osc_ps":19,
					"dampening": .1,
					"damp_time":.5,
					"extension_damp_time":.3,
				},
				"Bunny_Ear_R":{
					"osc_ps":19,
					"dampening": .1,
					"damp_time":.5,
					"extension_damp_time":.3,
				}
			}
		}
	},
	"Ears/Fluffy":{
		"Name": "Fluffy",
		"Mesh_Node":"Fluffy_Ear_Armature/Skeleton3D/Fluffy_Ears",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":true,
		"Has_DynBones":true,
		"Data":[],
		"DynBone_Data":{
			"DynBone_Sets":{
				"Fluffy_Ear_L":["Ear_L"],
				"Fluffy_Ear_R":["Ear_R"]
			},
			"DynBone_Settings":{
				"Fluffy_Ear_L":{
					"osc_ps":19,
					"dampening": .1,
					"damp_time":.5,
					"extension_damp_time":.3,
				},
				"Fluffy_Ear_R":{
					"osc_ps":19,
					"dampening": .1,
					"damp_time":.5,
					"extension_damp_time":.3,
				}
			}
		}
	},
	##Extra
	"Extra/Shark":{
		"Name": "Shark",
		"Mesh_Node":"Armature/Skeleton3D/Shark_Extra",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":false,
		"Has_DynBones":false,
		"Data":[],
	},
	"Extra/Nub":{
		"Name": "Nub",
		"Mesh_Node":"Armature/Skeleton3D/Nub_Extra",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":false,
		"Has_DynBones":false,
		"Data":[],
	},
	"Extra/Antler":{
		"Name": "Antler",
		"Mesh_Node":"Armature/Skeleton3D/Antler_Extra",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":false,
		"Has_DynBones":false,
		"Data":[],
	},
	"Extra/Ram":{
		"Name": "Ram",
		"Mesh_Node":"Armature/Skeleton3D/Ram_Extra",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":false,
		"Has_DynBones":false,
		"Data":[],
	},
	"Extra/Fish":{
		"Name": "Fish",
		"Mesh_Node":"Armature/Skeleton3D/Fish_Extra",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":false,
		"Has_DynBones":false,
		"Data":[],
	},
	"Extra/Narwhal":{
		"Name": "Narwhal",
		"Mesh_Node":"Armature/Skeleton3D/Narwhal_Extra",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":false,
		"Has_DynBones":false,
		"Data":[],
	},
	"Extra/Dragon":{
		"Name": "Dragon",
		"Mesh_Node":"Armature/Skeleton3D/Dragon_Extra",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":false,
		"Has_DynBones":false,
		"Data":[],
	},
	##Wings
	"Wings/Entity":{
		"Name": "Entity",
		"Mesh_Node":"Entity_Wings_Armature/Skeleton3D/Entity_Wings",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":true,
		"Has_DynBones":false,
		"Data":[],
	},
	"Wings/Angel":{
		"Name": "Angel",
		"Mesh_Node":"Angel_Wings_Armature/Skeleton3D/Angel_Wings",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":true,
		"Has_DynBones":false,
		"Data":[],
	},
	"Wings/Butterfly":{
		"Name": "Butterfly",
		"Mesh_Node":"Butterfly_Wings_Armature/Skeleton3D/Butterfly_Wings",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":true,
		"Has_DynBones":false,
		"Data":[],
	},
	"Wings/Wasp":{
		"Name": "Wasp",
		"Mesh_Node":"Wasp_Wings_Armature/Skeleton3D/Wasp_Wings",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":true,
		"Has_DynBones":false,
		"Data":[],
	},
	"Wings/Dragon":{
		"Name": "Dragon",
		"Mesh_Node":"Dragon_Wings_Armature/Skeleton3D/Dragon_Wings",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":true,
		"Has_DynBones":false,
		"Data":[],
	},
	##Tail
	"Tails/Cat":{
		"Name": "Cat",
		"Mesh_Node":"Cat_Tail_Armature/Skeleton3D/Cat_Tail",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":true,
		"Has_DynBones":true,
		"Data":[],
		"DynBone_Data":{
			"DynBone_Sets":{
				"Cat_Tail":["Tail","Tail.001","Tail.002"]
			},
			"DynBone_Settings":{
				"Cat_Tail":{
					"osc_ps":18,
					"dampening": .1,
					"damp_time":.1,
					"extension_damp_time":.2,
				}
			}
		}
	},
	"Tails/Fox":{
		"Name": "Fox",
		"Mesh_Node":"Fox_Tail_Armature/Skeleton3D/Fox_Tail",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":true,
		"Has_DynBones":true,
		"Data":[],
		"DynBone_Data":{
			"DynBone_Sets":{
				"Fox_Tail":["Tail","Tail.001","Tail.002","Tail.003","Tail.004","Tail.005"]
			},
			"DynBone_Settings":{
				"Fox_Tail":{
					"osc_ps":18,
					"dampening": .1,
					"damp_time":.1,
					"extension_damp_time":.2,
				}
			}
		}
	},
	"Tails/Wolf":{
		"Name": "Wolf",
		"Mesh_Node":"Wolf_Tail_Armature/Skeleton3D/Wolf_Tail",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":true,
		"Has_DynBones":true,
		"Data":[],
		"DynBone_Data":{
			"DynBone_Sets":{
				"Wolf_Tail":["Tail","Tail.001","Tail.002","Tail.003","Tail.004","Tail.005"]
			},
			"DynBone_Settings":{
				"Wolf_Tail":{
					"osc_ps":18,
					"dampening": .1,
					"damp_time":.1,
					"extension_damp_time":.2,
				}
			}
		}
	},
	"Tails/Bug":{
		"Name": "Bug",
		"Mesh_Node":"Bug_Tail_Armature/Skeleton3D/Bug_Tail",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":true,
		"Has_DynBones":true,
		"Data":[],
		"DynBone_Data":{
			"DynBone_Sets":{
				"Bug_Tail":["Tail","Tail.001","Tail.002","Tail.003"]
			},
			"DynBone_Settings":{
				"Bug_Tail":{
					"osc_ps":20,
					"dampening": .3,
					"damp_time":.8,
					"extension_damp_time":.33,
				}
			}
		}
	},
	"Tails/Bee":{
		"Name": "Bee",
		"Mesh_Node":"Bee_Tail_Armature/Skeleton3D/Bee_Tail",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":true,
		"Has_DynBones":true,
		"Data":[],
		"DynBone_Data":{
			"DynBone_Sets":{
				"Bee_Tail":["Tail","Tail.001","Tail.002","Tail.003","Tail.004"]
			},
			"DynBone_Settings":{
				"Bee_Tail":{
					"osc_ps":29,
					"dampening": .3,
					"damp_time":.8,
					"extension_damp_time":.33,
				}
			}
		}
	},
	"Tails/Moth":{
		"Name": "Moth",
		"Mesh_Node":"Moth_Tail_Armature/Skeleton3D/Moth_Tail",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":true,
		"Has_DynBones":true,
		"Data":[],
		"DynBone_Data":{
			"DynBone_Sets":{
				"Moth_Tail":["Tail","Tail.001","Tail.002","Tail.003","Tail.004","Tail.005","Tail.006"]
			},
			"DynBone_Settings":{
				"Moth_Tail":{
					"osc_ps":27,
					"dampening": .3,
					"damp_time":.7,
					"extension_damp_time":.3,
				}
			}
		}
	},
	"Tails/Dog":{
		"Name": "Dog",
		"Mesh_Node":"Dog_Tail_Armature/Skeleton3D/Dog_Tail",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":true,
		"Has_DynBones":true,
		"Data":[],
		"DynBone_Data":{
			"DynBone_Sets":{
				"Dog_Tail":["Tail","Tail.001","Tail.002","Tail.003","Tail.004","Tail.005","Tail.006"]
			},
			"DynBone_Settings":{
				"Dog_Tail":{
					"osc_ps":20,
					"dampening": .3,
					"damp_time":.7,
					"extension_damp_time":.35,
				}
			}
		}
	},
	"Tails/Mouse":{
		"Name": "Mouse",
		"Mesh_Node":"Mouse_Tail_Armature/Skeleton3D/Mouse_Tail",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":true,
		"Has_DynBones":true,
		"Data":[],
		"DynBone_Data":{
			"DynBone_Sets":{
				"Mouse_Tail":["Tail","Tail.001","Tail.002"]
			},
			"DynBone_Settings":{
				"Mouse_Tail":{
					"osc_ps":20,
					"dampening": .3,
					"damp_time":.7,
					"extension_damp_time":.35,
				}
			}
		}
	},
	"Tails/Fluffy":{
		"Name": "Fluffy",
		"Mesh_Node":"Fluffy_Tail_Armature/Skeleton3D/Fluffy_Tail",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":true,
		"Has_DynBones":true,
		"Data":[],
		"DynBone_Data":{
			"DynBone_Sets":{
				"Fluffy_Tail":["Tail","Tail.001","Tail.002","Tail.003","Tail.004","Tail.005"]
			},
			"DynBone_Settings":{
				"Fluffy_Tail":{
					"osc_ps":18,
					"dampening": .1,
					"damp_time":.1,
					"extension_damp_time":.2,
				}
			}
		}
	},
	"Tails/Shark":{
		"Name": "Shark",
		"Mesh_Node":"Shark_Tail_Armature/Skeleton3D/Shark_Tail",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":true,
		"Has_DynBones":true,
		"Data":[],
		"DynBone_Data":{
			"DynBone_Sets":{
				"Shark_Tail":["Tail","Tail.001","Tail.002"]
			},
			"DynBone_Settings":{
				"Shark_Tail":{
					"osc_ps":26,
					"dampening": .3,
					"damp_time":.8,
					"extension_damp_time":.28,
				}
			}
		}
	},
	"Tails/Entity":{
		"Name": "Entity",
		"Mesh_Node":"Entity_Tail_Armature/Skeleton3D/Entity_Tail",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":true,
		"Has_DynBones":true,
		"Data":[],
		"DynBone_Data":{
			"DynBone_Sets":{
				"Entity_Tail":["Tail","Tail.001"]
			},
			"DynBone_Settings":{
				"Entity_Tail":{
					"osc_ps":26,
					"dampening": .3,
					"damp_time":.8,
					"extension_damp_time":.28,
				}
			}
		}
	},
	"Tails/Bunny":{
		"Name": "Bunny",
		"Mesh_Node":"Bunny_Tail_Armature/Skeleton3D/Bunny_Tail",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":true,
		"Has_DynBones":true,
		"Data":[],
		"DynBone_Data":{
			"DynBone_Sets":{
				"Bunny_Tail":["Tail","Tail.001"]
			},
			"DynBone_Settings":{
				"Bunny_Tail":{
					"osc_ps":26,
					"dampening": .3,
					"damp_time":.8,
					"extension_damp_time":.28,
				}
			}
		}
	},
	"Tails/Deer":{
		"Name": "Deer",
		"Mesh_Node":"Deer_Tail_Armature/Skeleton3D/Deer_Tail",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":true,
		"Has_DynBones":true,
		"Data":[],
		"DynBone_Data":{
			"DynBone_Sets":{
				"Deer_Tail":["Tail","Tail.001","Tail.002","Tail.003","Tail.004"]
			},
			"DynBone_Settings":{
				"Deer_Tail":{
					"osc_ps":20,
					"dampening": .3,
					"damp_time":.7,
					"extension_damp_time":.35,
				}
			}
		}
	},
	"Tails/Dragon":{
		"Name": "Dragon",
		"Mesh_Node":"Dragon_Tail_Armature/Skeleton3D/Dragon_Tail",
		"MaterialID":"User",
		"Has_Blendshapes":false,
		"Has_Bones":true,
		"Has_DynBones":true,
		"Data":[],
		"DynBone_Data":{
			"DynBone_Sets":{
				"Dragon_Tail":["Tail","Tail.001","Tail.002","Tail.003","Tail.004","Tail.005"]
			},
			"DynBone_Settings":{
				"Dragon_Tail":{
					"osc_ps":20,
					"dampening": .3,
					"damp_time":.7,
					"extension_damp_time":.35,
				}
			}
		}
	},
	##Head Clothes
	"Head_Clothes/Goggle_Test":{
		"Name": "Goggles",
		"Eye_Override":false,
		"Mesh_Node":"Armature/Skeleton3D/Cube_002",
		"MaterialID":"Goggle_Test_Mat",
		"Has_Blendshapes":true,
		"Has_Bones":false,
		"Has_DynBones":false,
		"Data":[],
		"BlendData":{},
	},
	"Head_Clothes/Orb_Test":{
		"Name": "Orb",
		"Eye_Override":false,
		"Mesh_Node":"Armature/Skeleton3D/Icosphere",
		"MaterialID":"Orb_Test_Mat",
		"Has_Blendshapes":false,
		"Has_Bones":true,
		"Has_DynBones":false,
		"Data":[],
		"BlendData":{},
	},
	"Head_Clothes/DotMouse_Hat":{
		"Name": "Dotmouse",
		"Eye_Override":false,
		"Mesh_Node":"Armature/Skeleton3D/DotMouseHat",
		"MaterialID":"DotMouse_Hat_Mat",
		"Has_Blendshapes":false,
		"Has_Bones":false,
		"Has_DynBones":false,
		"Data":[],
		"BlendData":{},
	},
	"Head_Clothes/Generic_Helmet":{
		"Name": "Helmet",
		"Eye_Override":true,
		"Mat_Overrides":{
			"Body1" : ["#5f5039","#000", 0, 1],
			"Body2" : ["#c5734c","#000", 0, 1],
			"Body3" : "Body3",
			"Body4" : "Body4",
			
		},
		"Mesh_Node":"Armature/Skeleton3D/Generic_Helmet",
		"MaterialID":"User_Custom_Head",
		"Has_Blendshapes":true,
		"Has_Bones":false,
		"Has_DynBones":false,
		"Data":[],
		"BlendData":{},
	},
	#Halloween Stuff
	"Head_Clothes/Pumpkin_Head_Cute_1":{
		"Name": "Pumpkin",
		"Eye_Override":false,
		"Override_Model":"Head_Clothes/Pumpkin_Head",
		"Mesh_Node":"Armature/Skeleton3D/Pumpkin",
		"MaterialID":"Pumpkin_Cute_1",
		"Has_Blendshapes":false,
		"Has_Bones":false,
		"Has_DynBones":false,
		"Data":[],
		"BlendData":{},
	},
	"Head_Clothes/Devil_Head":{
		"Name": "Devil",
		"Eye_Override":false,
		"Mesh_Node":"Armature/Skeleton3D/Devil",
		"MaterialID":"Devil_Cute_1",
		"Has_Blendshapes":false,
		"Has_Bones":false,
		"Has_DynBones":false,
		"Data":[],
		"BlendData":{},
	},
	"Head_Clothes/Witch_Head":{
		"Name": "Witch",
		"Eye_Override":false,
		"Mesh_Node":"Armature/Skeleton3D/Witch",
		"MaterialID":"Witch_Cute_1",
		"Has_Blendshapes":false,
		"Has_Bones":false,
		"Has_DynBones":false,
		"Data":[],
		"BlendData":{},
	},
	##Face Clothes
	"Face_Clothes/Nerd_Glasses":{
		"Name": "Nerd Glasses",
		"Eye_Override":true,
		"Mat_Base_Overrides":{
			"Body1" : ["#000000","#000", 0, 1],
			"Body2" : ["#000000","#000", 0, 1],
			"Body3" : "Body3",
			"Body4" : "Body4",
			
		},
		"Mesh_Node":"Armature/Skeleton3D/Nerd_Glasses",
		"MaterialID":"User_Custom_Face",
		"Has_Blendshapes":true,
		"Has_Bones":false,
		"Has_DynBones":false,
		"Data":[],
		"BlendData":{},
	},
	##Chest Clothes
	"Chest_Clothes/Trad_Pride_Bandanna":{
		"Name": "LGBT Band",
		"Override_Model":"Chest_Clothes/Pride_Bandana",
		"Mesh_Node":"Armature/Skeleton3D/Cube_001",
		"MaterialID":"Trad_Pride_Bandana_Mat",
		"Has_Blendshapes":false,
		"Has_Bones":false,
		"Has_DynBones":false,
		"Data":[],
		"BlendData":{},
	},
	"Chest_Clothes/Trans_Pride_Bandanna":{
		"Name": "Trans Band",
		"Override_Model":"Chest_Clothes/Pride_Bandana",
		"Mesh_Node":"Armature/Skeleton3D/Cube_001",
		"MaterialID":"Trans_Pride_Bandana_Mat",
		"Has_Blendshapes":false,
		"Has_Bones":false,
		"Has_DynBones":false,
		"Data":[],
		"BlendData":{},
	},
	##L_Hip Clothes
	"L_Hip/HipSkirt":{
		"Name": "Leaf Skirt",
		"Override_Model":"L_Hip/HipSkirt",
		"Mesh_Node":"HipSkirt/Skeleton3D/Hip_Skirt_L",
		"MaterialID":"Tropic_1",
		"Has_Blendshapes":false,
		"Has_Bones":false,
		"Has_DynBones":false,
		"Data":[],
		"BlendData":{},
	},
	##R_Hip Clothes
	"R_Hip/HipSkirt":{
		"Name": "Leaf Skirt",
		"Override_Model":"R_Hip/HipSkirt",
		"Mesh_Node":"HipSkirt/Skeleton3D/Hip_Skirt_R",
		"MaterialID":"Tropic_1",
		"Has_Blendshapes":false,
		"Has_Bones":false,
		"Has_DynBones":false,
		"Data":[],
		"BlendData":{},
	},
	##Back Clothes
	"Back_Clothes/Trad_Pride_Cape":{
		"Name": "LGBT Cape",
		"Override_Model":"Back_Clothes/Cape_1",
		"Mesh_Node":"Cape_Armature/Skeleton3D/Cape",
		"MaterialID":"Trad_Pride_Bandana_Mat",
		"Has_Blendshapes":false,
		"Has_Bones":true,
		"Has_DynBones":true,
		"Data":[],
		"DynBone_Data":{
			"DynBone_Sets":{
				"Trad_Pride_Cape":["Cape_2","Cape.001","Cape.002","Cape.003","Cape.004"]
			},
			"DynBone_Settings":{
				"Trad_Pride_Cape":{
					"osc_ps":10,
					"dampening": .1,
					"damp_time":.7,
					"extension_damp_time":.35,
				}
			}
		}
	},
	
	#Madness Stuff:
	"Face_Clothes/MC_Agent_Glasses":{
		"Name": "L33t Specs",
		"Eye_Override":true,
		"Mat_Base_Overrides":{
			"Body1" : ["#000000","#000", 0, 1],
			"Body2" : ["#000000","#000", 0, 1],
			"Body3" : "Body3",
			"Body4" : "Body4",
			
		},
		"Mat_Hard_Overrides":{
			"has_alpha":true,
			"Body1_alpha" : 1,
			"Body2_alpha" : 1,
			"Body3_alpha" : 0.5,
			"Body4_alpha" : 0.5,

		},
		"Mesh_Node":"Armature/Skeleton3D/Agent_Glasses",
		"MaterialID":"User_Custom_Face",
		"Has_Blendshapes":true,
		"Has_Bones":false,
		"Has_DynBones":false,
		"Data":[],
		"BlendData":{},
	},
	"Head_Clothes/MC_Deimos_Visor":{
		"Name": "De1m0s Hat",
		"Eye_Override":false,
		"Mesh_Node":"Armature/Skeleton3D/DeimosHat",
		"MaterialID":"MC_Deimos_Mat",
		"Has_Blendshapes":false,
		"Has_Bones":false,
		"Has_DynBones":false,
		"Data":[],
		"BlendData":{},
	},
	
	
}


var Material_Data_Assets = {
	"Goggle_Test_Mat":load("res://Assets/Materials/Characters/Accessories/Goggle_Test_Mat.tres"),
	"DotMouse_Hat_Mat":load("res://Assets/Materials/Characters/Accessories/DotMouse_Hat_Mat.tres"),
	"Trad_Pride_Bandana_Mat":load("res://Assets/Materials/Characters/Accessories/Trad_Pride_Bandana_Mat.tres"),
	"Trans_Pride_Bandana_Mat":load("res://Assets/Materials/Characters/Accessories/Trans_Pride_Bandana_Mat.tres"),
	"Medieval_Mat":load("res://Assets/Materials/Characters/Accessories/Medieval_Shader_Material.tres"),
	#Halloween Stuff
	"Pumpkin_Cute_1":load("res://Assets/Materials/Characters/Accessories/Pumpkin_Cute_1_Mat.tres"),
	"Devil_Cute_1":load("res://Assets/Materials/Characters/Accessories/Devil_Cute_1_Mat.tres"),
	"Witch_Cute_1":load("res://Assets/Materials/Characters/Accessories/Witch_Cute_1_Mat.tres"),
	"Tropic_1":load("res://Assets/Materials/Characters/Accessories/Tropic_Shader_Material.tres"),
	"MC_Deimos_Mat":load("res://Assets/Materials/Characters/Accessories/Deimos_Shader_Material.tres")
}
#--
var Cubiix_Model = load("res://Assets/Scenes/Client/Characters/cubiix_model.tscn").instantiate()
#--
var Eye_Slot = [
	"Eyes/Default",
	"Eyes/Chonk",
	"Eyes/Tri",
	"Eyes/Nat",
	"Eyes/Circle",
	"Eyes/Fox",
	"Eyes/Four",
	"Eyes/Entity",
	"Eyes/Text",
	"Eyes/Mouse"
	]
var Ear_Slot = [
	"",
	"Ears/Cat",
	"Ears/Fox",
	"Ears/Wolf",
	"Ears/Goat",
	"Ears/Bee", 
	"Ears/Moth",
	"Ears/Mouse",
	"Ears/Alien", 
	"Ears/Deer", 
	"Ears/Entity", 
	"Ears/Dog", 
	"Ears/Bunny", 
	"Ears/Fluffy"
	]
var Extra_Slot = [
	"",
	"Extra/Shark",
	"Extra/Nub",
	"Extra/Antler",
	"Extra/Ram",
	"Extra/Fish",
	"Extra/Narwhal",
	"Extra/Dragon"
	]
var Tail_Slot = [
	"",
	"Tails/Cat",
	"Tails/Fox",
	"Tails/Wolf",
	"Tails/Bug",
	"Tails/Bee",
	"Tails/Moth",
	"Tails/Dog",
	"Tails/Mouse",
	"Tails/Fluffy",
	"Tails/Shark",
	"Tails/Entity",
	"Tails/Bunny",
	"Tails/Deer",
	"Tails/Dragon"
	]
var Wing_Slot = [
	"",
	"Wings/Entity",
	"Wings/Angel",
	"Wings/Butterfly",
	"Wings/Wasp",
	"Wings/Dragon"
	]
#--
var Head_Slot = [
	"",
	#"Head_Clothes/Goggle_Test",
	#"Head_Clothes/Orb_Test",
	"Head_Clothes/DotMouse_Hat",
	#Halloween Stuff
	"Head_Clothes/Pumpkin_Head_Cute_1",
	"Head_Clothes/Devil_Head",
	"Head_Clothes/Witch_Head",
	"Head_Clothes/Generic_Helmet",
	"Head_Clothes/MC_Deimos_Visor",]
var Face_Slot = [
	"",
	"Face_Clothes/Nerd_Glasses",
	"Face_Clothes/MC_Agent_Glasses"]
var Chest_Slot = [
	"",
	"Chest_Clothes/Trad_Pride_Bandanna",
	"Chest_Clothes/Trans_Pride_Bandanna"
	]
var Back_Slot = [
	"",
	"Back_Clothes/Trad_Pride_Cape"]
var L_Hip_Slot = [
	"","L_Hip/HipSkirt"]
var R_Hip_Slot = [
	"","R_Hip/HipSkirt"]
var L_Hand_Slot = [
	"",]
var R_Hand_Slot = [
	"",]
#--

var Item_Data_Assets ={
	"Hexii_Device":{
		"path" : load("res://Assets/Scenes/Client/Items/hexii_device.tscn").instantiate(),
		"attachpoint":"Hand_R"
	},
	"Tech_Sword":{
		"path" : load("res://Assets/Scenes/Client/Items/tech_sword.tscn").instantiate(),
		"attachpoint":"Hand_R"
	}
}

var MeshRenderQueue = []
var MeshGenThread = Thread.new()
var MeshGenSemaphore = Semaphore.new()
signal Finished_Mesh
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

func add_to_mesh_queue(MeshList:Array,Materials:Array,TargetMesh:MeshInstance3D, TargetSkeleton:Skeleton3D = null, MainNode:Node = null):
	MeshRenderQueue.append([MeshList,Materials,TargetMesh,TargetSkeleton, MainNode])

func thread_force_post():
	MeshGenSemaphore.post()

func _ready() -> void:
	MeshGenThread.start(gen_thread_run)
	thread_force_post()

func gen_thread_run():
	while true:
		MeshGenSemaphore.wait()
		if Core.Globals.KillThreads:
			break
		
		var Queue = MeshRenderQueue.pop_front()
		if Queue != null:
			merge_meshes(Queue[0],Queue[1],Queue[2],Queue[3],Queue[4])
		else:
			thread_force_post()
		
	print("Killing Mesh Thread!")
	
func _exit_tree() -> void:
	MeshGenThread.wait_to_finish()
	
func register_meshlist(MeshList:Array, OverrideMaterials:Dictionary, node:Node3D) -> Dictionary:
	#Here we're going to sort the meshes we would like to use!
	var unCompiledMeshList = []
	var unCompiledMeshListKey = []
	var EyeOverride = false
	
	for i in MeshList:
		if i != "":
			if Mesh_Data_Assets[i].has("Eye_Override"):
				if Mesh_Data_Assets[i]["Eye_Override"]:
					EyeOverride = true
					
	if EyeOverride:
		for i in MeshList:
			if i.begins_with("Eyes"):
				MeshList.erase(i)
	
	##Here we sort based on the material
	for i in MeshList:
		if i != "":
			if !unCompiledMeshListKey.has(Mesh_Data_Assets[i]["MaterialID"]):
				unCompiledMeshListKey.append(Mesh_Data_Assets[i]["MaterialID"])
				unCompiledMeshList.append([i])
			else:
				unCompiledMeshList[unCompiledMeshListKey.find(Mesh_Data_Assets[i]["MaterialID"])].append(i)
	
	for i in MeshList:
		if i != "":
			var materialID = Mesh_Data_Assets[i]["MaterialID"]
			if Mesh_Data_Assets[i].has("Mat_Base_Overrides"):
				for x in Mesh_Data_Assets[i]["Mat_Base_Overrides"].keys():
					print(x)
					match typeof(Mesh_Data_Assets[i]["Mat_Base_Overrides"][x]):
						TYPE_ARRAY:
							node.custom_locks[materialID][1][x] = ""
							OverrideMaterials[materialID].set("shader_parameter/"+x, Color(Mesh_Data_Assets[i]["Mat_Base_Overrides"][x][0]))
							OverrideMaterials[materialID].set("shader_parameter/"+"emiss_"+x, Color(Mesh_Data_Assets[i]["Mat_Base_Overrides"][x][1]))
							OverrideMaterials[materialID].set("shader_parameter/"+x+"_metallic", Mesh_Data_Assets[i]["Mat_Base_Overrides"][x][2])
							OverrideMaterials[materialID].set("shader_parameter/"+x+"_roughness", Mesh_Data_Assets[i]["Mat_Base_Overrides"][x][3])
						TYPE_STRING:
							if OverrideMaterials.has("User"):
								node.custom_locks[materialID][1][x] = Mesh_Data_Assets[i]["Mat_Base_Overrides"][x]
								OverrideMaterials[materialID].set("shader_parameter/"+x, OverrideMaterials["User"].get("shader_parameter/"+Mesh_Data_Assets[i]["Mat_Base_Overrides"][x]))
								OverrideMaterials[materialID].set("shader_parameter/"+"emiss_"+x, OverrideMaterials["User"].get("shader_parameter/"+"emiss_"+Mesh_Data_Assets[i]["Mat_Base_Overrides"][x]))
								OverrideMaterials[materialID].set("shader_parameter/"+x+"_metallic", OverrideMaterials["User"].get("shader_parameter/"+Mesh_Data_Assets[i]["Mat_Base_Overrides"][x]+"_metallic"))
								OverrideMaterials[materialID].set("shader_parameter/"+x+"_roughness",  OverrideMaterials["User"].get("shader_parameter/"+Mesh_Data_Assets[i]["Mat_Base_Overrides"][x]+"_roughness"))
			else:
				if node.custom_locks.has(materialID):
					for x in node.custom_locks[materialID][1].keys():
						node.custom_locks[materialID][1][x] = ""
		
			if Mesh_Data_Assets[i].has("Mat_Hard_Overrides"):
				for x in Mesh_Data_Assets[i]["Mat_Hard_Overrides"].keys():
					if x == "has_alpha":
						OverrideMaterials[materialID].render_priority = 100
					OverrideMaterials[materialID].set("shader_parameter/"+x, Mesh_Data_Assets[i]["Mat_Hard_Overrides"][x])
				
	##Generate the framework
	var CompiledMeshList = {
		"MeshList":unCompiledMeshList,
		"MaterialList":[]
	}
	
	##Merge our arrays and materials for mesh compilation
	for i in unCompiledMeshListKey:
		if OverrideMaterials.has(i):
			CompiledMeshList["MaterialList"].append(OverrideMaterials[i])
		else:
			CompiledMeshList["MaterialList"].append(Material_Data_Assets[i])
	
	return CompiledMeshList

func merge_meshes(MeshList:Array,Materials:Array,TargetMesh:MeshInstance3D, TargetSkeleton:Skeleton3D = null, MainNode:Node = null) -> void:
	##Initial Setup of Meshes
	#print("Generating New Mesh.", MeshList)
	var Final_Mesh : ArrayMesh = ArrayMesh.new()
	var TargetSkin : Skin = TargetMesh.skin.duplicate(true)
	##Blendshape Key:
	var Blendshape_Key : Array = []
	var Replace_Bone_Key : Dictionary = {}
	var DynBoneList : Dictionary  = {}
	var Compiled_AABB : AABB = AABB()
	##Loops to add blendshapes and bones ahead of time
	for MeshSubList in MeshList:
		var Meshes = []
		var DynBones = {}
		for i in MeshSubList.size():
			Replace_Bone_Key[MeshSubList[i]] = []
			if Mesh_Data_Assets[MeshSubList[i]].has("Override_Model"):
				Meshes.append(
					[
						 Model_Data_Assets[Mesh_Data_Assets[MeshSubList[i]]["Override_Model"]].get_node(Mesh_Data_Assets[MeshSubList[i]]["Mesh_Node"]),
					]
					)
			else:
				Meshes.append(
					[
						Model_Data_Assets[MeshSubList[i]].get_node(Mesh_Data_Assets[MeshSubList[i]]["Mesh_Node"]),
					]
					)

			##Add the blendshapes
			if Mesh_Data_Assets[MeshSubList[i]]["Has_Blendshapes"]:
				for b in Meshes[i][0].mesh.get_blend_shape_count():
					
					Final_Mesh.call_deferred("add_blend_shape",Meshes[i][0].mesh.get_blend_shape_name(b))
					Blendshape_Key.append(Meshes[i][0].mesh.get_blend_shape_name(b))
			##Add Extra Bones As Needed
			if Mesh_Data_Assets[MeshSubList[i]]["Has_DynBones"]:
				DynBones = Mesh_Data_Assets[MeshSubList[i]]["DynBone_Data"]["DynBone_Sets"].duplicate(true)

			if Mesh_Data_Assets[MeshSubList[i]]["Has_Bones"] && TargetSkeleton != null:
				#print(MeshSubList[i])
				for b in Meshes[i][0].get_parent().get_bone_count():
					if TargetSkeleton.find_bone(Meshes[i][0].get_parent().get_bone_name(b)) == -1:
						##Add the New Bone
						var BoneName = Meshes[i][0].get_parent().get_bone_name(b)
						var Ms_Bone_Location = Meshes[i][0].get_parent().find_bone(BoneName)
						
						var Sk_Bone_Location = TargetSkeleton.add_bone(BoneName)
						var Sk_Bone_Parent = Meshes[i][0].get_parent().get_bone_name(Meshes[i][0].get_parent().get_bone_parent(Ms_Bone_Location))
						#print(Meshes[i][0].get_parent().get_bone_name(Meshes[i][0].get_parent().get_bone_parent(Ms_Bone_Location)))
						var Sk_Bone_Parent_Location = TargetSkeleton.find_bone(Sk_Bone_Parent)
						TargetSkeleton.call_deferred("set_bone_parent",Sk_Bone_Location,Sk_Bone_Parent_Location)
						TargetSkeleton.call_deferred("set_bone_pose",Sk_Bone_Location,Meshes[i][0].get_parent().get_bone_rest(b))
						TargetSkeleton.call_deferred("set_bone_rest",Sk_Bone_Location,Meshes[i][0].get_parent().get_bone_rest(b))
						TargetSkin.call_deferred("add_named_bind",BoneName,Meshes[i][0].skin.get_bind_pose(b))
						Replace_Bone_Key[MeshSubList[i]].append([Ms_Bone_Location,Sk_Bone_Location])
						if Mesh_Data_Assets[MeshSubList[i]]["Has_DynBones"]:
							if MainNode != null:
								for x in DynBones.keys():
									for y in DynBones[x].size():
										if str(DynBones[x][y]) == BoneName:
											DynBones[x][y] = Sk_Bone_Location
								#if MainNode.DynBones_Register.has(MeshSubList[i]):
									##MainNode.DynBones_Register[MeshSubList[i]]["Bones"]
			if Mesh_Data_Assets[MeshSubList[i]]["Has_DynBones"]:
				DynBoneList[MeshSubList[i]] = DynBones
		Meshes = []
	if MainNode != null:
		MainNode.DynBones_Register = DynBoneList

	for MeshSubList in MeshList:
		var Meshes = []
		var CoreMesh_Commit = [PackedVector3Array(),PackedVector3Array(),PackedFloat32Array(),null,PackedVector2Array(),null,null,null,null,null,PackedInt32Array(),PackedFloat32Array(),PackedInt32Array()]
		var Bone_Rewrite = PackedInt32Array()
		var st = SurfaceTool.new()
		for i in MeshSubList.size():
			##Loops to add mesh + Surface Tool For Blending
			#if Mesh_Data_Assets[MeshSubList[i]]["Data"].is_empty():
			if Mesh_Data_Assets[MeshSubList[i]].has("Override_Model"):
				Meshes.append(
					[
						Model_Data_Assets[Mesh_Data_Assets[MeshSubList[i]]["Override_Model"]].get_node(Mesh_Data_Assets[MeshSubList[i]]["Mesh_Node"]).mesh,
						SurfaceTool.new()
					]
					)
			else:
				Meshes.append(
					[
						Model_Data_Assets[MeshSubList[i]].get_node(Mesh_Data_Assets[MeshSubList[i]]["Mesh_Node"]).mesh,
						SurfaceTool.new()
					]
					)
			Meshes[i][1].append_from(Meshes[i][0],0,Transform3D())
			Meshes[i][1] = Meshes[i][1].commit_to_arrays()
			Mesh_Data_Assets[MeshSubList[i]]["Data"] = Meshes[i][1]
			#else:
				#if Mesh_Data_Assets[MeshSubList[i]].has("Override_Model"):
					#Meshes.append(
						#[
							#Mesh_Data_Assets[MeshSubList[i]]["Override_Model"].get_node(Mesh_Data_Assets[MeshSubList[i]]["Mesh_Node"]).mesh,
							#Mesh_Data_Assets[MeshSubList[i]]["Data"]
						#]
						#)
				#else:
					#Meshes.append(
						#[
							#Model_Data_Assets[MeshSubList[i]].get_node(Mesh_Data_Assets[MeshSubList[i]]["Mesh_Node"]).mesh,
							#Mesh_Data_Assets[MeshSubList[i]]["Data"]
						#]
						#)
			##Clean Up SurfaceTool

			var Mesh_Commit = Meshes[i][1]
			st.append_from(Meshes[i][0],0,Transform3D())

			Compiled_AABB = Meshes[i][0].get_aabb().merge(Compiled_AABB)
			###Adjust Bone Index
			var Key = Replace_Bone_Key[MeshSubList[i]]
			#print(Key)
			var IgnoreList = []
			if !Key.is_empty():
				for K in Key:
					for CC in Mesh_Commit[10].size():
						if Mesh_Commit[Mesh.ARRAY_BONES][CC] == K[0]:
							if !IgnoreList.has(CC):
								IgnoreList.append(CC)
								Mesh_Commit[Mesh.ARRAY_BONES][CC] = K[1]
#
			for x in CoreMesh_Commit.size():
				if x == 10:
					Bone_Rewrite.append_array(Mesh_Commit[x])
						
		CoreMesh_Commit = st.commit_to_arrays()
		CoreMesh_Commit[10] = Bone_Rewrite
		var Blendshapes = []
		Blendshapes.resize(Blendshape_Key.size())
		##Compile Blendshapes
		##Order For a Cubiix -Body -> Eyes -> Ears -> Extra -> Wings -> Tail -> Head Clothing -> Chest Clothing -> Back Clothing
		for i in MeshSubList.size():
			##Chreck For Blendshapes
			if Mesh_Data_Assets[MeshSubList[i]]["Has_Blendshapes"]:
				#print("Mesh: ",MeshSubList[i]," has Blendshapes")
				for b in Meshes[i][0].get_blend_shape_count():
					##Compile Blended Mesh
					var New_Blend_Array
					var Blend_Name = Meshes[i][0].get_blend_shape_name(b)
					

					var New_Blend_Array_Tool = SurfaceTool.new()
					New_Blend_Array_Tool.create_from_blend_shape(Meshes[i][0],0,Blend_Name)
					New_Blend_Array = New_Blend_Array_Tool.commit_to_arrays()
						

					var Blend_Array_Compiled = [New_Blend_Array[0],Meshes[i][1][1],Meshes[i][1][2]]
					##Remove the values to get raw changed value
					for x in Blend_Array_Compiled[0].size():
						Blend_Array_Compiled[0][x] -= Meshes[i][1][0][x]
					
					##This Will be our final blendshape array
					var Compiled_Blend_Array = [PackedVector3Array(),PackedVector3Array(),PackedFloat32Array()]
					
					for m in MeshSubList.size():
						if i == m:
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
					##Add the blendshape
					Blendshapes[Blendshape_Key.find(Meshes[i][0].get_blend_shape_name(b))] = Compiled_Blend_Array
					##Add the value to the final mesh
					
			#else:
				#pass
				##We dont need to do anything as it has no blendshapes!
				#print("Mesh: ",MeshSubList[i]," has no Blendshapes")
		
		##Build out blank blendshapes for additional blendshapes added in other surfaces
		for n in (Blendshapes.size()):
			var empty_blendshape = [PackedVector3Array(),PackedVector3Array(),PackedFloat32Array()]
			for m in MeshSubList.size():
				var newpackedVec3 = PackedVector3Array()
				newpackedVec3.resize(Meshes[m][1][0].size())

				empty_blendshape[0].append_array(newpackedVec3)
				empty_blendshape[1].append_array(Meshes[m][1][1])
				empty_blendshape[2].append_array(Meshes[m][1][2])
			if Blendshapes[n] == null:
				Blendshapes[n] = empty_blendshape
		##Build And Apply Mesh
		Final_Mesh.call_deferred("add_surface_from_arrays", Mesh.PRIMITIVE_TRIANGLES,CoreMesh_Commit,Blendshapes)
	
	TargetMesh.call_deferred("set_mesh",Final_Mesh)
	TargetMesh.call_deferred("set_skin",TargetSkin)
	#print(Compiled_AABB)
	TargetMesh.set_custom_aabb(Compiled_AABB)
	##Apply materials to mesh surfaces as required
	for i in Materials.size():
		TargetMesh.call_deferred("set_surface_override_material",i,Materials[i])
		
	MainNode.call_deferred("emit_signal","MeshFinished")
	thread_force_post()
