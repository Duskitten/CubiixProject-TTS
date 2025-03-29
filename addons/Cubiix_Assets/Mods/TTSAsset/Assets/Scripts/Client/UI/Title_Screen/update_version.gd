extends Label
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("123",Core.Globals.GameVersion)
	self.text = str(Core.Globals.GameVersion)
