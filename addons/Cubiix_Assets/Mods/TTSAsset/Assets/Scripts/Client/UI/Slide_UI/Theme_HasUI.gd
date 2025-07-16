extends Control
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

@onready var top = $Panel2/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/Color
@onready var bottom = $Panel2/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer3/Color
@onready var Instructions = $Instruction_Panel
var nodes = []
var target = 0

var HasControl = false

func _ready() -> void:
	nodes = [top,bottom]
	
	var skymat = $Node3D.get_world_3d().environment.sky.sky_material
	skymat.sky_top_color = Color(Core.Globals.Data["Theme"]["Top"])
	skymat.sky_horizon_color = Color(Core.Globals.Data["Theme"]["Top"])
	skymat.ground_horizon_color = Color(Core.Globals.Data["Theme"]["Top"])
	skymat.ground_bottom_color = Color(Core.Globals.Data["Theme"]["Bottom"])
	top.get_theme_stylebox("panel").bg_color = skymat.sky_top_color
	bottom.get_theme_stylebox("panel").bg_color = skymat.ground_bottom_color
	target = 0
	
	
func _process(delta: float) -> void:
	if HasControl:
		if Input.is_action_just_pressed("dp_down"):
			if target + 1 < nodes.size():
				var targetNode = nodes[target].get_parent().get_node("Asset_Name")
				var tween = get_tree().create_tween()
				tween.set_parallel(true).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO)
				tween.tween_property(targetNode, "label_settings:font_size", 24, .2)
				tween.tween_property(targetNode, "label_settings:font_color", Color("969696"), .2)
				
				target += 1
				targetNode = nodes[target].get_parent().get_node("Asset_Name")
				tween.tween_property(targetNode, "label_settings:font_size", 32, .2)
				tween.tween_property(targetNode, "label_settings:font_color", Color("FFFFFF"), .2)
				#Instructions.global_position = targetNode.get_node("../Color").global_position + Vector2(0,70)
		if Input.is_action_just_pressed("dp_up"):
			if target - 1 >= 0:
				var targetNode = nodes[target].get_parent().get_node("Asset_Name")
				var tween = get_tree().create_tween()
				tween.set_parallel(true).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO)
				tween.tween_property(targetNode, "label_settings:font_size", 24, .2)
				tween.tween_property(targetNode, "label_settings:font_color", Color("969696"), .2)
				
				target -= 1
				targetNode = nodes[target].get_parent().get_node("Asset_Name")
				tween.tween_property(targetNode, "label_settings:font_size", 32, .2)
				tween.tween_property(targetNode, "label_settings:font_color", Color("FFFFFF"), .2)
				#Instructions.global_position = targetNode.get_node("../Color").global_position + Vector2(0,70)
		if Input.is_action_pressed("dp_left") || Input.is_action_pressed("dp_right"):
			var input =  int(Input.is_action_pressed("dp_left")) - int(Input.is_action_pressed("dp_right"))
			var stylebox = (nodes[target] as Panel).get_theme_stylebox("panel")
			var color = stylebox.bg_color
			color.h += input/500.0
			update_color(stylebox,color.clamp())
			
		if Input.is_action_pressed("dp_shoulder_l") || Input.is_action_pressed("dp_shoulder_r"):
			var input =  int(Input.is_action_pressed("dp_shoulder_l")) - int(Input.is_action_pressed("dp_shoulder_r"))
			var stylebox = (nodes[target] as Panel).get_theme_stylebox("panel")
			var color = stylebox.bg_color
			color.s += input/50.0
			update_color(stylebox,color.clamp())
		
		if Input.is_action_pressed("dp_tri") || Input.is_action_pressed("dp_x"):
			var input =  int(Input.is_action_pressed("dp_tri")) - int(Input.is_action_pressed("dp_x"))
			var stylebox = (nodes[target] as Panel).get_theme_stylebox("panel")
			var color = stylebox.bg_color
			color.v += input/50.0
			update_color(stylebox,color.clamp())
			

func update_color(stylebox,color:Color) -> void:
	var skymat = $Node3D.get_world_3d().environment.sky.sky_material
	stylebox.bg_color = color
	match target:
		0:
			skymat.sky_top_color = color
			skymat.sky_horizon_color = color
			skymat.ground_horizon_color = color
			Core.Globals.Data["Theme"]["Top"] =  color.to_html()
		1:
			skymat.ground_bottom_color = color
			Core.Globals.Data["Theme"]["Bottom"] =  color.to_html()
