extends VBoxContainer
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
var LoginController
var disable = false
func _ready() -> void:
	LoginController = find_parent("Login_Controller")
	Core.ServerList_Updater = self

func updatevalues() -> void:
	if !disable:
		disable = true
		Core.Client.ping_system_toggle = true
		if $VBoxContainer != null:
			for i in $VBoxContainer.get_children():
				if !i.get_meta("Checked"):
					(i as TextureButton).pressed.connect(join_server.bind(i))
					if i.get_meta("ip").is_valid_ip_address && i.get_meta("port").is_valid_int():
						Core.Client.Poll_Server_Info(i.get_meta("ip"),i.get_meta("port"), i)
						print("Checking!")
						await Core.Client.ServerPolled
						await get_tree().create_timer(2)
						i.set_meta("Checked", true)
						
		disable = false

func force_refresh() -> void:
	if !disable:
		disable = true
		Core.Client.ping_system_toggle = true
		if $VBoxContainer != null:
			for i in $VBoxContainer.get_children():
				(i as TextureButton).pressed.connect(join_server.bind(i))
				if i.get_meta("ip").is_valid_ip_address && i.get_meta("port").is_valid_int():
						Core.Client.Poll_Server_Info(i.get_meta("ip"),i.get_meta("port"), i)
						await Core.Client.ServerPolled
						await get_tree().create_timer(2)
						i.set_meta("Checked", true)
		disable = false

func join_server(node:Node) -> void:
	if node.get_meta("Checked") && !node.get_meta("disabled"):
		LoginController.get_node("ServerList").hide()
		LoginController.get_node("Joining").show()
		Core.Client.ping_system_toggle = false
		Core.Client.Client_Join_Server(node.get_meta("ip"),node.get_meta("port"))
