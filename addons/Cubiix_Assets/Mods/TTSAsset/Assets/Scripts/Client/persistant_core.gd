extends Node
@onready var Core = get_node("/root/Main_Scene/CoreLoader")


@onready var Transitioner = $CanvasLayer/Transitioner
@onready var Transitioner_AnimationPlayer = Transitioner.get_node("AnimationPlayer")

var TemplateChar
@onready var Player = $Node3D/Player
@onready var AudioPlayer = $Node3D/Audio
@onready var NetworkFolder = $Node3D/Network_Players
@onready var Network_Players = $Node3D/Network_Players

var Tick_Prev = 0
var Tick_Timer = 0



func _ready() -> void:
	Core.Client.NetworkPlayers = Network_Players
	#Core.AssetData.Tools.clone_character_with_accessories(Player.Hub,Hexii_Ui_Tablet_Character.Hub)
	$CanvasLayer/Transitioner.visible = true
	AudioPlayer.add_child(CurrentAudioPlayer)




func SpawnAt(Location:Vector3,Rotation:Vector3) -> void:
	Player.position = Location
	#Player.CameraLength = -4.0
	$Node3D/Player/Hub.rotation = Rotation
	$Node3D/Core_Follow/Rot_Y.rotation = Rotation
	$Node3D/Core_Follow/Rot_Y/Rot_X.rotation = Vector3(deg_to_rad(15),0,0)

func _process(delta: float) -> void:
	var Delta = Time.get_ticks_msec() - Tick_Prev
	Tick_Prev = Time.get_ticks_msec()
	Tick_Timer += Delta
	
	if Tick_Timer > 1000/20:
		Tick_Timer = 0
		if AudioHost != null:
			for i in AudioHost.get_children():
				if i.name != "Audio":
					if Player.global_position.distance_to(i.global_position) <= i.Tag_Radius:
						if !TracksOverlap.has(i):
							TracksOverlap.append(i)
					else:
						if TracksOverlap.has(i):
							TracksOverlap.erase(i)
							
			if TracksOverlap.back().SongID != LastSong:
				Transition_New_Song(TracksOverlap.back().SongID)
var TracksOverlap = []



#
#
#func _on_color_text_change(new_text:String, type:String) -> void:
	#get_viewport().gui_release_focus()
	#$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button4.show()
	#$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button3.show()
	#Hexii_Ui_Tablet_Color_Container.get_node("M/HSlider").value = clampf(float(Hexii_Ui_Tablet_Color_Container.get_node("M/LineEdit").text),0.0,1.0)
	#Hexii_Ui_Tablet_Color_Container.get_node("RO/HSlider").value = clampf(float(Hexii_Ui_Tablet_Color_Container.get_node("RO/LineEdit").text),0.0,1.0)
	#Hexii_Ui_Tablet_Color_Container.get_node("E_S/HSlider").value = clampf(float(Hexii_Ui_Tablet_Color_Container.get_node("E_S/LineEdit").text),0.0,1.0)
	#
	#if type == "Hex":
		#if Hexii_Ui_Tablet_Color_Container.get_node("Hex_Input/LineEdit").text.is_valid_html_color():
			#var color = Color(Hexii_Ui_Tablet_Color_Container.get_node("Hex_Input/LineEdit").text)
			#Hexii_Ui_Tablet_Color_Container.get_node("R/HSlider").value = color.r8
			#Hexii_Ui_Tablet_Color_Container.get_node("G/HSlider").value = color.g8
			#Hexii_Ui_Tablet_Color_Container.get_node("B/HSlider").value = color.b8
			#Hexii_Ui_Tablet_Color_Container.get_node("R/LineEdit").text = str(color.r8)
			#Hexii_Ui_Tablet_Color_Container.get_node("G/LineEdit").text = str(color.g8)
			#Hexii_Ui_Tablet_Color_Container.get_node("B/LineEdit").text = str(color.b8)
			#Hexii_Ui_Tablet_Character_OBJ.Hub.Shader_Color[Hexii_Ui_Tablet_Character_OBJ.Hub.Keylist["Body"][current_colorselected]] = Color8(color.r8,color.g8,color.b8)
		#
			#
		#if Hexii_Ui_Tablet_Color_Container.get_node("Emission_Input/LineEdit").text.is_valid_html_color():
			#var color = Color(Hexii_Ui_Tablet_Color_Container.get_node("Emission_Input/LineEdit").text)
			#Hexii_Ui_Tablet_Color_Container.get_node("E_R/HSlider").value = color.r8
			#Hexii_Ui_Tablet_Color_Container.get_node("E_G/HSlider").value = color.g8
			#Hexii_Ui_Tablet_Color_Container.get_node("E_B/HSlider").value = color.b8
			#Hexii_Ui_Tablet_Color_Container.get_node("E_R/LineEdit").text = str(color.r8)
			#Hexii_Ui_Tablet_Color_Container.get_node("E_G/LineEdit").text = str(color.g8)
			#Hexii_Ui_Tablet_Color_Container.get_node("E_B/LineEdit").text = str(color.b8)
			#Hexii_Ui_Tablet_Character_OBJ.Hub.Shader_Emission[Hexii_Ui_Tablet_Character_OBJ.Hub.Keylist["Body"][current_colorselected]] = Color8(color.r8,color.g8,color.b8)
		#
	#elif type == "RGB":
		#var color = Color(
			#int(Hexii_Ui_Tablet_Color_Container.get_node("R/LineEdit").text),
			#int(Hexii_Ui_Tablet_Color_Container.get_node("G/LineEdit").text),
			#int(Hexii_Ui_Tablet_Color_Container.get_node("B/LineEdit").text)
		#)
		#Hexii_Ui_Tablet_Color_Container.get_node("Hex_Input/LineEdit").text = color.to_html(false)
		#Hexii_Ui_Tablet_Color_Container.get_node("R/HSlider").value = color.r
		#Hexii_Ui_Tablet_Color_Container.get_node("G/HSlider").value = color.g
		#Hexii_Ui_Tablet_Color_Container.get_node("B/HSlider").value = color.b
		#Hexii_Ui_Tablet_Character_OBJ.Hub.Shader_Color[Hexii_Ui_Tablet_Character_OBJ.Hub.Keylist["Body"][current_colorselected]] = Color8(int(color.r),int(color.g),int(color.b))
		#
		#var colorEmiss = Color(
			#int(Hexii_Ui_Tablet_Color_Container.get_node("E_R/LineEdit").text),
			#int(Hexii_Ui_Tablet_Color_Container.get_node("E_G/LineEdit").text),
			#int(Hexii_Ui_Tablet_Color_Container.get_node("E_B/LineEdit").text)
		#)
		#Hexii_Ui_Tablet_Color_Container.get_node("Emission_Input/LineEdit").text = colorEmiss.to_html(false)
		#Hexii_Ui_Tablet_Color_Container.get_node("E_R/HSlider").value = colorEmiss.r
		#Hexii_Ui_Tablet_Color_Container.get_node("E_G/HSlider").value = colorEmiss.g
		#Hexii_Ui_Tablet_Color_Container.get_node("E_B/HSlider").value = colorEmiss.b
		#Hexii_Ui_Tablet_Character_OBJ.Hub.Shader_Emission[Hexii_Ui_Tablet_Character_OBJ.Hub.Keylist["Body"][current_colorselected]] = Color8(int(colorEmiss.r),int(colorEmiss.g),int(colorEmiss.b))
		#
	#Hexii_Ui_Tablet_Character_OBJ.Hub.generate_colors()
	#update_values() 
#
#func _on_color_value_changed(value: float) -> void:
	#if !initialpress:
		#print("haoi")
		#$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button4.show()
		#$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button3.show()
		#var Metallic = Hexii_Ui_Tablet_Color_Container.get_node("M/HSlider").value
		#var Roughness = Hexii_Ui_Tablet_Color_Container.get_node("RO/HSlider").value
		#
		#var R = int(Hexii_Ui_Tablet_Color_Container.get_node("R/HSlider").value)
		#var G = int(Hexii_Ui_Tablet_Color_Container.get_node("G/HSlider").value)
		#var B = int(Hexii_Ui_Tablet_Color_Container.get_node("B/HSlider").value)
		#
		#var RE = int(Hexii_Ui_Tablet_Color_Container.get_node("E_R/HSlider").value)
		#var GE= int(Hexii_Ui_Tablet_Color_Container.get_node("E_G/HSlider").value)
		#var BE = int(Hexii_Ui_Tablet_Color_Container.get_node("E_B/HSlider").value)
		#var SE = Hexii_Ui_Tablet_Color_Container.get_node("E_S/HSlider").value
		#
		#Hexii_Ui_Tablet_Character_OBJ.Hub.Shader_Color[Hexii_Ui_Tablet_Character_OBJ.Hub.Keylist["Body"][current_colorselected]] = Color8(R,G,B)
		#Hexii_Ui_Tablet_Character_OBJ.Hub.Shader_Emission[Hexii_Ui_Tablet_Character_OBJ.Hub.Keylist["Body"][current_colorselected]] = Color8(RE,GE,BE)
		#
		#Hexii_Ui_Tablet_Character_OBJ.Hub.Shader_Roughness[Hexii_Ui_Tablet_Character_OBJ.Hub.Keylist["Body"][current_colorselected]] = Roughness
		#Hexii_Ui_Tablet_Character_OBJ.Hub.Shader_Metallic[Hexii_Ui_Tablet_Character_OBJ.Hub.Keylist["Body"][current_colorselected]] = Metallic
		#Hexii_Ui_Tablet_Character_OBJ.Hub.Shader_Emission_Strength[Hexii_Ui_Tablet_Character_OBJ.Hub.Keylist["Body"][current_colorselected]] = SE
		#
		#Hexii_Ui_Tablet_Character_OBJ.Hub.generate_colors()
		#update_values() 
#
#func update_values() -> void:
	#$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button4.show()
	#$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button3.show()
	#var color:Color = Hexii_Ui_Tablet_Character_OBJ.Hub.Shader_Color[Hexii_Ui_Tablet_Character_OBJ.Hub.Keylist["Body"][current_colorselected]]
	#var colorEmiss:Color = Hexii_Ui_Tablet_Character_OBJ.Hub.Shader_Emission[Hexii_Ui_Tablet_Character_OBJ.Hub.Keylist["Body"][current_colorselected]]
	#
	#Hexii_Ui_Tablet_Color_Container.get_node("Emiss_Color_Rect").color =  colorEmiss
	#Hexii_Ui_Tablet_Color_Container.get_node("Base_Color_Rect").color =  color
		#
	#Hexii_Ui_Tablet_Color_Container.get_node("Hex_Input/LineEdit").text = color.to_html(false)
	#Hexii_Ui_Tablet_Color_Container.get_node("Emission_Input/LineEdit").text = colorEmiss.to_html(false) 
		#
	#Hexii_Ui_Tablet_Color_Container.get_node("R/LineEdit").text = str(color.r8)
	#Hexii_Ui_Tablet_Color_Container.get_node("G/LineEdit").text = str(color.g8)
	#Hexii_Ui_Tablet_Color_Container.get_node("B/LineEdit").text = str(color.b8)
		#
	#Hexii_Ui_Tablet_Color_Container.get_node("E_R/LineEdit").text = str(colorEmiss.r8)
	#Hexii_Ui_Tablet_Color_Container.get_node("E_G/LineEdit").text = str(colorEmiss.g8)
	#Hexii_Ui_Tablet_Color_Container.get_node("E_B/LineEdit").text = str(colorEmiss.b8)
	#
	#Hexii_Ui_Tablet_Color_Container.get_node("E_S/LineEdit").text = str(Hexii_Ui_Tablet_Character_OBJ.Hub.Shader_Emission_Strength[Hexii_Ui_Tablet_Character_OBJ.Hub.Keylist["Body"][current_colorselected]])
	#
	#Hexii_Ui_Tablet_Color_Container.get_node("RO/LineEdit").text = str(Hexii_Ui_Tablet_Character_OBJ.Hub.Shader_Roughness[Hexii_Ui_Tablet_Character_OBJ.Hub.Keylist["Body"][current_colorselected]])
	#Hexii_Ui_Tablet_Color_Container.get_node("M/LineEdit").text = str(Hexii_Ui_Tablet_Character_OBJ.Hub.Shader_Metallic[Hexii_Ui_Tablet_Character_OBJ.Hub.Keylist["Body"][current_colorselected]])








##################################
###### Audio Manager System ######
##################################
var LastSong = ""
var SongList = {
	"FishShop":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Audio/OST/FishinForCubes.ogg",
	"Trinket":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Audio/OST/Trinket.ogg",
	"HobblinWobblin":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Audio/OST/HobblinWobblin.ogg",
	"Sunset":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Audio/OST/SunsetsAndPalmTrees.ogg",
	"ChillSunset":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Audio/OST/ChillSunsets.ogg",
	"FishyFish":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Audio/OST/FishyFish.ogg",
	"Xeno":"res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Audio/OST/Xeno.ogg"
}

var AudioHost = null

var CurrentAudioPlayer:AudioStreamPlayer  = AudioStreamPlayer.new()
var OldAudioPlayer:AudioStreamPlayer = null

func Transition_New_Song(NewSongID:String) -> void:
	LastSong = NewSongID
	OldAudioPlayer = CurrentAudioPlayer
	CurrentAudioPlayer = AudioStreamPlayer.new()
	CurrentAudioPlayer.bus = &"Music"
	CurrentAudioPlayer.volume_db = -80
	CurrentAudioPlayer.stream = load(SongList[NewSongID])
	CurrentAudioPlayer.autoplay = true
	AudioPlayer.add_child(CurrentAudioPlayer)
	var AudioFader = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	var AudioFader2 = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	AudioFader.tween_property(CurrentAudioPlayer, "volume_db", 0, .2)
	AudioFader2.tween_property(OldAudioPlayer, "volume_db", -80, 1)
	AudioFader.play()
	AudioFader2.play()
	AudioFader2.tween_callback(OldAudioPlayer.queue_free)
