extends Node
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

@onready var Dialogue = $CanvasLayer/Dialogue
@onready var Transitioner = $CanvasLayer/Transitioner
@onready var Transitioner_AnimationPlayer = Transitioner.get_node("AnimationPlayer")
var Mouse_In_UI = false
var Menu_Focused = false
@onready var Player = $Node3D/Player

var windowLocations = {
	"Character_Screen": Vector2(61,202),
	"Journal_Screen": Vector2(199,202)
}
func _ready() -> void:
###### Signal Connections ######
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
	
	await Player.MeshFinished
	
	Hexii_Ui_Tablet_JournalButton.emit_signal("pressed")
	
	ApplyParts(Hexii_Ui_Tablet_Character,Player)
			
	
	


	V1_ConversionPath = {
	"Cubiix_Base:Cat_Ears":Player.EAR_ENUM.Cat,
	"Cubiix_Base:Fox_Ears":Player.EAR_ENUM.Fox,
	"Cubiix_Base:Mouse_Ears":Player.EAR_ENUM.Mouse,
	"Cubiix_Base:Bee_Ears":Player.EAR_ENUM.Bee,
	"Cubiix_Base:Bunny_Ears":Player.EAR_ENUM.Bunny,
	"Cubiix_Base:Deer_Ears":Player.EAR_ENUM.Deer,
	"Cubiix_Base:Dog_Ears":Player.EAR_ENUM.Dog,
	"Cubiix_Base:Fluffy_Ears":Player.EAR_ENUM.Fluffy,
	"Cubiix_Base:Entity_Ears":Player.EAR_ENUM.Entity,
	"Cubiix_Base:Moth1_Ears":Player.EAR_ENUM.Moth,
	"Cubiix_Base:Moth2_Ears":Player.EAR_ENUM.Moth,
	"Cubiix_Base:Alien_Ears":Player.EAR_ENUM.Alien,
	"Cubiix_Base:Wolf_Ears":Player.EAR_ENUM.Wolf,
	"Cubiix_Base:Goat_Ears":Player.EAR_ENUM.Goat,
	
	"Cubiix_Base:Shark_Fin":Player.EXTRA_ENUM.Shark,
	"Cubiix_Base:Dragon_Extra":Player.EXTRA_ENUM.Dragon,
	"Cubiix_Base:Narwal_Extra":Player.EXTRA_ENUM.Narwhal,
	"Cubiix_Base:Deer_Extra":Player.EXTRA_ENUM.Nub,
	"Cubiix_Base:Antlers_Extra":Player.EXTRA_ENUM.Antler,
	"Cubiix_Base:Fish_Extra":Player.EXTRA_ENUM.Fish,
	"Cubiix_Base:Ram_Extra":Player.EXTRA_ENUM.Ram,
	
	"Cubiix_Base:Cat_Tail":Player.TAIL_ENUM.Cat,
	"Cubiix_Base:Fox_Tail":Player.TAIL_ENUM.Fox,
	"Cubiix_Base:Mouse_Tail":Player.TAIL_ENUM.Mouse,
	"Cubiix_Base:Shark_Tail":Player.TAIL_ENUM.Shark,
	"Cubiix_Base:Bee_Tail":Player.TAIL_ENUM.Bee,
	"Cubiix_Base:Bunny_Tail":Player.TAIL_ENUM.Bunny,
	"Cubiix_Base:Dragon_Tail":Player.TAIL_ENUM.Dragon,
	"Cubiix_Base:Deer_Tail":Player.TAIL_ENUM.Deer,
	"Cubiix_Base:Dog_Tail":Player.TAIL_ENUM.Dog,
	"Cubiix_Base:Fluffy_Tail":Player.TAIL_ENUM.Fluffy,
	"Cubiix_Base:Moth_Tail":Player.TAIL_ENUM.Moth,
	"Cubiix_Base:Entity_Tail":Player.TAIL_ENUM.Entity,
	"Cubiix_Base:Bug_Tail":Player.TAIL_ENUM.Bug,
	"Cubiix_Base:Wolf_Tail":Player.TAIL_ENUM.Wolf,
	
	"Cubiix_Base:Entity_Wings":Player.WING_ENUM.Entity,
	"Cubiix_Base:Bee_Wings":Player.WING_ENUM.Wasp,
	"Cubiix_Base:Dragon_Wings":Player.WING_ENUM.Dragon,
	"Cubiix_Base:Angel_Wings":Player.WING_ENUM.Angel,
	"Cubiix_Base:Moth_Wings":Player.WING_ENUM.Butterfly,
	"Cubiix_Base:Butterfly_Wings":Player.WING_ENUM.Butterfly,
	
	"Cubiix_Base:Default_Eyes":Player.EYE_ENUM.Default,
	"Cubiix_Base:Nat_Eyes":Player.EYE_ENUM.Nat,
	"Cubiix_Base:Triangle_Eyes":Player.EYE_ENUM.Tri,
	"Cubiix_Base:Circle_Eyes":Player.EYE_ENUM.Circle,
	"Cubiix_Base:Mouse_Eyes":Player.EYE_ENUM.Mouse,
	"Cubiix_Base:Text_Eyes":Player.EYE_ENUM.Text,
	"Cubiix_Base:Fox_Eyes":Player.EYE_ENUM.Fox,
	"Cubiix_Base:Four_Eyes":Player.EYE_ENUM.Four,
	"Cubiix_Base:Chonk_Eyes":Player.EYE_ENUM.Chonk,
	"Cubiix_Base:Entity_Eyes":Player.EYE_ENUM.Entity,
	
	"Cubiix_Base:Empty_Socket":0
	}

	V2_ConversionPath = {
		"Ears":{
			"None":0,
			"Fox":Player.EAR_ENUM.Fox,
			"Wolf":Player.EAR_ENUM.Wolf,
			"Goat":Player.EAR_ENUM.Goat,
			"Bee":Player.EAR_ENUM.Bee,
			"Cat":Player.EAR_ENUM.Cat,
			"Moth":Player.EAR_ENUM.Moth,
			"Moth2":Player.EAR_ENUM.Moth,
			"Mouse":Player.EAR_ENUM.Mouse,
			"Alien":Player.EAR_ENUM.Alien,
			"Deer":Player.EAR_ENUM.Deer,
			"Entity":Player.EAR_ENUM.Entity,
			"Dog":Player.EAR_ENUM.Dog,
			"Bunny":Player.EAR_ENUM.Bunny,
			"Fluffy":Player.EAR_ENUM.Fluffy
		},
		"Extra":{
			"None":0,
			"Shark":Player.EXTRA_ENUM.Shark,
			"Antler":Player.EXTRA_ENUM.Antler,
			"Ram":Player.EXTRA_ENUM.Ram,
			"Fish":Player.EXTRA_ENUM.Fish,
			"Narlwal":Player.EXTRA_ENUM.Narwhal,
			"Dragon":Player.EXTRA_ENUM.Dragon,
			"Nub":Player.EXTRA_ENUM.Nub
		},
		"Eyes":{
			"Chonk":Player.EYE_ENUM.Chonk,
			"Tri":Player.EYE_ENUM.Tri,
			"Nat":Player.EYE_ENUM.Nat,
			"Default":Player.EYE_ENUM.Default,
			"Circle":Player.EYE_ENUM.Circle,
			"Fox":Player.EYE_ENUM.Fox,
			"Mouse":Player.EYE_ENUM.Nat,
			"Four":Player.EYE_ENUM.Four,
			"Entity":Player.EYE_ENUM.Entity,
			"Text":Player.EYE_ENUM.Text
		},
		"Tail":{
			"None":0,
			"Fox":Player.TAIL_ENUM.Fox,
			"Wolf":Player.TAIL_ENUM.Wolf,
			"Bug":Player.TAIL_ENUM.Bug,
			"Bee":Player.TAIL_ENUM.Bee,
			"Moth":Player.TAIL_ENUM.Moth,
			"Dog":Player.TAIL_ENUM.Dog,
			"Mouse":Player.TAIL_ENUM.Mouse,
			"Fluffy":Player.TAIL_ENUM.Fluffy,
			"Cat":Player.TAIL_ENUM.Cat,
			"Shark":Player.TAIL_ENUM.Shark,
			"Entity":Player.TAIL_ENUM.Entity,
			"Bunny":Player.TAIL_ENUM.Bunny,
			"Deer":Player.TAIL_ENUM.Deer,
			"Dragon":Player.TAIL_ENUM.Dragon
		},
		"Wings":{
			"None":0,
			"Entity":Player.WING_ENUM.Entity,
			"Angel":Player.WING_ENUM.Angel,
			"Butterfly":Player.WING_ENUM.Butterfly,
			"Bee":Player.WING_ENUM.Wasp,
			"Dragon":Player.WING_ENUM.Dragon,
			"Moth":Player.WING_ENUM.Butterfly
		}
	}
	

func SpawnAt(Location:Vector3,Rotation:Vector3) -> void:
	$Node3D/Player.position = Location
	$Node3D/Player.CameraLength = -4.0
	$Node3D/Player/Hub.rotation = Rotation
	$Node3D/Core_Follow/Rot_Y.rotation = Rotation
	$Node3D/Core_Follow/Rot_Y/Rot_X.rotation = Vector3(deg_to_rad(15),0,0)
	
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
#############################
###### Hexii UI System ######
#############################
@onready var Hexii_Ui = $CanvasLayer/Hexii_UI
@onready var Hexii_Ui_Anim = Hexii_Ui.get_node("Overlay/AnimationPlayer")
@onready var Hexii_Ui_NullScreen_Anim =  Hexii_Ui.get_node("Overlay/Screens/Null_Screen/AnimationPlayer")

@onready var Hexii_Ui_Tablet = $CanvasLayer/Hexii_Tablet_UI
@onready var Hexii_Ui_Tablet_DevlogScreen_Anim = Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Panel/Devlog_Screen/AnimationPlayer")
@onready var Hexii_Ui_Tablet_SettingsScreen_Anim = Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Panel/Settings_Screen/AnimationPlayer")
@onready var Hexii_Ui_Tablet_Character = Hexii_Ui_Tablet.get_node("Wallpaper/Character_Screen/SubViewportContainer/SubViewport/Character_Editor/Cubiix_Base")

func _on_area_2d_mouse_entered() -> void:
	Mouse_In_UI = true

func _on_area_2d_mouse_exited() -> void:
	Mouse_In_UI = false


var IsInBounds = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("shiftlock"):
		$CanvasLayer/CrossHair.visible = !$CanvasLayer/CrossHair.visible

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

func ApplyParts(A,B)-> void:
	A.Eyes = B.Eyes
	A.Ears = B.Ears 
	A.Extra = B.Extra 
	A.Tail = B.Tail 
	A.Wings = B.Wings

	A.Head = B.Head 
	A.Chest = B.Chest 
	A.Back = B.Back

	A.Body_1 = B.Body_1 
	A.Body_2 = B.Body_2
	A.Body_3 = B.Body_3 
	A.Body_4 = B.Body_4

	A.Body_1_Emiss = B.Body_1_Emiss
	A.Body_2_Emiss = B.Body_2_Emiss
	A.Body_3_Emiss = B.Body_3_Emiss
	A.Body_4_Emiss = B.Body_4_Emiss
	
	A.Body_1_Emiss_S  = B.Body_1_Emiss_S 
	A.Body_2_Emiss_S  = B.Body_2_Emiss_S 
	A.Body_3_Emiss_S  = B.Body_3_Emiss_S 
	A.Body_4_Emiss_S  = B.Body_4_Emiss_S 
	
	A.Body_1_Roughness = B.Body_1_Roughness
	A.Body_2_Roughness = B.Body_2_Roughness
	A.Body_3_Roughness = B.Body_3_Roughness
	A.Body_4_Roughness = B.Body_4_Roughness
	
	A.Body_1_Metallic  = B.Body_1_Metallic 
	A.Body_2_Metallic  = B.Body_2_Metallic 
	A.Body_3_Metallic  = B.Body_3_Metallic 
	A.Body_4_Metallic  = B.Body_4_Metallic 
	
	A.Scale  = B.Scale
	A.Name  = B.Name
	
	A.Pronouns_A  = B.Pronouns_A
	A.Pronouns_B  = B.Pronouns_B
	A.Pronouns_C  = B.Pronouns_C
	
	A.Regen_Character()

func Hide_part_Menus()-> void:
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Color_Picker.hide()
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Options.hide()
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Name_Picker.hide()
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Code_Loader.hide()

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
				ApplyParts(Player,Hexii_Ui_Tablet_Character)
				
			"Revert":
				$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button4.hide()
				$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button3.hide()
				ApplyParts(Hexii_Ui_Tablet_Character,Player)
		
	elif PartData.begins_with("Color, "):
		var Asset = PartData.lstrip("Color, ")
		Hide_part_Menus()
		$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Color_Picker.show()
		current_colorselected = Asset
		
		var color:Color = Hexii_Ui_Tablet_Character_OBJ.get(Asset)
		var colorEmiss:Color = Hexii_Ui_Tablet_Character_OBJ.get(Asset+"_Emiss")
		
		print(colorEmiss)
		
		Hexii_Ui_Tablet_Color_Container.get_node("Emiss_Color_Rect").color = colorEmiss
		Hexii_Ui_Tablet_Color_Container.get_node("Base_Color_Rect").color = color
		
		Hexii_Ui_Tablet_Color_Container.get_node("Hex_Input/LineEdit").text = str(color.to_html(false))
		Hexii_Ui_Tablet_Color_Container.get_node("Emission_Input/LineEdit").text = str(colorEmiss.to_html(false))

		Hexii_Ui_Tablet_Color_Container.get_node("E_S/LineEdit").text = str(Hexii_Ui_Tablet_Character_OBJ.get(Asset+"_Emiss_S"))
		Hexii_Ui_Tablet_Color_Container.get_node("RO/LineEdit").text = str(Hexii_Ui_Tablet_Character_OBJ.get(Asset+"_Roughness"))
		Hexii_Ui_Tablet_Color_Container.get_node("M/LineEdit").text = str(Hexii_Ui_Tablet_Character_OBJ.get(Asset+"_Metallic"))
		initialpress = true
		_on_color_text_change("", "Hex")
		initialpress = false
		
	else:
		Hide_part_Menus()
		$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Options.show()
		for i in $CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Options/ScrollContainer/GridContainer2.get_children():
			i.queue_free()

		for i in Core.AssetData.get(PartData+"_Slot"):
			var x:String = i
			var New_Part = Hexii_Ui_Tablet_Character_Template_Part.duplicate()
			
			var main_texture = null
			
			if i == "":
				if PartData != "Extra":
					i = PartData+"s/None"
					main_texture = load("res://Assets/Textures/UI/In-Game/Tablet_Themes/Icons/Item_Previews/"+PartData+"s/"+i.replace("/","_")+".png")
				else:
					i = PartData+"/None"
					main_texture = load("res://Assets/Textures/UI/In-Game/Tablet_Themes/Icons/Item_Previews/"+PartData+"/"+i.replace("/","_")+".png")
			else:
				if PartData != "Extra":
					main_texture = load("res://Assets/Textures/UI/In-Game/Tablet_Themes/Icons/Item_Previews/"+PartData+"s/"+x.replace("/","_")+".png")
				else:
					main_texture = load("res://Assets/Textures/UI/In-Game/Tablet_Themes/Icons/Item_Previews/"+PartData+"/"+x.replace("/","_")+".png")
			
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
				
			if (i as String).ends_with("None"):
				New_Part.get_node("Label").text = "None."+PartData.to_lower()
			else:
				New_Part.get_node("Label").text = Core.AssetData.Mesh_Data_Assets[i]["Name"]+"."+PartData.to_lower()
				
			#if PartData == "Ear" || PartData == "Wing" || PartData == "Extra" || PartData == "Eye" || PartData == "Tail":
				
			var pt = Core.AssetData.get(PartData+"_Slot")
			var n = PartData
			if PartData == "Ear" || PartData == "Wing" || PartData == "Eye":
				n = PartData+"s"
			if (i as String).ends_with("None"):
				New_Part.pressed.connect(change_part.bind(n,0))
			else:
				New_Part.pressed.connect(change_part.bind(n,pt.find(i)))
					
				
			$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Options/ScrollContainer/GridContainer2.add_child(New_Part)
			New_Part.visible = true
			#print(i)

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
			Hexii_Ui_Tablet_Character_OBJ.set(current_colorselected,Color8(color.r8,color.g8,color.b8))
		
			
	if Hexii_Ui_Tablet_Color_Container.get_node("Emission_Input/LineEdit").text.is_valid_html_color():
			var color = Color(Hexii_Ui_Tablet_Color_Container.get_node("Emission_Input/LineEdit").text)
			Hexii_Ui_Tablet_Color_Container.get_node("E_R/HSlider").value = color.r8
			Hexii_Ui_Tablet_Color_Container.get_node("E_G/HSlider").value = color.g8
			Hexii_Ui_Tablet_Color_Container.get_node("E_B/HSlider").value = color.b8
			Hexii_Ui_Tablet_Color_Container.get_node("E_R/LineEdit").text = str(color.r8)
			Hexii_Ui_Tablet_Color_Container.get_node("E_G/LineEdit").text = str(color.g8)
			Hexii_Ui_Tablet_Color_Container.get_node("E_B/LineEdit").text = str(color.b8)
			Hexii_Ui_Tablet_Character_OBJ.set(current_colorselected+"_Emiss",Color8(color.r8,color.g8,color.b8))
		
	elif type == "RGB":
		var color = Color(
			int(Hexii_Ui_Tablet_Color_Container.get_node("R/LineEdit").text),
			int(Hexii_Ui_Tablet_Color_Container.get_node("G/LineEdit").text),
			int(Hexii_Ui_Tablet_Color_Container.get_node("B/LineEdit").text)
		)
		Hexii_Ui_Tablet_Color_Container.get_node("Hex_Input/LineEdit").text = color.to_html(false)
		Hexii_Ui_Tablet_Color_Container.get_node("R/HSlider").value = color.r8
		Hexii_Ui_Tablet_Color_Container.get_node("G/HSlider").value = color.g8
		Hexii_Ui_Tablet_Color_Container.get_node("B/HSlider").value = color.b8
		Hexii_Ui_Tablet_Character_OBJ.set(current_colorselected,Color8(color.r8,color.g8,color.b8))
		
		var colorEmiss = Color(
			int(Hexii_Ui_Tablet_Color_Container.get_node("E_R/LineEdit").text),
			int(Hexii_Ui_Tablet_Color_Container.get_node("E_G/LineEdit").text),
			int(Hexii_Ui_Tablet_Color_Container.get_node("E_B/LineEdit").text)
		)
		Hexii_Ui_Tablet_Color_Container.get_node("Emission_Input/LineEdit").text = colorEmiss.to_html(false)
		Hexii_Ui_Tablet_Color_Container.get_node("E_R/HSlider").value = colorEmiss.r8
		Hexii_Ui_Tablet_Color_Container.get_node("E_G/HSlider").value = colorEmiss.g8
		Hexii_Ui_Tablet_Color_Container.get_node("E_B/HSlider").value = colorEmiss.b8
		Hexii_Ui_Tablet_Character_OBJ.set(current_colorselected+"_Emiss",Color8(color.r8,color.g8,color.b8))
		
	Hexii_Ui_Tablet_Character_OBJ.Regen_Color()

func _on_color_value_changed(value: float) -> void:
	if !initialpress:
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
		
		Hexii_Ui_Tablet_Character_OBJ.set(current_colorselected,Color8(R,G,B))
		Hexii_Ui_Tablet_Character_OBJ.set(current_colorselected+"_Emiss",Color8(RE,GE,BE))
		
		Hexii_Ui_Tablet_Character_OBJ.set(current_colorselected+"_Roughness",Roughness)
		Hexii_Ui_Tablet_Character_OBJ.set(current_colorselected+"_Metallic",Metallic)
		Hexii_Ui_Tablet_Character_OBJ.set(current_colorselected+"_Emiss_S",SE)
		
		Hexii_Ui_Tablet_Character_OBJ.Regen_Color()
		update_values() 

func update_values() -> void:
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button4.show()
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button3.show()
	var color:Color = Hexii_Ui_Tablet_Character_OBJ.get(current_colorselected)
	var colorEmiss:Color = Hexii_Ui_Tablet_Character_OBJ.get(current_colorselected+"_Emiss")
	
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
	
	Hexii_Ui_Tablet_Color_Container.get_node("E_S/LineEdit").text = str(Hexii_Ui_Tablet_Character_OBJ.get(current_colorselected+"_Emiss_S"))
	
	Hexii_Ui_Tablet_Color_Container.get_node("RO/LineEdit").text = str(Hexii_Ui_Tablet_Character_OBJ.get(current_colorselected+"_Roughness"))
	Hexii_Ui_Tablet_Color_Container.get_node("M/LineEdit").text = str(Hexii_Ui_Tablet_Character_OBJ.get(current_colorselected+"_Metallic"))

var V1_Keywords = [
	"EarID",
	"ExtraID",
	"EyeCol",
	"EyeID",
	"GlowCol",
	"Height",
	"PrimCol",
	"TailID",
	"WingID",
	"WireCol",
	"WireInnerCol"
	]
	
var V2_Keywords = [
	"Color_Body",
	"Color_BodyGlow",
	"Color_Eye_1",
	"Color_Eye_2",
	"Ears",
	"Extra",
	"Eyes",
	"Size",
	"Tail",
	"Wings"
	]
	
var V3_Keywords = [
	"B1",
	"B2",
	"B3",
	"B4",
	"B1E",
	"B2E",
	"B3E",
	"B4E",
	"B1ES",
	"B2ES",
	"B3ES",
	"B4ES",
	"B1R",
	"B2R",
	"B3R",
	"B4R",
	"B1M",
	"B2M",
	"B3M",
	"B4M",
	"T",
	"W",
	"EA",
	"EX",
	"EY",
	"S",
	"N",
	"PA",
	"PB",
	"PC"
	]

##Since paths changed, we need to have a lookup index!
var V1_ConversionPath = {}

var V2_ConversionPath = {}

func _on_load_button_pressed() -> void:
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Code_Loader/ScrollContainer_Color/GridContainer2/ErrorLog.text = ""
	var json = JSON.new()
	json.parse($CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Code_Loader/ScrollContainer_Color/GridContainer2/Code_Input/LineEdit.text)
	
	var data = json.data
	var keyversion = 0
	
	if data == null:
		data = str_to_var($CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Code_Loader/ScrollContainer_Color/GridContainer2/Code_Input/LineEdit.text)

	if typeof(data) == TYPE_DICTIONARY:
		
		if keyversion == 0:
			for i in V1_Keywords:
				if data.has(i):
					keyversion = 1
					break
		if keyversion == 0:
			for i in V2_Keywords:
				if data.has(i):
					keyversion = 2
					break
					
		if keyversion == 0:
			for i in V3_Keywords:
				if data.has(i):
					keyversion = 3
					break
		
		
		match keyversion:
			1:
				$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button4.show()
				$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button3.show()
				print("Version 1 Save!")
				Hexii_Ui_Tablet_Character_OBJ.Body_1_Roughness = 1
				Hexii_Ui_Tablet_Character_OBJ.Body_2_Roughness = 1
				Hexii_Ui_Tablet_Character_OBJ.Body_3_Roughness = 1
				Hexii_Ui_Tablet_Character_OBJ.Body_4_Roughness = 1
				
				Hexii_Ui_Tablet_Character_OBJ.Body_1_Metallic = 1
				Hexii_Ui_Tablet_Character_OBJ.Body_2_Metallic = 1
				Hexii_Ui_Tablet_Character_OBJ.Body_3_Metallic = 1
				Hexii_Ui_Tablet_Character_OBJ.Body_4_Metallic = 1
				for i in data.keys():
					match i:
						"EarID":
							if V1_ConversionPath.keys().has(data["EarID"]):
								if V1_ConversionPath.keys().has(data["ExtraID"]):
									if data["EarID"] == "Cubiix_Base:Shark_Fin" && data["ExtraID"] != "Cubiix_Base:Empty_Socket" :
										$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Code_Loader/ScrollContainer_Color/GridContainer2/ErrorLog.text += "[color=red]Error: Extra Overlap (Sharkfin), Defaulting To ExtraID Value...\n"
						
								Hexii_Ui_Tablet_Character_OBJ.Ears = V1_ConversionPath[data["EarID"]]
						"ExtraID":
							if V1_ConversionPath.keys().has(data["ExtraID"]):
								Hexii_Ui_Tablet_Character_OBJ.Extra = V1_ConversionPath[data["ExtraID"]]
						"EyeCol":
							if data["EyeCol"] is Color:
								Hexii_Ui_Tablet_Character_OBJ.Body_3 = Color(0,0,0,1)
								Hexii_Ui_Tablet_Character_OBJ.Body_4 = Color(0,0,0,1)
								Hexii_Ui_Tablet_Character_OBJ.Body_3_Emiss = Color(data["EyeCol"].to_html(false))
								Hexii_Ui_Tablet_Character_OBJ.Body_4_Emiss = Color(data["EyeCol"].to_html(false))
								Hexii_Ui_Tablet_Character_OBJ.Body_3_Emiss_S = 1.0
								Hexii_Ui_Tablet_Character_OBJ.Body_4_Emiss_S = 1.0
						"EyeID":
							if V1_ConversionPath.keys().has(data["EyeID"]):
								Hexii_Ui_Tablet_Character_OBJ.Eyes = V1_ConversionPath[data["EyeID"]]
						"GlowCol":
							$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Code_Loader/ScrollContainer_Color/GridContainer2/ErrorLog.text += "[color=red]Error: GlowCol Defunct.\n"
						"Height":
							Hexii_Ui_Tablet_Character_OBJ.Scale = clampf(float(data["Height"])+ 1.0, 0.8, 1.2)
						"PrimCol":
							if data["PrimCol"] is Color:
								Hexii_Ui_Tablet_Character_OBJ.Body_1 = Color(data["PrimCol"].to_html(false))
								Hexii_Ui_Tablet_Character_OBJ.Body_1_Emiss = Color(0,0,0,1)
								Hexii_Ui_Tablet_Character_OBJ.Body_1_Emiss_S = 0.0
						"TailID":
							if V1_ConversionPath.keys().has(data["TailID"]):
								Hexii_Ui_Tablet_Character_OBJ.Tail = V1_ConversionPath[data["TailID"]]
						"WingID":
							if V1_ConversionPath.keys().has(data["WingID"]):
								Hexii_Ui_Tablet_Character_OBJ.Wings = V1_ConversionPath[data["WingID"]]
						"WireCol":
							if data["WireCol"] is Color:
								Hexii_Ui_Tablet_Character_OBJ.Body_2 = Color(0,0,0,1)
								if data["WireCol"].r > 1.0 || data["WireCol"].g > 1.0 || data["WireCol"].b > 1.0:
									var sortedValues = [snapped(data["WireCol"].r,0.01),snapped(data["WireCol"].g,0.01),snapped(data["WireCol"].b,0.01)]
									var sortarray = sortedValues.duplicate(true)
									var percentage = (sortarray[2] - 1) * 100
									var newArray = [0,0,0]
									for x in sortarray.size():
										newArray[x] = sortedValues[x] / (percentage/100)
									
									print(newArray)
										
									data["WireCol"] = Color(newArray[0],newArray[1],newArray[2],1.0)
									
									$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Code_Loader/ScrollContainer_Color/GridContainer2/ErrorLog.text += "[color=red]Error: WireCol Too Intense, Lowering.\n"
								Hexii_Ui_Tablet_Character_OBJ.Body_2_Emiss =  Color(data["WireCol"].to_html(false))
								Hexii_Ui_Tablet_Character_OBJ.Body_2_Emiss_S = 1.0
						"WireInnerCol":
							$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Code_Loader/ScrollContainer_Color/GridContainer2/ErrorLog.text += "[color=red]Error: WireInnerCol Defunct.\n"
						"Name":
							pass
			2:
				$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button4.show()
				$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button3.show()
				print("Version 2 Save!")
				Hexii_Ui_Tablet_Character_OBJ.Body_1_Roughness = 1
				Hexii_Ui_Tablet_Character_OBJ.Body_2_Roughness = 1
				Hexii_Ui_Tablet_Character_OBJ.Body_3_Roughness = 1
				Hexii_Ui_Tablet_Character_OBJ.Body_4_Roughness = 1
				
				Hexii_Ui_Tablet_Character_OBJ.Body_1_Metallic = 1
				Hexii_Ui_Tablet_Character_OBJ.Body_2_Metallic = 1
				Hexii_Ui_Tablet_Character_OBJ.Body_3_Metallic = 1
				Hexii_Ui_Tablet_Character_OBJ.Body_4_Metallic = 1
				for i in data.keys():
					match i:
						"Color_Body":
							Hexii_Ui_Tablet_Character_OBJ.Body_1 = Color(Color(str(data["Color_Body"])).to_html(false))
							Hexii_Ui_Tablet_Character_OBJ.Body_1_Emiss = Color(0,0,0,1)
							Hexii_Ui_Tablet_Character_OBJ.Body_1_Emiss_S = 0.0
						"Color_BodyGlow":
							Hexii_Ui_Tablet_Character_OBJ.Body_2 = Color(Color(str(data["Color_BodyGlow"])).to_html(false))
							Hexii_Ui_Tablet_Character_OBJ.Body_2_Emiss = Color(Color(str(data["Color_BodyGlow"])).to_html(false))
							Hexii_Ui_Tablet_Character_OBJ.Body_2_Emiss_S = 1
						"Color_Eye_1":
							Hexii_Ui_Tablet_Character_OBJ.Body_3 = Color(0,0,0,1)
							Hexii_Ui_Tablet_Character_OBJ.Body_3_Emiss = Color(Color(str(data["Color_Eye_1"])).to_html(false))
							Hexii_Ui_Tablet_Character_OBJ.Body_3_Emiss_S = 1
						"Color_Eye_2":
							Hexii_Ui_Tablet_Character_OBJ.Body_4 = Color(0,0,0,1)
							Hexii_Ui_Tablet_Character_OBJ.Body_4_Emiss = Color(Color(str(data["Color_Eye_2"])).to_html(false))
							Hexii_Ui_Tablet_Character_OBJ.Body_4_Emiss_S = 1
						"Ears":
							if V2_ConversionPath["Ears"].keys().has(data["Ears"]):
								Hexii_Ui_Tablet_Character_OBJ.Ears =  V2_ConversionPath["Ears"][data["Ears"]]
						"Extra":
							if V2_ConversionPath["Extra"].keys().has(data["Extra"]):
								Hexii_Ui_Tablet_Character_OBJ.Extra =  V2_ConversionPath["Extra"][data["Extra"]]
						"Eyes":
							if V2_ConversionPath["Eyes"].keys().has(data["Eyes"]):
								Hexii_Ui_Tablet_Character_OBJ.Eyes =  V2_ConversionPath["Eyes"][data["Eyes"]]
						"Size":
							Hexii_Ui_Tablet_Character_OBJ.Scale = clampf(float(data["Size"])+ 1.0, 0.8, 1.2)
						"Tail":
							if V2_ConversionPath["Tail"].keys().has(data["Tail"]):
								Hexii_Ui_Tablet_Character_OBJ.Tail =  V2_ConversionPath["Tail"][data["Tail"]]
						"Wings":
							if V2_ConversionPath["Wings"].keys().has(data["Wings"]):
								Hexii_Ui_Tablet_Character_OBJ.Wings =  V2_ConversionPath["Wings"][data["Wings"]]
						"Name":
							pass
			3:
				$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button4.show()
				$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button3.show()
				print("Version 3 Save!")
				for i in data.keys():
					match i:
						"B1":
							Hexii_Ui_Tablet_Character_OBJ.Body_1 = Color(Color(str(data["B1"])).to_html(false))
						"B2":
							Hexii_Ui_Tablet_Character_OBJ.Body_2 = Color(Color(str(data["B2"])).to_html(false))
						"B3":
							Hexii_Ui_Tablet_Character_OBJ.Body_3 = Color(Color(str(data["B3"])).to_html(false))
						"B4":
							Hexii_Ui_Tablet_Character_OBJ.Body_4 = Color(Color(str(data["B4"])).to_html(false))
						"B1E":
							Hexii_Ui_Tablet_Character_OBJ.Body_1_Emiss = Color(Color(str(data["B1E"])).to_html(false))
						"B2E":
							Hexii_Ui_Tablet_Character_OBJ.Body_2_Emiss = Color(Color(str(data["B2E"])).to_html(false))
						"B3E":
							Hexii_Ui_Tablet_Character_OBJ.Body_3_Emiss = Color(Color(str(data["B3E"])).to_html(false))
						"B4E":
							Hexii_Ui_Tablet_Character_OBJ.Body_4_Emiss = Color(Color(str(data["B4E"])).to_html(false))
						"B1ES":
							Hexii_Ui_Tablet_Character_OBJ.Body_1_Emiss_S = clampf(float(data["B1ES"]), 0.0, 1.0)
						"B2ES":
							Hexii_Ui_Tablet_Character_OBJ.Body_2_Emiss_S = clampf(float(data["B2ES"]), 0.0, 1.0)
						"B3ES":
							Hexii_Ui_Tablet_Character_OBJ.Body_3_Emiss_S = clampf(float(data["B3ES"]), 0.0, 1.0)
						"B4ES":
							Hexii_Ui_Tablet_Character_OBJ.Body_4_Emiss_S = clampf(float(data["B4ES"]), 0.0, 1.0)
						"B1R":
							Hexii_Ui_Tablet_Character_OBJ.Body_1_Roughness = clampf(float(data["B1R"]), 0.0, 1.0)
						"B2R":
							Hexii_Ui_Tablet_Character_OBJ.Body_2_Roughness = clampf(float(data["B2R"]), 0.0, 1.0)
						"B3R":
							Hexii_Ui_Tablet_Character_OBJ.Body_3_Roughness = clampf(float(data["B3R"]), 0.0, 1.0)
						"B4R":
							Hexii_Ui_Tablet_Character_OBJ.Body_4_Roughness = clampf(float(data["B4R"]), 0.0, 1.0)
						"B1M":
							Hexii_Ui_Tablet_Character_OBJ.Body_1_Metallic = clampf(float(data["B1M"]), 0.0, 1.0)
						"B2M":
							Hexii_Ui_Tablet_Character_OBJ.Body_2_Metallic = clampf(float(data["B2M"]), 0.0, 1.0)
						"B3M":
							Hexii_Ui_Tablet_Character_OBJ.Body_3_Metallic = clampf(float(data["B3M"]), 0.0, 1.0)
						"B4M":
							Hexii_Ui_Tablet_Character_OBJ.Body_4_Metallic = clampf(float(data["B4M"]), 0.0, 1.0)
						"T":
							Hexii_Ui_Tablet_Character_OBJ.Tail = int(data["T"])
						"W":
							Hexii_Ui_Tablet_Character_OBJ.Wings = int(data["W"])
						"EA":
							Hexii_Ui_Tablet_Character_OBJ.Ears = int(data["EA"])
						"EX":
							Hexii_Ui_Tablet_Character_OBJ.Extra = int(data["EX"])
						"EY":
							Hexii_Ui_Tablet_Character_OBJ.Eyes = int(data["EY"])
						"S":
							Hexii_Ui_Tablet_Character_OBJ.Scale = clampf(float(data["S"]), 0.8, 1.2)
						"N":
							Hexii_Ui_Tablet_Character_OBJ.Name = str(data["N"])
						"PA":
							Hexii_Ui_Tablet_Character_OBJ.Pronouns_A = str(data["PA"])
						"PB":
							Hexii_Ui_Tablet_Character_OBJ.Pronouns_B = str(data["PB"])
						"PC":
							Hexii_Ui_Tablet_Character_OBJ.Pronouns_C = str(data["PC"])
		Hexii_Ui_Tablet_Character_OBJ.Regen_Character()

func _on_export_button_pressed() -> void:
	var V3Template = {
"B1":Player.Body_1.to_html(false),
"B2":Player.Body_2.to_html(false),
"B3":Player.Body_3.to_html(false),
"B4":Player.Body_4.to_html(false),
"B1E":Player.Body_1_Emiss.to_html(false),
"B2E":Player.Body_2_Emiss.to_html(false),
"B3E":Player.Body_3_Emiss.to_html(false),
"B4E":Player.Body_4_Emiss.to_html(false),
"B1ES":Player.Body_1_Emiss_S,
"B2ES":Player.Body_2_Emiss_S,
"B3ES":Player.Body_3_Emiss_S,
"B4ES":Player.Body_4_Emiss_S,
"B1R":Player.Body_1_Roughness,
"B2R":Player.Body_2_Roughness,
"B3R":Player.Body_3_Roughness,
"B4R":Player.Body_4_Roughness,
"B1M":Player.Body_1_Metallic,
"B2M":Player.Body_2_Metallic,
"B3M":Player.Body_3_Metallic,
"B4M":Player.Body_4_Metallic,
"T":Player.Tail,
"W":Player.Wings,
"EA":Player.Ears,
"EX":Player.Extra,
"EY":Player.Eyes,
"S":Player.Scale,
"N":Player.Name,
"PA":Player.Pronouns_A,
"PB":Player.Pronouns_B,
"PC":Player.Pronouns_C
}
	
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Code_Loader/ScrollContainer_Color/GridContainer2/Code_Input/LineEdit.text = JSON.stringify(V3Template)

func _on_namepanel_text_submitted(new_text: String, type: String) -> void:
	Hexii_Ui_Tablet_Character_OBJ.set(type, new_text)

func _on_scale_value_changed(value: float) -> void:
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button4.show()
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button3.show()
	Hexii_Ui_Tablet_Character_OBJ.Scale = value
	Hexii_Ui_Tablet_Character_OBJ.Adjust_Scale()
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Name_Picker/ScrollContainer_Color/GridContainer2/Scale/LineEdit.text = str(value)

func _on_scale_text_submitted(new_text: String) -> void:
	get_viewport().gui_release_focus()
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button4.show()
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button3.show()
	Hexii_Ui_Tablet_Character_OBJ.Scale = clampf(float(new_text),0.8,1.2)
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Name_Picker/ScrollContainer_Color/GridContainer2/Scale/LineEdit.text = str(Hexii_Ui_Tablet_Character_OBJ.Scale)
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/Name_Picker/ScrollContainer_Color/GridContainer2/Scale/HSlider.value = Hexii_Ui_Tablet_Character_OBJ.Scale

func change_part(Core_Part:String, Part:int) -> void:
	print(Core_Part," , ",Part)
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button4.show()
	$CanvasLayer/Hexii_Tablet_UI/Wallpaper/Character_Screen/HBoxContainer/Button3.show()
	Hexii_Ui_Tablet_Character_OBJ.set(Core_Part,Part)
	Hexii_Ui_Tablet_Character_OBJ.Regen_Character()

#################################
###### Title Screen System ######
#################################
var Active_Hexii_Ui_Tablet_Screen_Anim = "Hexii_Ui_Tablet_NullScreen_Anim"
@onready var Hexii_Ui_Tablet_NullScreen_Anim =  Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Panel/Null_Screen/AnimationPlayer")
@onready var Hexii_Ui_Tablet_TitleButton =  Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Title_Bar/VBoxContainer/TitleButton")
@onready var Hexii_Ui_Tablet_TitleScreen_Anim =  Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Panel/Title_Screen/AnimationPlayer")
@onready var Hexii_Ui_Tablet_UpdateButton =  Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Title_Bar/VBoxContainer/UpdateButton")
@onready var Hexii_Ui_Tablet_PlayButton =  Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Title_Bar/VBoxContainer/PlayButton")
@onready var Hexii_Ui_Tablet_DevlogButton =   Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Title_Bar/VBoxContainer/DevlogButton")
@onready var Hexii_Ui_Tablet_CommunityButton =   Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Title_Bar/VBoxContainer/CommunityButton")
@onready var Hexii_Ui_Tablet_SettingsButton =   Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Title_Bar/VBoxContainer/SettingsButton")
@onready var Hexii_Ui_Tablet_QuitButton =   Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Title_Bar/VBoxContainer/QuitButton")

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
@onready var Hexii_Ui_Tablet_CharacterScreen_Anim =  Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Panel/Character_Screen/AnimationPlayer")
@onready var Hexii_Ui_Tablet_CharacterScreen =  Hexii_Ui_Tablet.get_node("Wallpaper/Character_Screen")
@onready var Hexii_Ui_Tablet_JournalScreen =  Hexii_Ui_Tablet.get_node("Wallpaper/Journal_Screen")

###################################
###### Update Checker System ######
###################################

#################################
###### Login Screen System ######
#################################
@onready var Hexii_Ui_Tablet_LoginScreen_Anim = Hexii_Ui_Tablet.get_node("Overlay/Screens/Main_Panel/HBoxContainer/Panel/Login_Screen/AnimationPlayer")



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
