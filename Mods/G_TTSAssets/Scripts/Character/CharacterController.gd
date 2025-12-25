extends Node

var cubiixcore = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cubiixcore = get_parent().get_parent()
	setup()

func setup() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
