@tool
extends Node3D
# Called when the node enters the scene tree for the first time.
#var TimeOffset = 3
#var time = 0.0
var YOffset = 0.0
#var Tick_Prev = 0
#var Tick_Timer = 0
#var Tick = 0
@export var radius = 2.0
@export var height = 2.0
@export var speed = .1
@export var kart_offset = 2.8
var time = 0.0
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# contants
	var halfCircleLength = PI * radius
	var totalTrackLength = halfCircleLength * 2 + height * 2
	# le loop
	time += delta * speed / totalTrackLength
	for i in get_child_count():
		var distance = fmod(((time - floor(time)) * totalTrackLength)+(totalTrackLength/get_child_count()*i), totalTrackLength)
		if distance < halfCircleLength:
			get_child(i).position.x = cos((distance/halfCircleLength)*PI)*radius
			get_child(i).position.y = sin((distance/halfCircleLength)*PI)*radius
		elif distance < halfCircleLength + height:
			get_child(i).position.y = -((distance - halfCircleLength))
			get_child(i).position.x = -radius
			
		elif distance < halfCircleLength + height + halfCircleLength:
			get_child(i).position.x = cos(((distance - (halfCircleLength+height)) / halfCircleLength)*PI+PI)*radius
			get_child(i).position.y = (sin(((distance - (halfCircleLength+height)) / halfCircleLength)*PI+PI)*radius)-height
		else:
			get_child(i).position.y = (distance - (halfCircleLength+height+halfCircleLength))-height
			get_child(i).position.x = radius
			
	
		
	
	
	#TickTime = floor(Time.get_ticks_msec()/1000) % (TimeOffset*2)
	
	#if TickTime > 0 && TickTime < TimeOffset:
		#YOffset += delta
		#print(TickTime)
	#elif TickTime > TimeOffset && TickTime < TimeOffset*2:
		#YOffset -= delta
		#print(TickTime)
	#else:
		#time += delta
		
	#cached_pos = Vector2(sin(Time.get_ticks_msec()/1000.0),max(cos(Time.get_ticks_msec()/1000.0),0))
	
	#if !paused:
		#time += delta
		#if max(cos((time)),0) == 0 && !flipstopped:
			#paused = true
			#flipstopped = true
			#basestopped = false
		#elif max(cos((time)-PI),0) == 0 && !basestopped:
			#paused = true
			#flipstopped = false
			#basestopped = true
	#else:
		#if PauseTime >= PauseLength:
			#paused = false
			#PauseTime = 0
#
		#PauseTime += delta
		#if basestopped:
			#YOffset += delta
		#elif flipstopped:
			#YOffset -= delta
	
	
	

	#$CSGBox3D2.position.y = max(cos((Time.get_ticks_msec()/1000.0)),0)
