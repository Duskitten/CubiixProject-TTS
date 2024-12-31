extends Node
@onready var Character:CharacterBody3D = get_parent()

@onready var Hub:Node3D = Character.get_node("Hub")

func _ready() -> void:
	await Character.ScriptLoaded
	Hub.update_animation(["Idle",0.0])
