extends Node

@onready var Dialogue = $CanvasLayer/Dialogue

@onready var Hexii_Ui = $CanvasLayer/Hexii_UI
@onready var Hexii_Ui_Anim = Hexii_Ui.get_node("Overlay/AnimationPlayer")

@onready var Hexii_Ui_Chat_Anim = Hexii_Ui.get_node("Overlay/Screens/Chat_Screen/AnimationPlayer")
@onready var Hexii_Ui_Chat_List = Hexii_Ui.get_node("Overlay/Screens/Chat_Screen/Panel/ScrollContainer/ChatArea")
@onready var Hexii_Ui_Chat_Scroll = Hexii_Ui.get_node("Overlay/Screens/Chat_Screen/Panel/ScrollContainer")
@onready var Hexii_Ui_Chat_TextTemplate = Hexii_Ui.get_node("Overlay/Screens/Chat_Screen/Panel/Template_Text")
@onready var Hexii_Ui_Chat_TextInput = Hexii_Ui.get_node("Overlay/Screens/Chat_Screen/Panel/LineEdit")

@onready var Hexii_Ui_Login_Anim = Hexii_Ui.get_node("Overlay/Screens/Login_Screen/AnimationPlayer")

@onready var Transitioner = $CanvasLayer/Transitioner
@onready var Transitioner_AnimationPlayer = Transitioner.get_node("AnimationPlayer")

func _ready() -> void:
	Hexii_Ui_Chat_TextInput.text_submitted.connect(send_text.bind())

func Hexii_UI_Transition(anim_1,  componentName, anim_2, component2Name)-> void:
	if anim_1 == "Back":
		Hexii_Ui_Anim.play("Tilt_R")
	elif anim_1 == "Enter":
		Hexii_Ui_Anim.play("Tilt_L")

	if componentName in self && component2Name in self:
		get(componentName).play(anim_1)
		get(component2Name).play(anim_2)

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
		add_new_message("[color=red]System[/color]", "[color=red]Error Invalid Command[/color]")
		Hexii_Ui_Chat_TextInput.text = ""
		Hexii_Ui_Chat_TextInput.release_focus()
	else:
		add_new_message("Dusk", new_text)
		Hexii_Ui_Chat_TextInput.text = ""
		Hexii_Ui_Chat_TextInput.release_focus()
