extends Node2D

func _ready() -> void:
	for i in $Control.get_child_count():
		$Control.get_node( "Tile" + str(i+1) ).pressed.connect(clicked.bind(i+1))
		
func clicked(buttonID:int) -> void:
	print(buttonID)
