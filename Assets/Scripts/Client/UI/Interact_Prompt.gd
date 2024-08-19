extends Node3D
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
signal Interacted

@onready var CoreUI = $CanvasLayer
@onready var Marker = $Marker
var active = false

func _process(delta: float) -> void:
	if active:
		CoreUI.get_node("Panel").position = get_viewport().get_camera_3d().unproject_position(Marker.global_position) - (CoreUI.get_node("Panel").size/2)
		if Input.is_action_just_pressed("interact"):
			$CanvasLayer/AnimationPlayer.play("Close")
			emit_signal("Interacted")

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body == Core.Client.Local_Player:
		active = true
		$CanvasLayer/AnimationPlayer.stop(true)
		$CanvasLayer/AnimationPlayer.play("Open")
		set_process(true)


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body == Core.Client.Local_Player:
		$CanvasLayer/AnimationPlayer.stop(true)
		$CanvasLayer/AnimationPlayer.play("Close")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Close":
		active = false
		print("Done!")
		set_process(false)
