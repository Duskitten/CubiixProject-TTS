extends CharacterBody3D

## We want an external script loader so that we can add custom resources over time, rather than lock it down
@export_file("*.gd") var Load_Script

## Due to the characters now being independant from the main script, we want to use this to load the actual character
@export var Character_String = ""

## These are space access, so we don't need to do 50 billion calls
@onready var Hub = $Hub
@onready var Assets = $Node3D

func _ready() -> void:
	if Load_Script != null:
		var NewNode = Node3D.new()
		NewNode.set_script(load(Load_Script))
		add_child(NewNode)
	await Assets.assets_loaded
