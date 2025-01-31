extends Area3D


func _ready() -> void:
	body_entered.connect(_on_player_entered_loading_trigger)


func _on_player_entered_loading_trigger() -> void:
	pass
