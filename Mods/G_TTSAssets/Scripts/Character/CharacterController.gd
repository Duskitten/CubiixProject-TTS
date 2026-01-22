extends Node

var coreobj = null
var cubiixobj = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func setup(core:Node, cbxobj:Node3D):
	coreobj = core
	cubiixobj = cbxobj

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
