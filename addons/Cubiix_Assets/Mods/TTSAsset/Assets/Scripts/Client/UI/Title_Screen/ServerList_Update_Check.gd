extends VBoxContainer
@onready var Core = get_node("/root/Main_Scene/CoreLoader")

func _ready() -> void:
	Core.ServerList_Updater = self

func updatevalues() -> void:
	Core.Client.ping_system_toggle = true
	if $VBoxContainer != null:
		for i in $VBoxContainer.get_children():
			if !i.get_meta("Checked"):
				(i as TextureButton).pressed.connect(join_server.bind(i))
				Core.Client.Poll_Server_Info(i.get_meta("ip"),i.get_meta("port"), i)
				i.set_meta("Checked", true)
				await Core.Client.ServerPolled
			

func join_server(node:Node) -> void:
	if node.get_meta("Checked"):
		Core.Client.ping_system_toggle = false
		Core.Client.Client_Join_Server(node.get_meta("ip"),node.get_meta("port"))
