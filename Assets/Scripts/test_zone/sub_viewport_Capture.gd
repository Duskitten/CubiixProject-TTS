extends SubViewport

@export var screenshotMode = false

func _ready() -> void:
	if screenshotMode:
		await get_tree().create_timer(1).timeout
		print("Screenshotting")
		get_texture().get_image().save_png("user://editor.png")
