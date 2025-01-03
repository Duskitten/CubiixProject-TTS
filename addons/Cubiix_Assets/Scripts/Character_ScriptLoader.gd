extends CharacterBody3D

## We want an external script loader so that we can add custom resources over time, rather than lock it down
@export var Load_Script_ID: Array[String]
@export var Load_Script_Passthrough: Array[Dictionary]

## Direct Path to our Assets/Modloading stuff.
@export var Animation_Path = ""
@export var Assets_Path = ""
var Assets

## Due to the characters now being independant from the main script, we want to use this to load the actual character
@export var Character_String = ""
@export var Accessory_String = ""

## These are space access, so we don't need to do 50 billion calls
@onready var Hub = $Hub


signal MeshFinished
signal Loaded
signal ScriptLoaded

func _ready() -> void:
	Assets = get_node(Assets_Path)
	print(Assets)
	emit_signal("Loaded")
	if !Load_Script_ID.is_empty():
		for i in Load_Script_ID:
			var NewNode = Node3D.new()
			Assets.find_script(i,NewNode,self)
			call_deferred("add_child",NewNode)
	if Animation_Path != "":
		Assets.find_animation(Animation_Path,$Hub)

	call_deferred("emit_signal","ScriptLoaded")
	Assets.Tools.generate_character_from_string(Character_String,Hub)
