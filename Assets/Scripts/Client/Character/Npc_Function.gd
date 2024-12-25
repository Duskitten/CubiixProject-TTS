extends Node3D
var CanInteract = false
@export var Character:String
@export var LineStart:String
@export var Is_Important:bool
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

func _ready() -> void:
	$Look_At_Range.body_entered.connect(Look_At_Range_Enter)
	$Look_At_Range.body_exited.connect(Look_At_Range_Exit)
	if Is_Important:
		get_parent().NPC_Is_InterestPoint = true

func _process(delta: float) -> void:
	if CanInteract:
		if Input.is_action_just_pressed("interact"):
			if Character.strip_edges(true) != "" && Core.Dialogue_Handler.Dialogue.keys().has(Character):
				print("NPC: OK")
				if LineStart.strip_edges(true) != "" && Core.Dialogue_Handler.Dialogue[Character].has(LineStart):
					print("Dialogue: OK")
				else:
					print("Error: No NPC Dialogue Found")
			else:
				print("Error: No NPC Found")
	
func Look_At_Range_Enter(Body:Node3D):
	if Body.is_in_group("Player"):
		print("Looking!")
		CanInteract = true
		get_parent().get_node("Hub/Cubiix_Model/Skeleton3D/LookAtBone").Target = Body.get_node("Hub/Follow_Point")
	
func Look_At_Range_Exit(Body:Node3D):
	if Body.is_in_group("Player"):
		print("Defaulting!")
		CanInteract = false
		get_parent().get_node("Hub/Cubiix_Model/Skeleton3D/LookAtBone").Target = null
