@tool
extends Node3D
# Called when the node enters the scene tree for the first time.
var cached_pos = Vector2.ZERO
var time = 0
var paused = false
var flipstopped = false
var basestopped = false
var YOffset = 0
var PauseTime = 0
var PauseLength = 2

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#cached_pos = Vector2(sin(Time.get_ticks_msec()/1000.0),max(cos(Time.get_ticks_msec()/1000.0),0))
	
	if !paused:
		time += delta
		if max(cos((time)),0) == 0 && !flipstopped:
			paused = true
			flipstopped = true
			basestopped = false
		elif max(cos((time)-PI),0) == 0 && !basestopped:
			paused = true
			flipstopped = false
			basestopped = true
	else:
		if PauseTime >= PauseLength:
			paused = false
			PauseTime = 0

		PauseTime += delta
		if basestopped:
			YOffset += delta
		elif flipstopped:
			YOffset -= delta

	
	$CSGBox3D.position.y = YOffset+cos(time)
	$CSGBox3D.position.x = sin(time)
	#$CSGBox3D2.position.y = max(cos((Time.get_ticks_msec()/1000.0)),0)
