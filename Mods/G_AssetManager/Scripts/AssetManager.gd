extends Node

var coreobj = null

var assetstable : Dictionary = {}

func reset_asset_table():
	assetstable = {}

func setup(core:Node):
	coreobj = core

func add_new_index(index:String) -> void:
	assetstable[index] = {}

func add_new_value(index:String, key:String, value:Variant) -> void:
	assetstable[index][key] = value

func get_value(assetstring:String) -> Dictionary:
	print(assetstring)
	if  assetstable.has(assetstring):
		return assetstable[assetstring]
	else:
		return {}
