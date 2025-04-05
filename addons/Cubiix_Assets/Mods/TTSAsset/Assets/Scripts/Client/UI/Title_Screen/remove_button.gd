extends TextureButton
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
func _on_pressed() -> void:
	Core.Globals.Data["SavedServers"].remove_at(get_parent().get_parent().get_index())
	get_parent().get_parent().queue_free()
