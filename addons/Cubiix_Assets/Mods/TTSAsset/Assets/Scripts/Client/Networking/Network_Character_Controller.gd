extends Node

var stored_value = {
	"Position":Vector3.ZERO,
	"Rotation":Vector3.ZERO,
	"Model_Rotation":Vector3.ZERO,
	"Current_Animation":"Idle"
}
var current_swim_particles:Node
var swim_pos

func update_character(value:Dictionary) -> void:
	stored_value = value

#func _process(delta:float) -> void:
	#if current_swim_particles != null:
		#current_swim_particles.global_position = get_parent().to_global(swim_pos)

func _physics_process(delta: float) -> void:
	get_parent().global_position = lerp(get_parent().global_position,stored_value["Position"],0.3)
	get_parent().global_rotation = Vector3(lerp_angle(get_parent().global_rotation.x,stored_value["Rotation"].x,0.3),lerp_angle(get_parent().global_rotation.y,stored_value["Rotation"].y,0.3),lerp_angle(get_parent().global_rotation.z,stored_value["Rotation"].z,0.3))
	get_parent().Hub.rotation = Vector3(lerp_angle(get_parent().Hub.rotation.x,stored_value["Model_Rotation"].x,0.3),lerp_angle(get_parent().Hub.rotation.y,stored_value["Model_Rotation"].y,0.3),lerp_angle(get_parent().Hub.rotation.z,stored_value["Model_Rotation"].z,0.3))
	#if stored_value["Current_Animation"] != get_parent().Hub.old_animation[0]:
		#if stored_value["Current_Animation"].begins_with("Swimming") && current_swim_particles == null:
			#var sploosh =  ResourceLoader.load("res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Objects/Client/Map/Water/sploosh.tscn","",ResourceLoader.CACHE_MODE_REPLACE).instantiate()
			#sploosh.get_node("AnimationPlayer").play("Sploosh")
			#get_parent().get_parent().get_parent().get_node("Effects").add_child(sploosh)
			#sploosh.global_position = get_parent().global_position
			#sploosh.global_rotation = stored_value["Rotation"]
			#var particles = ResourceLoader.load("res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Objects/Client/Map/Water/water_particles.tscn","",ResourceLoader.CACHE_MODE_REPLACE).instantiate()
			#get_parent().get_parent().get_parent().get_node("Effects").add_child(particles)
			#swim_pos = get_parent().to_local(get_parent().global_position) + Vector3(0,0.02,0)
			#particles.global_transform.basis = get_parent().global_transform.basis
			#current_swim_particles = particles
			#particles.emitting = true
		#else:
			#if current_swim_particles != null:
				#current_swim_particles.queue_free()
	#swim_pos = get_parent().global_position + Vector3(0,0.02,0)
	
	get_parent().Hub.update_animation([stored_value["Current_Animation"], 0.1])
