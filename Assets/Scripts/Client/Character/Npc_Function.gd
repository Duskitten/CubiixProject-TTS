extends Node3D
var CanInteract = false
@export var Character:StringName
@export var Line:int
@export var Is_Important:bool


func _ready() -> void:
	$Look_At_Range.body_entered.connect(Look_At_Range_Enter)
	$Look_At_Range.body_exited.connect(Look_At_Range_Exit)
	$Interact_Range.body_entered.connect(Interact_Range_Enter)
	$Interact_Range.body_exited.connect(Interact_Range_Exit)
	if Is_Important:
		get_parent().NPC_Is_InterestPoint = true
	
	
func Look_At_Range_Enter(Body:Node3D):
	if Body.is_in_group("Player"):
		print("Looking!")
		get_parent().Look_At = Body.get_node("Hub/Head")
	
func Look_At_Range_Exit(Body:Node3D):
	if Body.is_in_group("Player"):
		print("Defaulting!")
		get_parent().Look_At = null
	
func Interact_Range_Enter(Body:Node3D):
	if Body.is_in_group("Player"):
		print("Hai")
	
func Interact_Range_Exit(Body:Node3D):
	if Body.is_in_group("Player"):
		print("Hai")
