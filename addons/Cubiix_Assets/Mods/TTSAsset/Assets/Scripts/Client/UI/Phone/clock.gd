extends Label

var saved_time = [0,0]
var TwelveHR = true
var AMPM = "AM"
var Backuptime = 0

func _ready() -> void:
	var panel = get_node_or_null("../Panel")
	if panel != null:
		panel.hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if saved_time != [Time.get_datetime_dict_from_system()["hour"],Time.get_datetime_dict_from_system()["minute"]]:
		saved_time = [Time.get_datetime_dict_from_system()["hour"],Time.get_datetime_dict_from_system()["minute"]]
		if !TwelveHR:
			text = "%02d:%02d" % [saved_time[0], saved_time[1]]
		else:
			if saved_time[0] >= 12:
				AMPM = "PM"
			else:
				AMPM = "AM"
			
			if saved_time[0] == 0:
				Backuptime = 12
			else:
				Backuptime = saved_time[0]

			text = "%02d:%02d" % [Backuptime, saved_time[1]]
