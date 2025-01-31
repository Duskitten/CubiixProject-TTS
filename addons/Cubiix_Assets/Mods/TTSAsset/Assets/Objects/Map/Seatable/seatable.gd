extends Area3D

func _ready() -> void:
	body_entered.connect(_on_player_entered_seatarea)


func _on_player_entered_seatarea(body) -> void:
	pass
