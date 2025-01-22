extends DirectionalLight3D

var time_of_day = -90
var CurrentTick :int = 0
var Tick_Prev = 0
var Tick_Timer = 0
var Current_Tick = 0

func _process(delta: float) -> void:
	var Delta = Time.get_ticks_msec() - Tick_Prev
	Tick_Prev = Time.get_ticks_msec()
	Tick_Timer += Delta
	
	if Tick_Timer > 1000/20:
		print(time_of_day)
		Current_Tick += 1
		time_of_day += .02
		if time_of_day >= 180:
			time_of_day = -180
		Tick_Timer = 0
	
	if time_of_day >= -180 && time_of_day <= -90:
		print("A")
		$"../WorldEnvironment".environment.ambient_light_color = lerp($"../WorldEnvironment".environment.ambient_light_color,Color("#6e9fd9"), 0.05)
		$DirectionalLight3D.light_energy = lerp($DirectionalLight3D.light_energy,remap(time_of_day,-180,-90,0,2), 0.1)
	if time_of_day >= -90 && time_of_day <= 0:
		$"../WorldEnvironment".environment.ambient_light_color = lerp($"../WorldEnvironment".environment.ambient_light_color,Color("#6e9fd9"), 0.05)
		$DirectionalLight3D.light_energy = lerp($DirectionalLight3D.light_energy,remap(time_of_day,-90,0,2,0), 0.1)
	elif time_of_day > 0 && time_of_day < 180:
		$"../WorldEnvironment".environment.ambient_light_color = lerp($"../WorldEnvironment".environment.ambient_light_color,Color("#3d3d69"), 0.05)
		$DirectionalLight3D.light_energy = lerp($DirectionalLight3D.light_energy,remap(time_of_day,0,180,0,0), 0.1)
	
	self.rotation.x = lerp_angle(self.rotation.x,deg_to_rad(time_of_day),0.1)
