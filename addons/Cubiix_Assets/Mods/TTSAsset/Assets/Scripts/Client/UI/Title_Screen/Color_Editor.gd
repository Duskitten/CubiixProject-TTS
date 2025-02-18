extends VBoxContainer

@export var Target_Material = "Body_1"

@onready var Base_Rect:ColorRect = $Base_Rect
@onready var Base_Hex:LineEdit = $Base_Hex
@onready var Base_Hue:HSlider = $Base_Hue
@onready var Base_Sat:HSlider = $Base_Sat
@onready var Base_Vib:HSlider = $Base_Vib

@onready var Emiss_Rect:ColorRect = $Emiss_Rect
@onready var Emiss_Hex:LineEdit = $HBoxContainer2/Emiss_Hex
@onready var Emiss_Float:LineEdit = $HBoxContainer2/Emiss_Float
@onready var Emiss_Hue:HSlider = $Emiss_Hue
@onready var Emiss_Sat:HSlider = $Emiss_Sat
@onready var Emiss_Vib:HSlider = $Emiss_Vib
@onready var Emiss_Str:HSlider = $Emiss_Str

@onready var Metallic_Float:LineEdit = $HBoxContainer/Metallic_Float
@onready var Roughness_Float:LineEdit = $HBoxContainer/Roughness_Float
@onready var Metallic:HSlider = $Metallic
@onready var Roughness:HSlider = $Roughness

func remove_text_focus() -> void:
	get_viewport().gui_release_focus()

func _on_line_edit_text_changed(new_text: String, extra_arg_0: String) -> void:
	find_parent("TextureRect").set_edited()
	match extra_arg_0:
		"Base_Color":
			if Color.html_is_valid(new_text):
				var Compiled_Color = Color.html(new_text)
				Base_Rect.color = Compiled_Color
				Base_Hue.value = Compiled_Color.h
				Base_Sat.value = Compiled_Color.s
				Base_Vib.value = Compiled_Color.v
				var Stylebox:StyleBox = Base_Sat.get_theme_stylebox("slider")
				Stylebox.texture.gradient.colors[1] = Color.from_hsv(Compiled_Color.h,1.0,1.0)
				var Stylebox2:StyleBox = Base_Vib.get_theme_stylebox("slider")
				Stylebox2.texture.gradient.colors[1] = Color.from_hsv(Compiled_Color.h,1.0,1.0)
				update_materials()
		"Emiss_Color":
			if Color.html_is_valid(new_text):
				var Compiled_Color = Color.html(new_text)
				Emiss_Rect.color = Compiled_Color
				Emiss_Hue.value = Compiled_Color.h
				Emiss_Sat.value = Compiled_Color.s
				Emiss_Vib.value = Compiled_Color.v
				var Stylebox:StyleBox = Emiss_Sat.get_theme_stylebox("slider")
				Stylebox.texture.gradient.colors[1] = Color.from_hsv(Compiled_Color.h,1.0,1.0)
				var Stylebox2:StyleBox = Emiss_Vib.get_theme_stylebox("slider")
				Stylebox2.texture.gradient.colors[1] = Color.from_hsv(Compiled_Color.h,1.0,1.0)
				update_materials()
		"Emiss_Str":
			Emiss_Str.value = float(new_text) 
			update_materials()
		"Metallic":
			Metallic.value = float(new_text) 
			update_materials()
		"Roughness":
			Roughness.value = float(new_text) 
			update_materials()
	#print()


func _on_value_changed(value: float, extra_arg_0: String) -> void:
	find_parent("TextureRect").set_edited()
	match extra_arg_0:
		"Base_Color":
			if !Base_Hex.has_focus():
				var Compiled_Color:Color = Color.from_hsv(Base_Hue.value,Base_Sat.value,Base_Vib.value)
				Base_Hex.text = Compiled_Color.to_html(false)
				Base_Rect.color = Compiled_Color
				var Stylebox:StyleBox = Base_Sat.get_theme_stylebox("slider")
				Stylebox.texture.gradient.colors[1] = Color.from_hsv(Base_Hue.value,1.0,1.0)
				var Stylebox2:StyleBox = Base_Vib.get_theme_stylebox("slider")
				Stylebox2.texture.gradient.colors[1] = Color.from_hsv(Base_Hue.value,1.0,1.0)
				update_materials()
		"Emiss_Color":
			if !Emiss_Hex.has_focus():
				var Compiled_Color:Color = Color.from_hsv(Emiss_Hue.value,Emiss_Sat.value,Emiss_Vib.value)
				Emiss_Hex.text = Compiled_Color.to_html(false)
				Emiss_Rect.color = Compiled_Color
				var Stylebox:StyleBox = Emiss_Sat.get_theme_stylebox("slider")
				Stylebox.texture.gradient.colors[1] = Color.from_hsv(Emiss_Hue.value,1.0,1.0)
				var Stylebox2:StyleBox = Emiss_Vib.get_theme_stylebox("slider")
				Stylebox2.texture.gradient.colors[1] = Color.from_hsv(Emiss_Hue.value,1.0,1.0)
				update_materials()
		"Emiss_Str":
			if !Emiss_Float.has_focus():
				Emiss_Float.text = str("%0.2f" % Emiss_Str.value)
				update_materials()
		"Metallic":
			if !Metallic_Float.has_focus():
				Metallic_Float.text = str("%0.2f" % Metallic.value)
				update_materials()
		"Roughness":
			if !Roughness_Float.has_focus():
				Roughness_Float.text = str("%0.2f" % Roughness.value)
				update_materials()

func update_materials() -> void:
	var Keylist = find_parent("Offline").Character_Template.Keylist
	find_parent("Offline").Character_Template.Shader_Color[Keylist["Body"][Target_Material]] = Color.from_hsv(Base_Hue.value,Base_Sat.value,Base_Vib.value)
	find_parent("Offline").Character_Template.Shader_Emission[Keylist["Body"][Target_Material]] = Color.from_hsv(Emiss_Hue.value,Emiss_Sat.value,Emiss_Vib.value)
	find_parent("Offline").Character_Template.Shader_Metallic[Keylist["Body"][Target_Material]] =  Metallic.value
	find_parent("Offline").Character_Template.Shader_Emission_Strength[Keylist["Body"][Target_Material]] = Emiss_Str.value
	find_parent("Offline").Character_Template.Shader_Roughness[Keylist["Body"][Target_Material]] = Roughness.value
	find_parent("Offline").Character_Template.generate_colors()
