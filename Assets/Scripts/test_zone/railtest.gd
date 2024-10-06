extends Node3D
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
@export_node_path() var Path_Left = NodePath("")
@export_node_path() var Path_Right = NodePath("")

var P_Right_Fixed = null
var P_Left_Fixed = null

func _ready() -> void:
	if Path_Left != NodePath(""):
		P_Left_Fixed = get_node(Path_Left)
		
	if Path_Right != NodePath(""):
		P_Right_Fixed = get_node(Path_Right)

func _on_body_entered(body: Node3D) -> void:
	print("Haio")
	Core.Persistant_Core.Player.ActiveArea = self


func _on_body_exited(body: Node3D) -> void:
	if Core.Persistant_Core.Player.ActiveArea == self:
		Core.Persistant_Core.Player.ActiveArea = null
	
