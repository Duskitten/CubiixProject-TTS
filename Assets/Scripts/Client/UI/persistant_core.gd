extends Node
@onready var Core = get_node("/root/Main_Scene/CoreLoader")


@onready var Transitioner = $CanvasLayer/Transitioner
@onready var Transitioner_AnimationPlayer = Transitioner.get_node("AnimationPlayer")

@onready var Update_Check = $HTTPNodes/Update_Check
@onready var Update_Downloader = $HTTPNodes/Update_Downloader
@onready var Login_Create = $HTTPNodes/Login_Create
@onready var Login_Signin = $HTTPNodes/Login_Signin
@onready var API_Validate = $HTTPNodes/API_Validate

var URL = ""
var API_URL = ""

var Mouse_In_UI = false
var Menu_Focused = false
var TablockEnabled = false
var TablockBypass = false
var DragMode = false
@onready var Player = $Node3D/Player
@onready var AudioPlayer = $Node3D/Audio
@onready var NetworkFolder = $Node3D/Network_Players

var windowLocations = {
	"Character_Screen": Vector2(61,202),
	"Journal_Screen": Vector2(199,202)
}

var Tick_Prev = 0
var Tick_Timer = 0



func _ready() -> void:
###### Signal Connections ######
	Login_Signin.request_completed.connect(self.login_request_completed)
	API_Validate.request_completed.connect(self.api_validate_completed)
	Login_Create.request_completed.connect(self.register_request_completed)
	$CanvasLayer/Transitioner.visible = true
	$CanvasLayer/CrossHair.position = Vector2(get_viewport().size/2) - ($CanvasLayer/CrossHair.size/2)
	#TitleScreen
	#Hexii_Ui_Tablet_QuitButton.pressed.connect(QuitButton_Pressed.bind())
	#Hexii_Ui_Tablet_TitleButton.pressed.connect(Hexii_UI_Transition.bind("Exit_Back","Hexii_Ui_Tablet_TitleScreen_Anim","Back","", false))
	#Hexii_Ui_Tablet_PlayButton.pressed.connect(Hexii_UI_Transition.bind("Exit_Back","Hexii_Ui_Tablet_LoginScreen_Anim","Back","", false))
	#Hexii_Ui_Tablet_DevlogButton.pressed.connect(Hexii_UI_Transition.bind("Exit_Back","Hexii_Ui_Tablet_DevlogScreen_Anim","Back","", false))
	#Hexii_Ui_Tablet_SettingsButton.pressed.connect(Hexii_UI_Transition.bind("Exit_Back","Hexii_Ui_Tablet_SettingsScreen_Anim","Back","", false))
	#Hexii_Ui_Tablet_CharacterButton.pressed.connect(Hexii_UI_Transition.bind("Exit_Back","Hexii_Ui_Tablet_CharacterScreen_Anim","Back","", false))
	#Hexii_Ui_Tablet_CommunityButton.pressed.connect(CommunityButton_Pressed.bind())
	Hexii_Ui_Tablet_CharacterButton.pressed.connect(button_check.bind(Hexii_Ui_Tablet_CharacterScreen))
	Hexii_Ui_Tablet_JournalButton.pressed.connect(button_check.bind(Hexii_Ui_Tablet_JournalScreen))

	Hexii_Ui_Tablet_CharacterScreen.position = windowLocations["Character_Screen"]
	Hexii_Ui_Tablet_CharacterScreen.scale = Vector2.ZERO
	Hexii_Ui_Tablet_CharacterScreen.modulate = Color8(255,255,255,0)
	
	Hexii_Ui_Tablet_JournalScreen.position = windowLocations["Journal_Screen"]
	Hexii_Ui_Tablet_JournalScreen.scale = Vector2.ZERO
	Hexii_Ui_Tablet_JournalScreen.modulate = Color8(255,255,255,0)
	#Chat
	Hexii_Ui_Chat_TextInput.text_submitted.connect(send_text.bind())
	
	Hexii_Ui_Tablet_JournalButton.emit_signal("pressed")
	
	#Core.AssetData.Tools.clone_character_with_accessories(Player.Hub,Hexii_Ui_Tablet_Character.Hub)

	AudioPlayer.add_child(CurrentAudioPlayer)




func SpawnAt(Location:Vector3,Rotation:Vector3) -> void:
	Player.position = Location
	#Player.CameraLength = -4.0
	$Node3D/Player/Hub.rotation = Rotation
	$Node3D/Core_Follow/Rot_Y.rotation = Rotation
	$Node3D/Core_Follow/Rot_Y/Rot_X.rotation = Vector3(deg_to_rad(15),0,0)

var MousePos = Vector2.ZERO
var TabletDragging = false
var PhoneDragging = false

func _process(delta: float) -> void:
	if (($CanvasLayer/Hexii_Tablet_UI/Wallpaper.get_global_rect().grow(-32).has_point(get_viewport().get_mouse_position()) && $CanvasLayer/Hexii_Tablet_UI.visible) || ($CanvasLayer/Hexii_UI/Overlay.get_global_rect().grow(-32).has_point(get_viewport().get_mouse_position()) && $CanvasLayer/Hexii_UI.visible)):
		_on_area_2d_mouse_entered()
	elif (!$CanvasLayer/Hexii_Tablet_UI/Wallpaper.get_global_rect().grow(-32).has_point(get_viewport().get_mouse_position()) || !$CanvasLayer/Hexii_Tablet_UI.visible) && (!$CanvasLayer/Hexii_UI/Overlay.get_global_rect().grow(-32).has_point(get_viewport().get_mouse_position()) || !$CanvasLayer/Hexii_UI.visible):
		_on_area_2d_mouse_exited()
	
	if !Menu_Focused:
		if Input.is_action_just_pressed("sub_menu"):
			Hexii_Ui_Tablet.visible = !Hexii_Ui_Tablet.visible
		if Input.is_action_just_pressed("chat_menu"):
			Hexii_Ui.visible = !Hexii_Ui.visible
		if Input.is_action_just_pressed("chat") && $CanvasLayer/Hexii_UI.visible:
			Hexii_Ui_Chat_TextInput.grab_focus()
			
		if InTablet_DragArea:
			if Input.is_action_just_pressed("mouse_left"):
				MousePos = get_viewport().get_mouse_position() - $CanvasLayer/Hexii_Tablet_UI.global_position
				TabletDragging = true
		if InPhone_DragArea:
			if Input.is_action_just_pressed("mouse_left"):
				MousePos = get_viewport().get_mouse_position() - $CanvasLayer/Hexii_UI.global_position
				PhoneDragging = true
				
		if TabletDragging:
			if Input.is_action_pressed("mouse_left"):
				if Rect2(Vector2(20,20),Vector2(get_window().size)-Vector2(40,40)).has_point(get_viewport().get_mouse_position()):
					$CanvasLayer/Hexii_Tablet_UI.position = get_viewport().get_mouse_position() - MousePos
			if Input.is_action_just_released("mouse_left"):
				TabletDragging = false
				
		if PhoneDragging:
			if Input.is_action_pressed("mouse_left"):
				if Rect2(Vector2(20,20),Vector2(get_window().size)-Vector2(40,40)).has_point(get_viewport().get_mouse_position()):
					$CanvasLayer/Hexii_UI.position = get_viewport().get_mouse_position() - MousePos
			if Input.is_action_just_released("mouse_left"):
				PhoneDragging = false
		
	if TablockEnabled:
		if Mouse_In_UI || Menu_Focused || $CanvasLayer/Hexii_Tablet_UI.visible:
			if $CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/SubViewportContainer/SubViewport.MouseInside:
				Input.mouse_mode = Input.MouseMode.MOUSE_MODE_CAPTURED
				TablockBypass = false
				$CanvasLayer/CrossHair.visible = false
			else:
				Input.mouse_mode = Input.MouseMode.MOUSE_MODE_VISIBLE
				TablockBypass = true
				$CanvasLayer/CrossHair.visible = false
		else:
			Input.mouse_mode = Input.MouseMode.MOUSE_MODE_CAPTURED
			TablockBypass = false
			$CanvasLayer/CrossHair.visible = true
	else:
		if $CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/SubViewportContainer/SubViewport.MouseInside:
				Input.mouse_mode = Input.MouseMode.MOUSE_MODE_CAPTURED
				TablockBypass = false
				$CanvasLayer/CrossHair.visible = false
		else:
			Input.mouse_mode = Input.MouseMode.MOUSE_MODE_VISIBLE
			TablockBypass = false
			$CanvasLayer/CrossHair.visible = false
			
	
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
	
#############################
###### Hexii UI System ######
#############################
@onready var Hexii_Ui = $CanvasLayer/Hexii_UI
@onready var Hexii_Ui_Anim = Hexii_Ui.get_node("Overlay/AnimationPlayer")
@onready var Hexii_Ui_NullScreen_Anim =  Hexii_Ui.get_node("Overlay/Screens/Null_Screen/AnimationPlayer")

@onready var Hexii_Ui_Tablet = $CanvasLayer/Hexii_Tablet_UI
#@onready var Hexii_Ui_Tablet_DevlogScreen_Anim = Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Panel/Devlog_Screen/AnimationPlayer")
#@onready var Hexii_Ui_Tablet_SettingsScreen_Anim = Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Panel/Settings_Screen/AnimationPlayer")
@onready var Hexii_Ui_Tablet_Character = Hexii_Ui_Tablet.get_node("Wallpaper/Character_Screen/SubViewportContainer/SubViewport/Character_Editor/Cubiix_Base")

func _on_area_2d_mouse_entered() -> void:
	Mouse_In_UI = true

func _on_area_2d_mouse_exited() -> void:
	Mouse_In_UI = false


var IsInBounds = false

# DM:> Changing it from _input to _unhandled_key_input, fixes the bug where the tab lock mode gets ignore when the player moves the mouse cursor.
func _unhandled_key_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("shiftlock") && !Mouse_In_UI:
		TablockEnabled = !TablockEnabled

var current_tablet_menu = null
var window_lock = false

func button_check(buttonID) -> void:
	
	if !window_lock:
		window_lock = true
		if current_tablet_menu == buttonID:
			current_tablet_menu = null
			var target = windowLocations[buttonID.name]

					
			var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_parallel(true).set_trans(Tween.TRANS_QUAD)
			tween.tween_property(buttonID, "position", target, .2)
			tween.tween_property(buttonID, "scale", Vector2.ZERO, .2)
			tween.tween_property(buttonID, "modulate", Color8(255,255,255,0), .2)
			await get_tree().create_timer(0.2).timeout
			buttonID.hide()
			window_lock = false

		else:
			var oldmenu = null
			if current_tablet_menu != null:
				oldmenu = current_tablet_menu
				var target = windowLocations[oldmenu.name]
						
				var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_parallel(true).set_trans(Tween.TRANS_QUAD)
				tween.tween_property(current_tablet_menu, "position", target, .2)
				tween.tween_property(current_tablet_menu, "scale", Vector2.ZERO, .2)
				tween.tween_property(current_tablet_menu, "modulate", Color8(255,255,255,0), .2)

			buttonID.show()
			current_tablet_menu = buttonID
			var tween2 = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_parallel(true).set_trans(Tween.TRANS_QUAD)
			tween2.tween_property(buttonID, "position", Vector2.ZERO, .2)
			tween2.tween_property(buttonID, "scale", Vector2(1,1), .2)
			tween2.tween_property(buttonID, "modulate", Color8(255,255,255,255), .2)
			await get_tree().create_timer(0.2).timeout
			if oldmenu != null:
				oldmenu.hide()
			window_lock = false

func Hexii_UI_Transition(anim_1,  componentName, anim_2, component2Name, device:bool)-> void:
	
	if device:
		if anim_1 == "Back":
			Hexii_Ui_Anim.play("Tilt_L")
		elif anim_1 == "Enter":
			Hexii_Ui_Anim.play("Tilt_R")
		if componentName in self && component2Name in self:
			get(componentName).play(anim_1)
			get(component2Name).play(anim_2)
	#else:
		#if componentName in self && Active_Hexii_Ui_Tablet_Screen_Anim in self && Active_Hexii_Ui_Tablet_Screen_Anim != componentName:
			#get(componentName).play(anim_1)
			#get(Active_Hexii_Ui_Tablet_Screen_Anim).play(anim_2)
			#Active_Hexii_Ui_Tablet_Screen_Anim = componentName

#######################################
###### Tablet Char Screen System ######
#######################################

@onready var Hexii_Ui_Tablet_Character_Template_Part = Hexii_Ui_Tablet.get_node("Wallpaper/Character_Screen/Options/Template_Button")
@onready var Hexii_Ui_Tablet_Character_OBJ = $CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/SubViewportContainer/SubViewport/Character_Editor/Cubiix_Base
@onready var Hexii_Ui_Tablet_Color_Container = $CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Color_Picker/ScrollContainer_Color/GridContainer2

var current_colorselected = ""
var initialpress = false

func Hide_part_Menus()-> void:
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Color_Picker.hide()
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Options.hide()
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Name_Picker.hide()
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Code_Loader.hide()

signal Accessory_Response
signal Accessory_Update
var Currently_Unlocked_Assets = {}

func _on_part_button_pressed(PartData: String) -> void:
	get_viewport().gui_release_focus()
	
	if PartData.begins_with("Extra, "):
		var Asset = PartData.lstrip("Extra, ")
		match Asset:
			"Code":
				Hide_part_Menus()
				$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Code_Loader.show()
			"Detail":
				Hide_part_Menus()
				$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Name_Picker.show()
				$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Name_Picker/ScrollContainer_Color/GridContainer2/Name_Input/LineEdit.text = Hexii_Ui_Tablet_Character_OBJ.Name
				
				$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Name_Picker/ScrollContainer_Color/GridContainer2/Name_Input2/LineEdit.text = Hexii_Ui_Tablet_Character_OBJ.Pronouns_A
				$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Name_Picker/ScrollContainer_Color/GridContainer2/Name_Input3/LineEdit.text = Hexii_Ui_Tablet_Character_OBJ.Pronouns_B
				$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Name_Picker/ScrollContainer_Color/GridContainer2/Name_Input4/LineEdit.text = Hexii_Ui_Tablet_Character_OBJ.Pronouns_C
				
				$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Name_Picker/ScrollContainer_Color/GridContainer2/Scale/HSlider.value = Hexii_Ui_Tablet_Character_OBJ.Scale
				$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Name_Picker/ScrollContainer_Color/GridContainer2/Scale/LineEdit.text = str(Hexii_Ui_Tablet_Character_OBJ.Scale)
			"Apply":
				$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button4.hide()
				$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button3.hide()
				
				if Core.Client.TCP.get_status() == StreamPeerTCP.STATUS_CONNECTED:
					Core.Client.char_update()
				else:
					Core.AssetData.Tools.clone_character_with_accessories(Hexii_Ui_Tablet_Character.Hub,Player.Hub)
				
			"Revert":
				$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button4.hide()
				$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button3.hide()
				Core.AssetData.Tools.clone_character_with_accessories(Player.Hub,Hexii_Ui_Tablet_Character.Hub)
		
	elif PartData.begins_with("Color, "):
		var Asset = PartData.lstrip("Color, ")
		Hide_part_Menus()
		$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Color_Picker.show()
		current_colorselected = Asset
		
		var color:Color = Hexii_Ui_Tablet_Character_OBJ.Hub.Shader_Color[Hexii_Ui_Tablet_Character_OBJ.Hub.Keylist["Body"][Asset]]
		var colorEmiss:Color = Hexii_Ui_Tablet_Character_OBJ.Hub.Shader_Emission[Hexii_Ui_Tablet_Character_OBJ.Hub.Keylist["Body"][Asset]]
		
		print(colorEmiss)
		
		Hexii_Ui_Tablet_Color_Container.get_node("Emiss_Color_Rect").color = colorEmiss
		Hexii_Ui_Tablet_Color_Container.get_node("Base_Color_Rect").color = color
		
		Hexii_Ui_Tablet_Color_Container.get_node("Hex_Input/LineEdit").text = str(color.to_html(false))
		Hexii_Ui_Tablet_Color_Container.get_node("Emission_Input/LineEdit").text = str(colorEmiss.to_html(false))

		Hexii_Ui_Tablet_Color_Container.get_node("E_S/LineEdit").text = str( Hexii_Ui_Tablet_Character_OBJ.Hub.Shader_Emission_Strength[Hexii_Ui_Tablet_Character_OBJ.Hub.Keylist["Body"][Asset]])
		Hexii_Ui_Tablet_Color_Container.get_node("RO/LineEdit").text = str( Hexii_Ui_Tablet_Character_OBJ.Hub.Shader_Roughness[Hexii_Ui_Tablet_Character_OBJ.Hub.Keylist["Body"][Asset]])
		Hexii_Ui_Tablet_Color_Container.get_node("M/LineEdit").text = str( Hexii_Ui_Tablet_Character_OBJ.Hub.Shader_Metallic[Hexii_Ui_Tablet_Character_OBJ.Hub.Keylist["Body"][Asset]])
		initialpress = true
		_on_color_text_change("", "Hex")
		initialpress = false
		
	else:
		Hide_part_Menus()
		$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Options.show()
		for i in $CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Options/ScrollContainer/GridContainer2.get_children():
			i.queue_free()
			
		if Core.Client.TCP.get_status() == StreamPeerTCP.STATUS_CONNECTED && (
			PartData == "Back" || 
			PartData == "Chest" || 
			PartData == "Face" || 
			PartData == "Head" || 
			PartData == "L_Hand" || 
			PartData == "R_Hand" || 
			PartData == "L_Hip" || 
			PartData == "R_Hip"
			):
			Core.Client.update_charlist()
			await Accessory_Response
			for i in Currently_Unlocked_Assets.assets_tagged[PartData]:
				generate_new_CharUI_asset(i, PartData)
		else:
			if Core.AssetData.assets_tagged.has(PartData):
				print(Core.AssetData.assets_tagged[PartData])
				for i in Core.AssetData.assets_tagged[PartData]:
					generate_new_CharUI_asset(i, PartData)
			#print(i)

func generate_new_CharUI_asset(i, PartData) -> void:
	var x:String = i
	var splitval = i.split("/")
	var New_Part = Hexii_Ui_Tablet_Character_Template_Part.duplicate()
	
	var main_texture = null
	if Core.AssetData.assets[splitval[0]]["Models"][splitval[1]].has("Image_Preview"):
		main_texture = load(Core.AssetData.assets[splitval[0]]["Models"][splitval[1]]["Image_Preview"])
	
	if main_texture != null:
		var new_main_text = main_texture.get_image()
		(new_main_text as Image).adjust_bcs(0.8,0.8,1)
		
		(New_Part as TextureButton).texture_normal = ImageTexture.create_from_image(new_main_text)
		(New_Part as TextureButton).texture_pressed = ImageTexture.create_from_image(new_main_text)
		var newtexture = main_texture.duplicate()
		var modTexture = newtexture.get_image()
		(modTexture as Image).adjust_bcs(0.9,0.9,1)
		
		var backTexture = Image.create_empty(80,80,false,Image.FORMAT_RGBA8)
		backTexture.fill(Color(.2,.2,.2,.25))
		backTexture.blend_rect(modTexture,Rect2i(0,0,80,80),Vector2i.ZERO)
		
		newtexture = ImageTexture.create_from_image(backTexture)
		(New_Part as TextureButton).texture_hover = newtexture
	
	if Core.AssetData.assets[splitval[0]]["Models"][splitval[1]].has("Name"):
		New_Part.get_node("Label").text = Core.AssetData.assets[splitval[0]]["Models"][splitval[1]]["Name"]+"."+PartData.trim_suffix("s").to_lower()
	else:
		New_Part.get_node("Label").text = "UIA"+"."+PartData.to_lower()
	#if PartData == "Ear" || PartData == "Wing" || PartData == "Extra" || PartData == "Eye" || PartData == "Tail":
		
	#var pt = Core.AssetData.assets[splitval[0]]["Models"][splitval[1]]
	#var n = PartData
	#if PartData == "Ear" || PartData == "Wing" || PartData == "Eye":
		#n = PartData+"s"
	#if (i as String).ends_with("None"):
		#New_Part.pressed.connect(change_part.bind(n,0))
	#else:
	if PartData == "Ears" || PartData == "Wings" || PartData == "Extras" || PartData == "Eyes" || PartData == "Tails":
		New_Part.pressed.connect(change_part.bind("Base_"+PartData,i))
	else:
		New_Part.pressed.connect(change_part.bind("Acc_"+PartData,i))
			
		
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Options/ScrollContainer/GridContainer2.add_child(New_Part)
	New_Part.visible = true


func _on_color_text_change(new_text:String, type:String) -> void:
	get_viewport().gui_release_focus()
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button4.show()
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button3.show()
	Hexii_Ui_Tablet_Color_Container.get_node("M/HSlider").value = clampf(float(Hexii_Ui_Tablet_Color_Container.get_node("M/LineEdit").text),0.0,1.0)
	Hexii_Ui_Tablet_Color_Container.get_node("RO/HSlider").value = clampf(float(Hexii_Ui_Tablet_Color_Container.get_node("RO/LineEdit").text),0.0,1.0)
	Hexii_Ui_Tablet_Color_Container.get_node("E_S/HSlider").value = clampf(float(Hexii_Ui_Tablet_Color_Container.get_node("E_S/LineEdit").text),0.0,1.0)
	
	if type == "Hex":
		if Hexii_Ui_Tablet_Color_Container.get_node("Hex_Input/LineEdit").text.is_valid_html_color():
			var color = Color(Hexii_Ui_Tablet_Color_Container.get_node("Hex_Input/LineEdit").text)
			Hexii_Ui_Tablet_Color_Container.get_node("R/HSlider").value = color.r8
			Hexii_Ui_Tablet_Color_Container.get_node("G/HSlider").value = color.g8
			Hexii_Ui_Tablet_Color_Container.get_node("B/HSlider").value = color.b8
			Hexii_Ui_Tablet_Color_Container.get_node("R/LineEdit").text = str(color.r8)
			Hexii_Ui_Tablet_Color_Container.get_node("G/LineEdit").text = str(color.g8)
			Hexii_Ui_Tablet_Color_Container.get_node("B/LineEdit").text = str(color.b8)
			Hexii_Ui_Tablet_Character_OBJ.Hub.Shader_Color[Hexii_Ui_Tablet_Character_OBJ.Hub.Keylist["Body"][current_colorselected]] = Color8(color.r8,color.g8,color.b8)
		
			
		if Hexii_Ui_Tablet_Color_Container.get_node("Emission_Input/LineEdit").text.is_valid_html_color():
			var color = Color(Hexii_Ui_Tablet_Color_Container.get_node("Emission_Input/LineEdit").text)
			Hexii_Ui_Tablet_Color_Container.get_node("E_R/HSlider").value = color.r8
			Hexii_Ui_Tablet_Color_Container.get_node("E_G/HSlider").value = color.g8
			Hexii_Ui_Tablet_Color_Container.get_node("E_B/HSlider").value = color.b8
			Hexii_Ui_Tablet_Color_Container.get_node("E_R/LineEdit").text = str(color.r8)
			Hexii_Ui_Tablet_Color_Container.get_node("E_G/LineEdit").text = str(color.g8)
			Hexii_Ui_Tablet_Color_Container.get_node("E_B/LineEdit").text = str(color.b8)
			Hexii_Ui_Tablet_Character_OBJ.Hub.Shader_Emission[Hexii_Ui_Tablet_Character_OBJ.Hub.Keylist["Body"][current_colorselected]] = Color8(color.r8,color.g8,color.b8)
		
	elif type == "RGB":
		var color = Color(
			int(Hexii_Ui_Tablet_Color_Container.get_node("R/LineEdit").text),
			int(Hexii_Ui_Tablet_Color_Container.get_node("G/LineEdit").text),
			int(Hexii_Ui_Tablet_Color_Container.get_node("B/LineEdit").text)
		)
		Hexii_Ui_Tablet_Color_Container.get_node("Hex_Input/LineEdit").text = color.to_html(false)
		Hexii_Ui_Tablet_Color_Container.get_node("R/HSlider").value = color.r
		Hexii_Ui_Tablet_Color_Container.get_node("G/HSlider").value = color.g
		Hexii_Ui_Tablet_Color_Container.get_node("B/HSlider").value = color.b
		Hexii_Ui_Tablet_Character_OBJ.Hub.Shader_Color[Hexii_Ui_Tablet_Character_OBJ.Hub.Keylist["Body"][current_colorselected]] = Color8(int(color.r),int(color.g),int(color.b))
		
		var colorEmiss = Color(
			int(Hexii_Ui_Tablet_Color_Container.get_node("E_R/LineEdit").text),
			int(Hexii_Ui_Tablet_Color_Container.get_node("E_G/LineEdit").text),
			int(Hexii_Ui_Tablet_Color_Container.get_node("E_B/LineEdit").text)
		)
		Hexii_Ui_Tablet_Color_Container.get_node("Emission_Input/LineEdit").text = colorEmiss.to_html(false)
		Hexii_Ui_Tablet_Color_Container.get_node("E_R/HSlider").value = colorEmiss.r
		Hexii_Ui_Tablet_Color_Container.get_node("E_G/HSlider").value = colorEmiss.g
		Hexii_Ui_Tablet_Color_Container.get_node("E_B/HSlider").value = colorEmiss.b
		Hexii_Ui_Tablet_Character_OBJ.Hub.Shader_Emission[Hexii_Ui_Tablet_Character_OBJ.Hub.Keylist["Body"][current_colorselected]] = Color8(int(colorEmiss.r),int(colorEmiss.g),int(colorEmiss.b))
		
	Hexii_Ui_Tablet_Character_OBJ.Hub.generate_colors()
	update_values() 

func _on_color_value_changed(value: float) -> void:
	if !initialpress:
		print("haoi")
		$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button4.show()
		$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button3.show()
		var Metallic = Hexii_Ui_Tablet_Color_Container.get_node("M/HSlider").value
		var Roughness = Hexii_Ui_Tablet_Color_Container.get_node("RO/HSlider").value
		
		var R = int(Hexii_Ui_Tablet_Color_Container.get_node("R/HSlider").value)
		var G = int(Hexii_Ui_Tablet_Color_Container.get_node("G/HSlider").value)
		var B = int(Hexii_Ui_Tablet_Color_Container.get_node("B/HSlider").value)
		
		var RE = int(Hexii_Ui_Tablet_Color_Container.get_node("E_R/HSlider").value)
		var GE= int(Hexii_Ui_Tablet_Color_Container.get_node("E_G/HSlider").value)
		var BE = int(Hexii_Ui_Tablet_Color_Container.get_node("E_B/HSlider").value)
		var SE = Hexii_Ui_Tablet_Color_Container.get_node("E_S/HSlider").value
		
		Hexii_Ui_Tablet_Character_OBJ.Hub.Shader_Color[Hexii_Ui_Tablet_Character_OBJ.Hub.Keylist["Body"][current_colorselected]] = Color8(R,G,B)
		Hexii_Ui_Tablet_Character_OBJ.Hub.Shader_Emission[Hexii_Ui_Tablet_Character_OBJ.Hub.Keylist["Body"][current_colorselected]] = Color8(RE,GE,BE)
		
		Hexii_Ui_Tablet_Character_OBJ.Hub.Shader_Roughness[Hexii_Ui_Tablet_Character_OBJ.Hub.Keylist["Body"][current_colorselected]] = Roughness
		Hexii_Ui_Tablet_Character_OBJ.Hub.Shader_Metallic[Hexii_Ui_Tablet_Character_OBJ.Hub.Keylist["Body"][current_colorselected]] = Metallic
		Hexii_Ui_Tablet_Character_OBJ.Hub.Shader_Emission_Strength[Hexii_Ui_Tablet_Character_OBJ.Hub.Keylist["Body"][current_colorselected]] = SE
		
		Hexii_Ui_Tablet_Character_OBJ.Hub.generate_colors()
		update_values() 

func update_values() -> void:
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button4.show()
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button3.show()
	var color:Color = Hexii_Ui_Tablet_Character_OBJ.Hub.Shader_Color[Hexii_Ui_Tablet_Character_OBJ.Hub.Keylist["Body"][current_colorselected]]
	var colorEmiss:Color = Hexii_Ui_Tablet_Character_OBJ.Hub.Shader_Emission[Hexii_Ui_Tablet_Character_OBJ.Hub.Keylist["Body"][current_colorselected]]
	
	Hexii_Ui_Tablet_Color_Container.get_node("Emiss_Color_Rect").color =  colorEmiss
	Hexii_Ui_Tablet_Color_Container.get_node("Base_Color_Rect").color =  color
		
	Hexii_Ui_Tablet_Color_Container.get_node("Hex_Input/LineEdit").text = color.to_html(false)
	Hexii_Ui_Tablet_Color_Container.get_node("Emission_Input/LineEdit").text = colorEmiss.to_html(false) 
		
	Hexii_Ui_Tablet_Color_Container.get_node("R/LineEdit").text = str(color.r8)
	Hexii_Ui_Tablet_Color_Container.get_node("G/LineEdit").text = str(color.g8)
	Hexii_Ui_Tablet_Color_Container.get_node("B/LineEdit").text = str(color.b8)
		
	Hexii_Ui_Tablet_Color_Container.get_node("E_R/LineEdit").text = str(colorEmiss.r8)
	Hexii_Ui_Tablet_Color_Container.get_node("E_G/LineEdit").text = str(colorEmiss.g8)
	Hexii_Ui_Tablet_Color_Container.get_node("E_B/LineEdit").text = str(colorEmiss.b8)
	
	Hexii_Ui_Tablet_Color_Container.get_node("E_S/LineEdit").text = str(Hexii_Ui_Tablet_Character_OBJ.Hub.Shader_Emission_Strength[Hexii_Ui_Tablet_Character_OBJ.Hub.Keylist["Body"][current_colorselected]])
	
	Hexii_Ui_Tablet_Color_Container.get_node("RO/LineEdit").text = str(Hexii_Ui_Tablet_Character_OBJ.Hub.Shader_Roughness[Hexii_Ui_Tablet_Character_OBJ.Hub.Keylist["Body"][current_colorselected]])
	Hexii_Ui_Tablet_Color_Container.get_node("M/LineEdit").text = str(Hexii_Ui_Tablet_Character_OBJ.Hub.Shader_Metallic[Hexii_Ui_Tablet_Character_OBJ.Hub.Keylist["Body"][current_colorselected]])

func _on_load_button_pressed() -> void:
	Core.AssetData.Tools.generate_character_from_string($CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Code_Loader/ScrollContainer_Color/GridContainer2/Code_Input/LineEdit.text, Hexii_Ui_Tablet_Character_OBJ.Hub)
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button4.show()
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button3.show()

func _on_export_button_pressed() -> void:
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Code_Loader/ScrollContainer_Color/GridContainer2/Code_Output/LineEdit.text = Core.AssetData.Tools.export_character(Hexii_Ui_Tablet_Character_OBJ.Hub)

func _on_namepanel_text_submitted(new_text: String, type: String) -> void:
	Hexii_Ui_Tablet_Character_OBJ.set(type, new_text)

func _on_scale_value_changed(value: float) -> void:
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button4.show()
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button3.show()
	Hexii_Ui_Tablet_Character_OBJ.Hub.Scale = value
	Hexii_Ui_Tablet_Character_OBJ.Hub.adjust_scale()
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Name_Picker/ScrollContainer_Color/GridContainer2/Scale/LineEdit.text = str(value)

func _on_scale_text_submitted(new_text: String) -> void:
	get_viewport().gui_release_focus()
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button4.show()
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button3.show()
	Hexii_Ui_Tablet_Character_OBJ.Scale = clampf(float(new_text),0.8,1.2)
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Name_Picker/ScrollContainer_Color/GridContainer2/Scale/LineEdit.text = str(Hexii_Ui_Tablet_Character_OBJ.Scale)
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Name_Picker/ScrollContainer_Color/GridContainer2/Scale/HSlider.value = Hexii_Ui_Tablet_Character_OBJ.Scale

func change_part(Core_Part:String, Part:String) -> void:
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button4.show()
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button3.show()
	Hexii_Ui_Tablet_Character_OBJ.Hub.set(Core_Part,Part)
	Hexii_Ui_Tablet_Character_OBJ.Hub.generate_character()

#################################
###### Title Screen System ######
#################################
#var Active_Hexii_Ui_Tablet_Screen_Anim = "Hexii_Ui_Tablet_NullScreen_Anim"
#@onready var Hexii_Ui_Tablet_NullScreen_Anim =  Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Panel/Null_Screen/AnimationPlayer")
#@onready var Hexii_Ui_Tablet_TitleButton =  Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Title_Bar/VBoxContainer/TitleButton")
#@onready var Hexii_Ui_Tablet_TitleScreen_Anim =  Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Panel/Title_Screen/AnimationPlayer")
#@onready var Hexii_Ui_Tablet_UpdateButton =  Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Title_Bar/VBoxContainer/UpdateButton")
#@onready var Hexii_Ui_Tablet_PlayButton =  Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Title_Bar/VBoxContainer/PlayButton")
#@onready var Hexii_Ui_Tablet_DevlogButton =   Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Title_Bar/VBoxContainer/DevlogButton")
#@onready var Hexii_Ui_Tablet_CommunityButton =   Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Title_Bar/VBoxContainer/CommunityButton")
#@onready var Hexii_Ui_Tablet_SettingsButton =   Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Title_Bar/VBoxContainer/SettingsButton")
#@onready var Hexii_Ui_Tablet_QuitButton =   Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Title_Bar/VBoxContainer/QuitButton")

func QuitButton_Pressed():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
	
func CommunityButton_Pressed():
	OS.shell_open("https://cubiixproject.xyz/") 
#################################
###### In-Game Screen System ######
#################################
@onready var Hexii_Ui_Tablet_CharacterButton =  Hexii_Ui_Tablet.get_node("Wallpaper/Control/HBoxContainer2/CharacterButton")
@onready var Hexii_Ui_Tablet_JournalButton =  Hexii_Ui_Tablet.get_node("Wallpaper/Control/HBoxContainer2/JournalButton")
#@onready var Hexii_Ui_Tablet_CharacterScreen_Anim =  Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Panel/Character_Screen/AnimationPlayer")
@onready var Hexii_Ui_Tablet_CharacterScreen =  Hexii_Ui_Tablet.get_node("Wallpaper/Character_Screen")
@onready var Hexii_Ui_Tablet_JournalScreen =  Hexii_Ui_Tablet.get_node("Wallpaper/Journal_Screen")

###################################
###### Update Checker System ######
###################################

#################################
###### Login Screen System ######
#################################
#@onready var Hexii_Ui_Tablet_LoginScreen_Anim = Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Panel/Login_Screen/AnimationPlayer")



################################
###### Server List System ######
################################
@onready var Hexii_Ui_ServerListScreen_Anim = Hexii_Ui.get_node("Overlay/Screens/ServerList_Screen/AnimationPlayer")
@onready var Hexii_Ui_ServerSelectScreen_Anim = Hexii_Ui.get_node("Overlay/Screens/ServerSelect_Screen/AnimationPlayer")

#########################
###### Character Editor System ######
#########################

#########################
###### Chat System ######
#########################
@onready var Hexii_Ui_ChatScreen_Anim = Hexii_Ui.get_node("Overlay/Screens/Chat_Screen/AnimationPlayer")
@onready var Hexii_Ui_Chat_List = Hexii_Ui.get_node("Overlay/Screens/Chat_Screen/Panel/ScrollContainer/ChatArea")
@onready var Hexii_Ui_Chat_Scroll = Hexii_Ui.get_node("Overlay/Screens/Chat_Screen/Panel/ScrollContainer")
@onready var Hexii_Ui_Chat_TextTemplate = Hexii_Ui.get_node("Overlay/Screens/Chat_Screen/Panel/Template_Text")
@onready var Hexii_Ui_Chat_TextInput = Hexii_Ui.get_node("Overlay/Screens/Chat_Screen/Panel/LineEdit")

func add_new_message(user:String, text:String) -> void:
	var template_text = "[url]>%s:[/url] %s"
	var built_message = template_text % [user, text]
	var template_object = Hexii_Ui_Chat_TextTemplate.duplicate()
	
	template_object.text = built_message
	Hexii_Ui_Chat_List.add_child(template_object)
	template_object.show()
	await get_tree().process_frame
	Hexii_Ui_Chat_Scroll.set_deferred("scroll_vertical", 99999999999999)
	

func send_text(new_text:String) -> void:
	if new_text.begins_with("/"):
		#Go To CommandParser Instead
		if new_text.begins_with("/e "):
			parse_command(new_text.lstrip("/e ").to_lower(), "Emote")
		else:
			add_new_message("[color=red]System[/color]", "[color=red]Error Invalid Command[/color]")
	else:
		if new_text.strip_edges(true, true) != "":
			add_new_message("Dusk", new_text)
	Hexii_Ui_Chat_TextInput.text = ""
	Hexii_Ui_Chat_TextInput.release_focus()

func parse_command(text:String, type:String) -> void:
	match type:
		"Emote":
			if $Node3D/Player.play_new_emote(text):
				pass
			else:
				add_new_message("[color=red]System[/color]", "[color=red]Error Unable To Emote.[/color]")


func _on_line_edit_focus_entered() -> void:
	Menu_Focused = true

func _on_line_edit_focus_exited() -> void:
	Menu_Focused = false


func _on_rich_text_label_meta_clicked(meta: Variant) -> void:
	if str(meta).begins_with("openURL, "):
		OS.shell_open("https://"+str(meta).lstrip("openURL, "))


func _on_line_edit_text_submitted(new_text: String) -> void:
	get_viewport().gui_release_focus()

var InTablet_DragArea = false
var InPhone_DragArea = false

func _on_drag_area_mouse_entered() -> void:
	InTablet_DragArea = true

func _on_drag_area_mouse_exited() -> void:
	InTablet_DragArea = false


func _on_drag_text_mouse_entered() -> void:
	InPhone_DragArea = true

func _on_drag_text_mouse_exited() -> void:
	InPhone_DragArea = false

@onready var login_username = $CanvasLayer/Hexii_Tablet_UI/Wallpaper2/Login_Screen/Login2
@onready var login_password = $CanvasLayer/Hexii_Tablet_UI/Wallpaper2/Login_Screen/Login3
@onready var login_UrlBox = $CanvasLayer/Hexii_Tablet_UI/Wallpaper2/Login_Screen/Login4

func _on_titlebutton_pressed(extra_arg_0: String) -> void:
	match extra_arg_0:
		"Single":
			Core.enable_singleplayer()
		"Social":
			OS.shell_open("https://cubiixproject.xyz/")
		"Update":
			pass
		"Continue_Login":
			if login_username.text.strip_edges(true) != "" && login_password.text.strip_edges(true) != "":
				_parse_login()
		_:
			for i in $CanvasLayer/Hexii_Tablet_UI/Wallpaper2.get_children():
				i.hide()
			if extra_arg_0 == "Back":
				get_node("CanvasLayer/Hexii_Tablet_UI/Wallpaper2/Login_Buttons").show()
			else:
				get_node("CanvasLayer/Hexii_Tablet_UI/Wallpaper2/"+extra_arg_0+"_Screen").show()

var ApiCalls = {
	"getUser":"/user/getUser", #Input:userID Header #Get
	"setUser":"/user/setUser", #Input:userID Header, userSecretCode Header #Post
	"validateToken":"/user/validateToken", #Input:userToken Header #Post
	"graphQl":"/graphql", #Input:Authorization Header
	"registerUser":"/user/registerUser" #Input:Username, Password
}



func _parse_login():
	get_node("CanvasLayer/Hexii_Tablet_UI/Wallpaper2/Login_Screen").hide()
	get_node("CanvasLayer/Hexii_Tablet_UI/Wallpaper2/Transition_Screen").show()
	var login_Query = {}
	var login_URL = ""
	var AUTH = ""
	var regex = RegEx.new()
	regex.compile("((?!-))(xn--)?[a-z0-9][a-z0-9-_]{0,61}[a-z0-9]{0,1}\\.(xn--)?([a-z0-9\\._-]{1,61}|[a-z0-9-]{1,30})")
	regex.search(login_UrlBox.text.strip_edges(true))
	var result = regex.search(login_UrlBox.text)
	
	print(result)
	
	if login_UrlBox.text.strip_edges(true) == "":
		URL = "cubiixproject.xyz"
		API_URL = "https://api."+URL
		login_Query = {
		"query" : "mutation ($username:String!, $password:String!, $strategy:String!) {authentication {login (username : $username, password : $password, strategy : $strategy){responseResult{errorCode, message}, jwt}}}",
		"variables" : {"username":login_username.text,"password":login_password.text,"strategy":"local"}
		}
		login_URL = "https://" + URL + ApiCalls["graphQl"]
		AUTH = "Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGkiOjUsImdycCI6NSwiaWF0IjoxNzMxODkyNzcwLCJleHAiOjE4MjY1NjU1NzAsImF1ZCI6InVybjpjdWJpaXhwcm9qZWN0Lnh5eiIsImlzcyI6InVybjp3aWtpLmpzIn0.AFfcQb0LMugPAcU_Gpg-vmv3O3b-Q3cAVtQRwka06Y53lzDMZCDmg7TzN1fsdI_vjbnZ2lAPKLoYB0gkYKRUpncJS9wOzZNgLrZ0Ho3Riu5K8AaUg1pHFvufGG0pjM7YHL92Cw8005dB55OrYMw67u-9ErqR68Q5qQSo3-DSwob_goTCJJ4c2kiPnomh8kE9nMV0e-_PofSoLzVfLx3fRdYoi8LUTgpdISpKmGMEO1E4nu2lL1Jk1E7JyzY5-VYfeyBsVBoUKiDAkECCfA9_3yqGW3DwuGVh2oL9-SqebuougopbeWuPOyw5cQ9c97OU3bAe01QS_CEh4eVFV3L8QQ"
		var json = JSON.new()
		Login_Signin.request(login_URL,
			[AUTH,"Content-Type: application/json"]
			,HTTPClient.METHOD_POST,
			json.stringify(login_Query))

	elif result:
		URL = login_UrlBox.text.to_lower()
		API_URL = "https://api."+URL
		login_URL = "https://api."+URL+ ApiCalls["validateToken"]
		API_Validate.request(login_URL,["userName:"+login_username.text,"userPassword:"+login_password.text,
			"Content-Type: application/json"]
			,HTTPClient.METHOD_POST,"")
	else:
		Core.Persistant_Core.show_error("Error: Direct IP/ Localhost Not Valid Domain.")
		Core.Persistant_Core.show_last_room_before_error(0)
		#URL = login_UrlBox.text.to_lower()
		#login_URL = "http://"+URL+ ApiCalls["validateToken"]
		#API_URL = "http://"+URL
		#API_Validate.request(login_URL,["userName:"+login_username.text,"userPassword:"+login_password.text,
			#"Content-Type: application/json"]
			#,HTTPClient.METHOD_POST,"")
var jwt 
##This login card is specific to my wiki setup, not external auths
func login_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	print(response)
	var login_URL = ""
	if response != null:
		if response.has("data"):
			if response["data"]["authentication"]["login"]["responseResult"]["errorCode"] != 0:
				Core.Persistant_Core.show_error("Error: User Login Error.")
				Core.Persistant_Core.show_last_room_before_error(0)
				#Hexii_Login_LoginText.text =  "[center][color=red]"  + response["data"]["authentication"]["login"]["responseResult"]["message"]
			else:
				login_URL = API_URL+ ApiCalls["validateToken"]
				print(login_URL)
				jwt = response["data"]["authentication"]["login"]["jwt"]
				
				API_Validate.request(login_URL,["userToken: "+jwt,
				"Content-Type: application/json"]
				,HTTPClient.METHOD_POST,"")
				tryreset = true
				
				#Hexii_Login_LoginText.text =  "[center][color=green]"  + response["data"]["authentication"]["login"]["responseResult"]["message"]
		elif response.has("status"):
			if response["status"] == 0:
				pass
			else:
				Core.Persistant_Core.show_error("Error: User Login Error.")
				Core.Persistant_Core.show_last_room_before_error(0)
		else:
			Core.Persistant_Core.show_error("Error: No Server Response.")
			Core.Persistant_Core.show_last_room_before_error(0)
	else:
		Core.Persistant_Core.show_error("Error: Check SSL Cert.")
		Core.Persistant_Core.show_last_room_before_error(0)

var tryreset = true

func api_validate_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	print(response)
	print("api Completed!")
	if response != null:
		if response["status"] == 0:
			#if URL.to_lower().begins_with("localhost"):
				#var upnp = UPNP.new()
				#upnp.discover(2000, 2, "InternetGatewayDevice")
				#Core.Globals.LocalUser["Username"] = str(response["userID"])+"@"+str(upnp.query_external_address())
			#else:
			Core.Globals.LocalUser["Username"] = str(response["userID"]).to_lower()
			Core.Globals.LocalUser["UserSecretCode"] = response["userSecretCode"]
			Core.Globals.LocalUser["URL"] = URL.to_lower()
			Core.Client.network_ping($CanvasLayer/Hexii_Tablet_UI/Wallpaper2/ServerList_Screen/Preview/Panel/VBoxContainer.get_children())
			$CanvasLayer/Hexii_Tablet_UI/Wallpaper2/ServerList_Screen.show()
			$CanvasLayer/Hexii_Tablet_UI/Wallpaper2/Transition_Screen.hide()
		elif response["status"] == 2 && tryreset:
			await get_tree().create_timer(1).timeout
			tryreset = false
			var login_URL = API_URL+ ApiCalls["validateToken"]
			API_Validate.request(login_URL,["userToken: "+jwt,
			"Content-Type: application/json"]
			,HTTPClient.METHOD_POST,"")
		else:
			Core.Persistant_Core.show_error("Error: User Failed To Validate.")
			Core.Persistant_Core.show_last_room_before_error(0)

func _on_register_link_button_pressed() -> void:
	var login_Query = {}
	var login_URL = ""
	var AUTH = ""
	var regex = RegEx.new()
	regex.compile("((?!-))(xn--)?[a-z0-9][a-z0-9-_]{0,61}[a-z0-9]{0,1}\\.(xn--)?([a-z0-9\\._-]{1,61}|[a-z0-9-]{1,30})")
	regex.search(login_UrlBox.text.strip_edges(true))
	var result = regex.search(login_UrlBox.text)

	loading_server()
	
	if login_UrlBox.text.strip_edges(true) == "":
		URL = "cubiixproject.xyz"
		API_URL = "https://api."+URL
		login_URL = "https://" + URL + ApiCalls["graphQl"]
		AUTH = "Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGkiOjUsImdycCI6NSwiaWF0IjoxNzMxODkyNzcwLCJleHAiOjE4MjY1NjU1NzAsImF1ZCI6InVybjpjdWJpaXhwcm9qZWN0Lnh5eiIsImlzcyI6InVybjp3aWtpLmpzIn0.AFfcQb0LMugPAcU_Gpg-vmv3O3b-Q3cAVtQRwka06Y53lzDMZCDmg7TzN1fsdI_vjbnZ2lAPKLoYB0gkYKRUpncJS9wOzZNgLrZ0Ho3Riu5K8AaUg1pHFvufGG0pjM7YHL92Cw8005dB55OrYMw67u-9ErqR68Q5qQSo3-DSwob_goTCJJ4c2kiPnomh8kE9nMV0e-_PofSoLzVfLx3fRdYoi8LUTgpdISpKmGMEO1E4nu2lL1Jk1E7JyzY5-VYfeyBsVBoUKiDAkECCfA9_3yqGW3DwuGVh2oL9-SqebuougopbeWuPOyw5cQ9c97OU3bAe01QS_CEh4eVFV3L8QQ"
		login_Query = {
			"query" : "mutation ($email:String!, $name:String!,$passwordRaw:String!, $providerKey:String!, $groups:[Int]!, $sendWelcomeEmail:Boolean!){ users{ create(email: $email, name:$name, passwordRaw: $passwordRaw ,providerKey:$providerKey, groups:$groups, sendWelcomeEmail: $sendWelcomeEmail){ responseResult{succeeded slug message} user{id}}}}",
			"variables": {"email": login_username.text, "name": login_username.text,"passwordRaw":login_password.text ,"providerKey": "local" ,  "groups": [3] ,"sendWelcomeEmail":false}
		}
		var json = JSON.new()
		await get_tree().create_timer(1).timeout
		Login_Create.request(login_URL,[AUTH,
		"Content-Type: application/json"]
		,HTTPClient.METHOD_POST,
		json.stringify(login_Query))
	elif result:
		URL = login_UrlBox.text.to_lower()
		login_URL = "https://"+URL+ApiCalls["registerUser"]
		API_URL = "https://api."+URL
		Login_Create.request(login_URL,["userName:"+login_username.text,"userPassword:"+login_password.text,
			"Content-Type: application/json"]
			,HTTPClient.METHOD_POST,"")
	else:# login_UrlBox.text.strip_edges(true).to_lower().begins_with("localhost"):
		Core.Persistant_Core.show_error("Error: Direct IP/ Localhost Not Valid Domain.")
		Core.Persistant_Core.show_last_room_before_error(0)
		#URL = login_UrlBox.text.to_lower()
		#login_URL = "http://"+URL+ApiCalls["registerUser"]
		#API_URL = "http://"+URL
		#Login_Create.request(login_URL,["userName:"+login_username.text,"userPassword:"+login_password.text,
			#"Content-Type: application/json"]
			#,HTTPClient.METHOD_POST,"")

func register_request_completed(result, response_code, headers, body):
	#print(result)
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	print(response)
	if response.has("data"):
		if response["data"]["users"]["create"].has("responseResult"):
			if response["data"]["users"]["create"]["responseResult"]["succeeded"] != true:
				Core.Persistant_Core.show_error("Error: Failed To Register User.")
				Core.Persistant_Core.show_last_room_before_error(0)
				#Register_Text.text =  "[center][color=red]"  + response["data"]["users"]["create"]["responseResult"]["message"]
			else:
				_parse_login()
				#Register_Text.text =  "[center][color=green]"  + response["data"]["users"]["create"]["responseResult"]["message"] +"\n Please return to login."
	elif response.has("status"):
		if response["status"] == 0:
			_parse_login()
		else:
			Core.Persistant_Core.show_error("Error: Failed To Register User.")
			Core.Persistant_Core.show_last_room_before_error(0)
			
##################################
###### Audio Manager System ######
##################################
var LastSong = ""
var SongList = {
	"FishShop":"res://Assets/Audio/World/FishinForCubes.ogg",
	"Trinket":"res://Assets/Audio/World/Trinket.ogg"
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

func show_error(Error:String):
	$CanvasLayer/Hexii_Tablet_UI.show()                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper.hide()
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper2.show()
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper2/Login_Screen.hide()
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper2/ServerList_Screen.hide()
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper2/Devlog_Screen.hide()
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper2/Settings_Screen.hide()
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper2/Transition_Screen.show()
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper2/Transition_Screen/Error.show()
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper2/Transition_Screen/Error/RichTextLabel.text = "\n\n[center][color=red]"+Error+"\n\nPlease report in the discord if error persists."
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper2/Transition_Screen/Back.show()
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper2/Login_Buttons.hide()

func loading_server():
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper2/ServerList_Screen.hide()
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper2/Transition_Screen.show()

var panelcode = 0

func show_last_room_before_error(code:int):
	panelcode = code
	

func _on_transition_back_pressed() -> void:
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper2/Transition_Screen/Back.hide()
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper2/Transition_Screen/Error.hide()
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper2/Transition_Screen.hide()
	
	match panelcode:
		0:
			$CanvasLayer/Hexii_Tablet_UI/Wallpaper2/Login_Screen.show()
		1:
			$CanvasLayer/Hexii_Tablet_UI/Wallpaper2/ServerList_Screen.show()
		_:
			$CanvasLayer/Hexii_Tablet_UI/Wallpaper2/Login_Buttons.show()

func show_play_screen() -> void:
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper.show()
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper2.hide()
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper2/Transition_Screen.hide()
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper2/ServerList_Screen.show()

#############################
###### Dialogue System ######
#############################
@onready var Dialogue = $CanvasLayer/Dialogue

func run_dialogue(LineStart:Array) -> void:
	pass
