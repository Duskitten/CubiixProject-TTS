extends DirectionalLight3D
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
var time_of_day = -90
var CurrentTick :int = 0
var Tick_Prev = 0
var Tick_Timer = 0
var Current_Tick = 0
var SkyMaterial:ShaderMaterial
var TimeArray = [Color("#FFFFFF"),1.0, 1.0,Color("#059dff"),Color("#929ada")]
func _ready() -> void:
	SkyMaterial = $"../WorldEnvironment".environment.sky.sky_material

func _process(delta: float) -> void:
	var Delta = Time.get_ticks_msec() - Tick_Prev
	Tick_Prev = Time.get_ticks_msec()
	Tick_Timer += Delta
	
	if Tick_Timer > 1000/20:
		print(time_of_day)
		Current_Tick += 1
		time_of_day += 0.01
		if time_of_day >= 180:
			time_of_day = -180
		Tick_Timer = 0
	
	if time_of_day >= -180 && time_of_day <= 0:
		if Core.Globals.Data["Visuals"]["Shadow_Depth"] == -1:
			TimeArray = [Color("#FFFFFF"),1.0, 2.0,Color("#059dff"),Color("#929ada")]
		else:
			TimeArray = [Color("#FFFFFF"),1.0, .5,Color("#059dff"),Color("#929ada")]
		
		#SkyMaterial.set_shader_parameter("SkyDarkness",lerp(float(SkyMaterial.get_shader_parameter("SkyDarkness")),1.0,0.002))
	#	$"../WorldEnvironment".environment.ambient_light_color = lerp($"../WorldEnvironment".environment.ambient_light_color,Color("#6e9fd9"), 0.05)
		#$DirectionalLight3D.light_energy = lerp($DirectionalLight3D.light_energy,1.0, .002)
		#$DirectionalLight3D.light_color = lerp($DirectionalLight3D.light_color,Color("#ffffff"), 0.002)
	#elif time_of_day >= -90 && time_of_day <= 0:
		#SkyMaterial.set_shader_parameter("SkyDarkness",lerp(float(SkyMaterial.get_shader_parameter("SkyDarkness")),1.0,0.1))
	#	$"../WorldEnvironment".environment.ambient_light_color = lerp($"../WorldEnvironment".environment.ambient_light_color,Color("#6e9fd9"), 0.05)
		#$DirectionalLight3D.light_energy = lerp($DirectionalLight3D.light_energy,remap(time_of_day,-90,0,2,0), 0.1)
	elif time_of_day > 0 && time_of_day < 180:
		TimeArray = [Color("#00135a"),0.0, 0.4,Color("#2f0061"),Color("#887295")]
	SkyMaterial.set_shader_parameter("SkyDarkness",lerp(float(SkyMaterial.get_shader_parameter("SkyDarkness")),TimeArray[1],0.01))
	#	$"../WorldEnvironment".environment.ambient_light_color = lerp($"../WorldEnvironment".environment.ambient_light_color,Color("#3d3d69"), 0.05)
	$DirectionalLight3D.light_energy = lerp($DirectionalLight3D.light_energy,TimeArray[2], 0.01)
	$DirectionalLight3D.light_color = lerp($DirectionalLight3D.light_color,TimeArray[0], 0.01)
	$"../WorldEnvironment".environment.fog_light_color = lerp($"../WorldEnvironment".environment.fog_light_color,TimeArray[3], 0.01)
	$"../WorldEnvironment".environment.ambient_light_color = lerp($"../WorldEnvironment".environment.ambient_light_color,TimeArray[4], 0.01)
	#self.rotation.x = lerp_angle(self.rotation.x,deg_to_rad(time_of_day),0.1)
