extends SubViewport

var valid_keys = {
	"Small":"ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-=[]\\;\',./`*/+",
	"Mid":["CAPS","TAB","CTRL","ALT"],
	"Large":["SHIFT", "SPACE","ENTER","UP","DOWN","LEFT","RIGHT"]
}

func _ready() -> void:
	for i in valid_keys.keys():
		for x in get_children():
			x.hide()
		var chosen = get_node("KeyboardButton_"+i)
		var label = chosen.get_node("Label")
		chosen.show()
		size = chosen.size
		
		if i == "Small":
			for x in valid_keys[i]:
				label.text = x
				await RenderingServer.frame_post_draw
				print(x)
				get_texture().get_image().save_png("user://"+str(str(x).to_ascii_buffer()[0])+".png")
		else:
			for x in valid_keys[i]:
				label.text = x
				await RenderingServer.frame_post_draw
				print(x)
				get_texture().get_image().save_png("user://"+x+".png")
