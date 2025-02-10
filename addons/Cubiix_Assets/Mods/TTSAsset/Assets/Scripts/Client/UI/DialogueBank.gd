extends Node
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
var Dialogue = {
	##Core Characters
	"Dusk" : {
		##Text, End, Next Line, character
		"Init" : ["Oh, Hello.", true, ["Init", "Dusk"]]
	},
	"Nat" : {
		"Init" : ["Oh, Hello.", true, ["Init", "Nat"]]
	},
	"Ki" : {
		"Init" : ["Ah! Hello! I'm Ki!", false, ["Follow", "Ki"]],
		"Follow" : ["I'm the resident tourguide of Hexstaria!", true, ["Init", "Ki"]]
	},
	"Skim" : {
		"Init" : ["Oh, Hello.", true, ["Init", "Skim"]]
	},
	##---
	##Random Gen NPC
	
	##---
	##Outsiders
	"Ireno" : {
		"Init" : ["Can death be sleep when life is but a dream?", true, ["Init", "Ireno"]]
	},
	##---
}
