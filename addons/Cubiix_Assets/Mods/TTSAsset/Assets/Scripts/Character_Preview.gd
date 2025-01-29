extends Node
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

@onready var Character:CharacterBody3D = get_parent()

@onready var Hub:Node3D = Character.get_node("Hub")

func _ready() -> void:
	await Character.ScriptLoaded
	Hub.update_animation(["Idle",0.0])
	
	Core.AssetData.Tools.clone_character_with_accessories(Core.Persistant_Core.Player.Hub,Hub)
