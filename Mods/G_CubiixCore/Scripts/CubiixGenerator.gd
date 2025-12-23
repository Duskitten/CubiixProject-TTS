extends Node3D

@export var characterscripts: Array[String]
@export var characterjson: String

func _ready() -> void:
	for script in characterscripts:
		var scriptdict:Dictionary = find_parent("Main").gassetmanager.get_value(script)
		
		if scriptdict  != null:
			var loadscript = load(scriptdict["scriptloadpath"]).new()
			$Scripts.add_child(loadscript)
