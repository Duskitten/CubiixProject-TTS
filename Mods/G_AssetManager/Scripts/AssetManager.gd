extends Node

var coreobj = null

var assetstable : Dictionary = {}

func reset_asset_table():
	assetstable = {}

func setup(core:Node):
	coreobj = core

func add_new_index(index:String) -> void:
	assetstable[index] = {}

func add_new_value(index:String, key:String, value:String) -> void:
	assetstable[index][key] = value

func get_value(assetstring:String) -> String:
	var newstringarray:PackedStringArray = assetstring.split(":")
	if newstringarray.size() == 2 \
		&& assetstable.has(newstringarray[0]) \
		&& assetstable[newstringarray[0]].has(newstringarray[1]):
		return assetstable[newstringarray[0]][newstringarray[1]]
	else:
		return ""
