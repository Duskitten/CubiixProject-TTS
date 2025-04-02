extends LineEdit
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

#func _process(delta: float) -> void:
	#if Core.Client.TCP.get_status() == StreamPeerTCP.STATUS_CONNECTED && !Core.Client.ping_system_toggle:
		#editable = true
		#show()
	#else:
		#editable = false
		#hide()



func _on_text_submitted(new_text: String) -> void:
	if text != "":
		text = ""
		Core.Client.Commands["TTS_ChatMessege"].client_compile(Core.Client,new_text)
		#get_parent().get_node("ChatSpawn/ScrollContainer/VBoxContainer").append_new_messege(get_parent().get_node("ChatSpawn/ScrollContainer/VBoxContainer").ChatTypes.PLAYER,{"Name":"Duskitten","Messege":new_text})
