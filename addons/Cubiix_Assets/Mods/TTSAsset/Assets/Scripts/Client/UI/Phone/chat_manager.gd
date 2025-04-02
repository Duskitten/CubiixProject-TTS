extends VBoxContainer

@onready var ChatTemplate = $ChatTemplate
enum ChatTypes {
	PLAYER,
	SYSTEM,
	NPC
}
var emotelist = {
	":alien:":"[img]res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Chat_Emotes/alien.png[/img]"
	}

func _ready() -> void:
	await get_tree().create_timer(5).timeout
	append_new_messege(ChatTypes.PLAYER,{"Name":"Duskitten","Messege":"This is a test! My Chat messege goes pretty far but I think it's fine yeah?"})
	await get_tree().create_timer(5).timeout
	append_new_messege(ChatTypes.SYSTEM,{"Messege":"[color=red]System testing chat![/color]"})
	await get_tree().create_timer(5).timeout
	append_new_messege(ChatTypes.NPC,{"Name":"Bjornk","Messege":"OogaBooga. I post things in here that are a bit silly and goofy lul."})
	append_new_messege(ChatTypes.PLAYER,{"Name":"Duskitten","Messege":"[img]res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Chat_Emotes/alien.png[/img]"})

func append_new_messege(Type:ChatTypes, MessegeData:Dictionary) -> void:
	var new_messege = ChatTemplate.duplicate(true)
	match Type:
		ChatTypes.SYSTEM:
			new_messege.get_node("VBoxContainer/Button").disabled = true
			adjust_messege(new_messege,">>System:", Color("#ab1c2e"),MessegeData["Messege"])
		ChatTypes.PLAYER:
			adjust_messege(new_messege,MessegeData["Name"], Color("#7250ab"),MessegeData["Messege"])
		ChatTypes.NPC:
			new_messege.get_node("VBoxContainer/Button").disabled = true
			adjust_messege(new_messege,MessegeData["Name"], Color("#22ab3a"),MessegeData["Messege"])
	
	add_child(new_messege)
	new_messege.show()
	await get_tree().process_frame
	get_parent().set_deferred("scroll_vertical",get_parent().get_v_scroll_bar().max_value)
	
func adjust_messege(Template,Name:String, NewColor:Color, Messege:String) -> void:
	Template.get_node("VBoxContainer/Button").text = Name
	
	var newchat = Messege
	for i in emotelist:
		newchat = newchat.replace(i,emotelist[i])
	
	
	Template.get_node("VBoxContainer/RichTextLabel").text = newchat
	var newStylebox:StyleBox = StyleBoxFlat.new()
	newStylebox.bg_color = NewColor
	newStylebox.content_margin_left = 4
	newStylebox.corner_radius_bottom_left = 4
	newStylebox.corner_radius_bottom_right = 4
	newStylebox.corner_radius_top_left = 4
	newStylebox.corner_radius_top_right = 4
	(Template.get_node("VBoxContainer/Button") as Button).add_theme_stylebox_override("disabled",newStylebox)
	(Template.get_node("VBoxContainer/Button") as Button).add_theme_stylebox_override("normal",newStylebox)
