extends Node3D

@export var characterscripts: Array[String]
@export var cubiixcharacter:Dictionary = {
	"Palette":"",
	"Ears":"",
	"Extra":"",
	"Wings":"",
	"Eyes":"",
	"Tail":"",
	"Hat":"",
	"Back":"",
	"Hip_R":"",
	"Hip_L":"",
	"Hand_R":"",
	"Hand_L":""
}
@export var cubiixcolors:Dictionary = {
	"Primary":Color("a3ce27"),
	"Secondary":Color("44891a"),
	"EyeA":Color("31a2f2"),
	"EyeB":Color("005784"),
}

	
	
	
var scripts_sorted = {
	##This is where we're going to hold the scripts for later,
	##This is so we dont actually have to name our nodes when referencing them.
	##It also makes it so we can just grab this node rather than trying to dick around and find
	##something in the heirarchy, that shit is slow.
}

var coreobj = null

func _ready() -> void:
	coreobj = find_parent("Main")
	await get_tree().create_timer(0.1).timeout
	for script in characterscripts:
		var scriptdict:Dictionary = find_parent("Main").gassetmanager.get_value(script)
		if scriptdict  != {}:
			var loadscript = load( scriptdict["modpath"] + scriptdict["data"]["scriptloadpath"]).new()
			$Scripts.add_child(loadscript)
			scripts_sorted[script] = loadscript
			loadscript.setup(coreobj, self)
