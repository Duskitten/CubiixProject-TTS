extends Node

var CoreOBJ = null

var mod_locations:Array[String] = [
	"res://Mods/",
	"user://Mods/"
	]

var current_modlist = {}

func setup(Core:Node):
	CoreOBJ = Core
	run_parser()

func scan_dir(dir:DirAccess, modpath:String) -> void:
	for directory in dir.get_directories():
		if !current_modlist.has(directory):
			var Modjson = FileAccess.file_exists(modpath+directory+"/Mod.txt")
			if Modjson:
				current_modlist[directory] = modpath+directory
				
		else:
			print("Error: ModID "+directory+" already taken.")

func run_parser():
	for modpath in mod_locations:
		var dir:DirAccess = DirAccess.open(modpath)
		if !dir:
			DirAccess.make_dir_absolute(modpath)
		scan_dir(dir, modpath)
	
	
func reset_current_modlist():
	current_modlist = {}
