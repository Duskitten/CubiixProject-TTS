extends Label

var saved_time = [0,0]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if saved_time != [Time.get_datetime_dict_from_system()["hour"],Time.get_datetime_dict_from_system()["minute"]]:
		saved_time = [Time.get_datetime_dict_from_system()["hour"],Time.get_datetime_dict_from_system()["minute"]]
		text = "%02d:%02d" % [saved_time[0], saved_time[1]]
