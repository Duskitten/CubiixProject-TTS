extends Node
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
var NetworkThread = Thread.new()
var TCP:StreamPeerTCP = StreamPeerTCP.new()
var ChatManager
var connect_timer:Timer = Timer.new()
var disable_connect = false

var ping_system_toggle = true
var server_info_holder = {}
signal ServerPolled
signal ClientDisconnected

var NetworkPlayers
var current_packet = {}
var Commands = {}

func _ready() -> void:
	for i in Core.AssetData.assets_tagged["Network_Command"]:
		#print(i)
		var commanddata = Core.AssetData.find_command(i)
		#print(commanddata)
		var command = load(commanddata["Path"]).new()
		#command.name = commanddata["Name"]
		Commands[commanddata["Name"]] = command
	add_child(connect_timer)
	connect_timer.wait_time = 3
	connect_timer.timeout.connect(disable_connection)

func connect_to_server(ip:String,port:String) -> void:
	TCP.connect_to_host(ip,int(port))
	disable_connect = false
	connect_timer.start()
	start_network()
	
func start_network():
	NetworkThread.start(network_process)
	
func network_process():
	while true:
		if Core.Globals.KillThreads:
			break
		
		TCP.poll()
		
		match TCP.get_status():
			StreamPeerTCP.STATUS_CONNECTED:
				if TCP.get_available_bytes() > 0:
					if !connect_timer.is_stopped():
						connect_timer.call_deferred("stop")
					var Data = TCP.get_var(false)
					if Data is Dictionary && !Data.is_empty():
						call_deferred("SendToParser",Data)
						if !current_packet.is_empty():
							TCP.put_var(current_packet)
							current_packet = {"TTS_Ping":true}
				else:
					if disable_connect:
						break

			StreamPeerTCP.STATUS_CONNECTING:
				#if TCP.get_available_bytes() > 0:
					#Parse_Data.parse_data(self,TCP,TCP.get_var(false))
				if disable_connect:
					connect_timer.call_deferred("stop")
					break
				
			StreamPeerTCP.STATUS_NONE:
				break
			StreamPeerTCP.STATUS_ERROR:
				call_deferred("disable_connection")
				break
	print("Disconnecting TCP")
	if TCP.get_status() != StreamPeerTCP.STATUS_NONE:
		TCP.disconnect_from_host()
	call_deferred("emit_signal","ClientDisconnected")
	call_deferred("_exit_tree")

func _exit_tree() -> void:
	disable_connect = true
	if NetworkThread.is_started():
		NetworkThread.wait_to_finish()
	
func disable_connection():
	disable_connect = true
	if NetworkThread.is_started():
		print("waiting to finish")
		NetworkThread.wait_to_finish()
		call_deferred("emit_signal","ServerPolled")
		connect_timer.stop()
	

### This is where we begin our ping test systems
### We will poll the server, then cut it once it obtains a response
func Poll_Server_Info(ip:String,port:String, coreNode:Control) -> void:
	connect_to_server(ip,port)
	await ServerPolled
	if server_info_holder.is_empty():
		server_info_holder["ServerColor"] = "#ff0000"
		server_info_holder["ServerName"] = "NO CONNECTION..."
		server_info_holder["CurrentPlayers"] = "?"
		server_info_holder["MaxPlayers"] = "?"
		coreNode.set_meta("disabled", true)
	else:
		coreNode.set_meta("disabled", false)
	
	#print(server_info_holder["ServerColor"])
	coreNode.self_modulate = Color(server_info_holder["ServerColor"])
	coreNode.get_node("HBoxContainer/VBoxContainer/Name").text = server_info_holder["ServerName"]
	coreNode.get_node("HBoxContainer/PlayerCount").text = str(server_info_holder["CurrentPlayers"]) + "/" + str(server_info_holder["MaxPlayers"])
	
	Client_Disconnect_Server()
	server_info_holder = {}

func Client_Join_Server(ip:String,port:String) -> void:
	current_packet = {}
	ping_system_toggle = false
	connect_to_server(ip,port)

func Client_Disconnect_Server() -> void:
	disable_connect = true
	await get_tree().process_frame
	disable_connect = false

func SendToParser(Data:Dictionary) -> void:
	for i in Data.keys():
		Commands[i].client_parse(self, Data[i])
					
