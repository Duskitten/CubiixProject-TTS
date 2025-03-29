extends Control
var Root:Node

var PositionFaction = ["Hexii", "Trii" ,"Octii", "Nullvii", "Tixii"]
@onready var FactionBox = $ScrollContainer2/VBoxContainer/HBoxContainer
@onready var SlideText = $ScrollContainer2/VBoxContainer/Slide_Text
@onready var SlideScale = $ScrollContainer2/VBoxContainer/Slide_Scale
@onready var Name = $ScrollContainer2/VBoxContainer/Name
@onready var PronounsA = $ScrollContainer2/VBoxContainer/PronounsA
@onready var PronounsB = $ScrollContainer2/VBoxContainer/PronounsB
@onready var PronounsC = $ScrollContainer2/VBoxContainer/PronounsC


func _ready() -> void:
	Root = find_parent("DragArea")

func setup() -> void:
	var parent = find_parent("TextureRect")
	
	for i in FactionBox.get_children():
		i.get_node("TextureRect").texture = ResourceLoader.load("res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Faction_Icons/"+i.name+"_Logo_V2.png","",ResourceLoader.CACHE_MODE_REPLACE)
	var faction = PositionFaction[parent.Faction]
	FactionBox.get_node(faction).get_node("TextureRect").texture = ResourceLoader.load("res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Faction_Icons/"+faction+"_Logo_V2_Glow.png","",ResourceLoader.CACHE_MODE_REPLACE)
	
	SlideText.text = str("%0.1f" % parent.Scale)
	SlideScale.value = parent.Scale
	Name.text = parent.Name
	PronounsA.text = parent.Pronouns_A
	PronounsB.text = parent.Pronouns_B
	PronounsC.text = parent.Pronouns_C
	
func _on_faction_pressed(extra_arg_0: String) -> void:
	for i in FactionBox.get_children():
		i.get_node("TextureRect").texture = ResourceLoader.load("res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Faction_Icons/"+i.name+"_Logo_V2.png","",ResourceLoader.CACHE_MODE_REPLACE)
	FactionBox.get_node(extra_arg_0).get_node("TextureRect").texture = ResourceLoader.load("res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Faction_Icons/"+extra_arg_0+"_Logo_V2_Glow.png","",ResourceLoader.CACHE_MODE_REPLACE)
	find_parent("TextureRect").set_edited()
	var character = Root.Temp_Character
	character.Faction = PositionFaction.find(extra_arg_0)

var ignore = false

func _on_slide_text_text_changed(new_text: String) -> void:
	var newvalue = clampf(float(new_text), 0.8, 1.2)
	SlideScale.value = newvalue
	adjust_scale(newvalue)

func _on_slide_scale_changed(value:float) -> void:
	var newvalue = clampf(value, 0.8, 1.2)
	SlideText.text = str("%0.1f" % newvalue)
	adjust_scale(newvalue)

func adjust_scale(newvalue:float) -> void:
	find_parent("TextureRect").set_edited()
	var character = Root.Temp_Character
	character.Scale =  newvalue
	character.adjust_scale()


func _on_detail_text_changed(new_text: String, extra_arg_0: String) -> void:
	var character = Root.Temp_Character
	character.set(extra_arg_0, new_text)
	find_parent("TextureRect").set_edited()
