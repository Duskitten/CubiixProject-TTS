extends SubViewportContainer

var is_mouse_entered = false
var has_mouse = false
var Sensitivity:float = 2
var recordedpos:Vector2
var CameraZoom = 2
func _ready() -> void:
	mouse_entered.connect(_mouse_enter.bind())
	mouse_exited.connect(_mouse_exited.bind())
	
func _mouse_enter() -> void:
	is_mouse_entered = true
	
func _mouse_exited() -> void:
	is_mouse_entered = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("mouse_left") && is_mouse_entered:
		has_mouse = true
		
	if Input.is_action_just_released("mouse_left") && has_mouse:
		has_mouse = false
		
	$SubViewport/Character_Editor/Y/X/Z/Camera3D.position.z = lerpf($SubViewport/Character_Editor/Y/X/Z/Camera3D.position.z, CameraZoom, 0.2)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if has_mouse:
			get_node("SubViewport/Character_Editor/Rotator").rotation_degrees.y += event.relative.x/Sensitivity
	if is_mouse_entered :
			if Input.is_action_just_released("scroll_up"):
				CameraZoom -= 0.5
			elif  Input.is_action_just_released("scroll_down"):
				CameraZoom += 0.5
					
			CameraZoom = clampf(CameraZoom, 1.5,3.5)
