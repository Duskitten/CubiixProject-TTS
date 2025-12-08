extends Node

var CoreOBJ = null

var Assets_Table : Dictionary = {}

func reset_asset_table():
	Assets_Table = {}

func setup(Core:Node):
	CoreOBJ = Core

func add_new_index(index:String) -> void:
	Assets_Table[index] = {}

func add_new_value(index:String, key:String, value:String) -> void:
	Assets_Table[index][key] = value

func get_value(asset_string:String) -> String:
	var new_string_array:PackedStringArray = asset_string.split(":")
	if new_string_array.size() == 2 \
		&& Assets_Table.has(new_string_array[0]) \
		&& Assets_Table[new_string_array[0]].has(new_string_array[1]):
		return Assets_Table[new_string_array[0]][new_string_array[1]]
	else:
		return ""
