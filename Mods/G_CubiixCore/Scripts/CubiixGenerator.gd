extends Node3D

@export var characterscripts: Array[String]
@export var characterjson: String

var scripts_sorted = {
	##This is where we're going to hold the scripts for later,
	##This is so we dont actually have to name our nodes when referencing them.
	##It also makes it so we can just grab this node rather than trying to dick around and find
	##something in the heirarchy, that shit is slow.
}

func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	for script in characterscripts:
		var scriptdict:Dictionary = find_parent("Main").gassetmanager.get_value(script)
		if scriptdict  != {}:
			var loadscript = load( scriptdict["modpath"] + scriptdict["data"]["scriptloadpath"]).new()
			$Scripts.add_child(loadscript)
			scripts_sorted[script] = loadscript
