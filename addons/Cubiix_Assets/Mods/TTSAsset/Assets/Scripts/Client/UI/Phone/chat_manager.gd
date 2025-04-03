extends VBoxContainer
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
@onready var ChatTemplate = $ChatTemplate
enum ChatTypes {
	PLAYER,
	SYSTEM,
	NPC
}
var emotelist = {
	":alien:":"[img]res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Chat_Emotes/alien.png[/img]",
	":angry:":"[img]res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Chat_Emotes/angry.png[/img]",
	":bleh:":"[img]res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Chat_Emotes/bleh.png[/img]",
	":dead:":"[img]res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Chat_Emotes/dead.png[/img]",
	":dizzy:":"[img]res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Chat_Emotes/dizzy.png[/img]",
	":happy:":"[img]res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Chat_Emotes/happy.png[/img]",
	":kitty:":"[img]res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Chat_Emotes/kitty.png[/img]",
	":no:":"[img]res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Chat_Emotes/no.png[/img]",
	":oof:":"[img]res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Chat_Emotes/oof.png[/img]",
	":pensive:":"[img]res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Chat_Emotes/pensive.png[/img]",
	":pupper:":"[img]res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Chat_Emotes/pupper.png[/img]",
	":sad:":"[img]res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Chat_Emotes/sad.png[/img]",
	":shock:":"[img]res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Chat_Emotes/shock.png[/img]",
	":skull:":"[img]res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Chat_Emotes/skull.png[/img]",
	":smile:":"[img]res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Chat_Emotes/smile.png[/img]",
	":spook:":"[img]res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Chat_Emotes/spook.png[/img]",
	":uhuh:":"[img]res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Chat_Emotes/uhuh.png[/img]",
	":what:":"[img]res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Chat_Emotes/what.png[/img]",
	":wizard:":"[img]res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Chat_Emotes/wizard.png[/img]",
	":yes:":"[img]res://addons/Cubiix_Assets/Mods/TTSAsset/Assets/Textures/UI/Chat_Emotes/yes.png[/img]"
	}
 
func _ready() -> void:
	Core.Client.ChatManager = self
	
func append_new_messege(Type:ChatTypes, MessegeData:Dictionary) -> void:
	var new_messege = ChatTemplate.duplicate(true)
	match Type:
		ChatTypes.SYSTEM:
			new_messege.get_node("VBoxContainer/Button").disabled = true
			adjust_messege(new_messege,">>System:", Color("#ab1c2e"),MessegeData["Messege"])
		ChatTypes.PLAYER:
			print(MessegeData["SenderPhone"])
			if !MessegeData["SenderName"].strip_edges(true,true) == "":
				adjust_messege(new_messege,MessegeData["SenderName"], Color("#7250ab"),MessegeData["Messege"])
			else:
				adjust_messege(new_messege,MessegeData["SenderPhone"], Color("#7250ab"),MessegeData["Messege"])
		ChatTypes.NPC:
			new_messege.get_node("VBoxContainer/Button").disabled = true
			adjust_messege(new_messege,MessegeData["SenderName"], Color("#22ab3a"),MessegeData["Messege"])
	
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
