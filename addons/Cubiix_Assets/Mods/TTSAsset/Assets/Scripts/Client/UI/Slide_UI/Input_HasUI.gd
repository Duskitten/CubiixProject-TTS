extends Control
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
@onready var ControllerID = find_parent("Slide_UI").ControllerID
var HasControl = false
