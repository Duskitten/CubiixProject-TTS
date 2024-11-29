extends Node3D

signal FinishedLoad
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	call_deferred("emit_signal","FinishedLoad")
