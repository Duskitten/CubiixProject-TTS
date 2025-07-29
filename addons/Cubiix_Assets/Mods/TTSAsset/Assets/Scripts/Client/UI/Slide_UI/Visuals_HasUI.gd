extends Control
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
@onready var ControllerID = find_parent("Slide_UI").ControllerID

var HasControl = false
@onready var shadow_depth = $Panel2/VBoxContainer/HBoxContainer/ScrollContainer/VBoxContainer/Shadow_Depth
@onready var anti_aliasing = $Panel2/VBoxContainer/HBoxContainer/ScrollContainer/VBoxContainer/Anti_Aliasing
@onready var bloom = $Panel2/VBoxContainer/HBoxContainer/ScrollContainer/VBoxContainer/Bloom
@onready var fov = $Panel2/VBoxContainer/HBoxContainer/ScrollContainer/VBoxContainer/FOV

#"Type", Current Value, Min, Max
var limits = [
	["Int",0,-1,4],
	["Int",0,0,3],
	["Bool",false,false,true],
	["Int",45,45,130]
]

var nodes = []
var target = 0



func _ready() -> void:
	nodes = [shadow_depth,anti_aliasing,bloom,fov]
	target = 0
	
	
func _process(delta: float) -> void:
	if HasControl:
		if Input.is_action_just_pressed("dp_down"):
			if target + 1 < nodes.size():
				var targetNode = nodes[target].get_node("Asset_Name")
				var tween = get_tree().create_tween()
				tween.set_parallel(true).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO)
				tween.tween_property(targetNode, "label_settings:font_size", 24, .2)
				tween.tween_property(targetNode, "label_settings:font_color", Color("969696"), .2)
				
				target += 1
				targetNode = nodes[target].get_node("Asset_Name")
				tween.tween_property(targetNode, "label_settings:font_size", 32, .2)
				tween.tween_property(targetNode, "label_settings:font_color", Color("FFFFFF"), .2)
				#Instructions.global_position = targetNode.get_node("../Color").global_position + Vector2(0,70)
		if Input.is_action_just_pressed("dp_up"):
			if target - 1 >= 0:
				var targetNode = nodes[target].get_node("Asset_Name")
				var tween = get_tree().create_tween()
				tween.set_parallel(true).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO)
				tween.tween_property(targetNode, "label_settings:font_size", 24, .2)
				tween.tween_property(targetNode, "label_settings:font_color", Color("969696"), .2)
				
				target -= 1
				targetNode = nodes[target].get_node("Asset_Name")
				tween.tween_property(targetNode, "label_settings:font_size", 32, .2)
				tween.tween_property(targetNode, "label_settings:font_color", Color("FFFFFF"), .2)
				#Instructions.global_position = targetNode.get_node("../Color").global_position + Vector2(0,70)
		if Input.is_action_pressed("dp_left") || Input.is_action_pressed("dp_right"):
			pass
