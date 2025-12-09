extends Node

var coreobj = null

var modlocations:Array[String] = [
	"res://Mods/",
	"user://Mods/"
	]

var currentmodlist = {}

func setup(core:Node):
	coreobj = core
	run_parser()

func scan_dir(dir:DirAccess, modpath:String) -> void:
	for directory in dir.get_directories():
		if !currentmodlist.has(directory):
			var Modjson = FileAccess.file_exists(modpath+directory+"/Mod.txt")
			if Modjson:
				currentmodlist[directory] = modpath+directory
				coreobj.gassetmanager.add_new_index(directory)
				coreobj.gassetmanager.add_new_value(directory, "path", modpath+directory+"/Mod.txt")
		else:
			print("Error: ModID "+directory+" already taken.")

func run_parser():
	for modpath in modlocations:
		var dir:DirAccess = DirAccess.open(modpath)
		if !dir:
			DirAccess.make_dir_absolute(modpath)
		scan_dir(dir, modpath)
	
	
func reset_current_modlist():
	currentmodlist = {}
