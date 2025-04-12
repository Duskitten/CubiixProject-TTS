extends Control
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

@onready var viewport:Viewport = get_viewport()

var is_in_zone = false
var dragging = false
var alt_drag_disable = false
var drag_offset:Vector2

var Temp_Character:Node3D

func _ready() -> void:
	Core.Globals.All_UI.append(get_parent())
	
	await get_tree().create_timer(1).timeout
	disable_connect(self)
	
	

func _process(delta: float) -> void:
	drag_manager()
	
func drag_manager() -> void:
	var mouse_position = viewport.get_mouse_position()
	var rect = get_rect()
	
	if rect.has_point(mouse_position):
		if !is_in_zone:
			Core.Globals.UI_Hovered.append(get_parent())
		is_in_zone = true
	else:
		if is_in_zone:
			is_in_zone = false
			Core.Globals.UI_Hovered.erase(get_parent())
			
	if Input.is_action_just_pressed("mouse_left") && is_in_zone && !alt_drag_disable:
		if Core.Globals.sort_ui() == get_parent():
			drag_offset = self.position - mouse_position 
			dragging = true
	if Input.is_action_pressed("mouse_left") && dragging :
		if (get_viewport_rect().grow_individual(-32,-32,-32,-32)).has_point(mouse_position):
			self.position = mouse_position + drag_offset
		
	if Input.is_action_just_released("mouse_left"):
		dragging = false


func disable_drag() -> void:
	#print("test")
	alt_drag_disable = true

func enable_drag() -> void:
	alt_drag_disable = false
	
func disable_input() -> void:
	Core.Globals.DisablePlayerInput = true
	
func enable_input() -> void:
	Core.Globals.DisablePlayerInput = false
	
func reset_focus(string:String) -> void:
	get_viewport().gui_release_focus()

func disable_connect(node:Node) -> void:
	for i in node.get_children():
		if i.get_child_count() > 0:
			disable_connect(i)
		if i is BaseButton || i is Slider || i is SubViewportContainer:
			i.mouse_entered.connect(disable_drag.bind())
			i.mouse_exited.connect(enable_drag.bind())
		elif i is LineEdit:
			i.mouse_entered.connect(disable_drag.bind())
			i.mouse_exited.connect(enable_drag.bind())
			i.focus_entered.connect(disable_input.bind())
			i.focus_exited.connect(enable_input.bind())
			i.text_submitted.connect(reset_focus.bind())
		elif i is ScrollContainer:
			i.get_h_scroll_bar().mouse_entered.connect(disable_drag.bind())
			i.get_h_scroll_bar().mouse_exited.connect(enable_drag.bind())
			i.get_v_scroll_bar().mouse_entered.connect(disable_drag.bind())
			i.get_v_scroll_bar().mouse_exited.connect(enable_drag.bind())
			i.mouse_entered.connect(disable_drag.bind())
			i.mouse_exited.connect(enable_drag.bind())
