extends Area3D

@onready var Core = get_node("/root/Main_Scene/CoreLoader")

func _ready() -> void:
	body_entered.connect(_on_player_entered_loading_trigger)


func _on_player_entered_loading_trigger(body) -> void:
	if body.is_in_group("Player"):
		Core.SceneData.call_deferred("load_scene","TTSAssets/Hexstaria_V2",{},true,"Docks")
		set_deferred("Monitoring", false)
		#set_deferred("Monitoring", false)
