extends Node

##Auto Scale Script
##Created by Duskitten
##

var portraitmode = false

var min = 400
var last = 0

func _ready() -> void:
	window_resized()
	get_tree().get_root().size_changed.connect(window_resized) 

func window_resized():
	var total = false
	var check_amt = 1
	
	var baseline
	
	if portraitmode:
		baseline = get_window().size.x
	else:
		baseline = get_window().size.y
	var last_res_core = baseline
	
	if !baseline % 2 == 0:
		last_res_core = baseline + 1
	
	#print(last_res_core)
	
	if last != last_res_core:
		while !total:
			if last_res_core/check_amt <= min:
				total = true
			else:
				check_amt += 1
		#print(check_amt)
		#print(last_res_core/check_amt)
		if last_res_core/check_amt < min: 
			if check_amt - 1 != 0:
				check_amt -= 1
				
		#print(check_amt)
		#print(last_res_core/check_amt)
		get_viewport().content_scale_factor = int(check_amt)
	last = last_res_core
