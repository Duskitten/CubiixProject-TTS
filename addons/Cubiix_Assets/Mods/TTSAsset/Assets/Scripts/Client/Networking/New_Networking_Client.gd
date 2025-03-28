extends Node
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
var NetworkThread = Thread.new()
var TCP:StreamPeerTCP = StreamPeerTCP.new()

var connect_timer:Timer = Timer.new()
var disable_connect = false

var ping_system_toggle = true
var server_info_holder = {}
signal ServerPolled

var current_packet = {}
var Commands = {}

func _ready() -> void:
	for i in Core.AssetData.assets_tagged["Network_Command"]:
		#print(i)
		var commanddata = Core.AssetData.find_command(i)
		#print(commanddata)
		var command = load(commanddata["Path"]).new()
		command.name = commanddata["Name"]
		Commands[commanddata["Name"]] = command
	add_child(connect_timer)
	connect_timer.wait_time = 3
	connect_timer.timeout.connect(disable_connection)
	await get_tree().create_timer(1).timeout
	Poll_Server_Info("127.0.0.1","5599")

func connect_to_server(ip:String,port:String) -> void:
	TCP.connect_to_host(ip,int(port))
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
				if disable_connect:
					break
				connect_timer.call_deferred("stop")
				if TCP.get_available_bytes() > 0:
					var Data = TCP.get_var(false)
					for i in Data.keys():
						Commands[i].client_parse(self, Data[i])
					
					if !current_packet.is_empty():
						TCP.put_var(current_packet)
						current_packet = {}

			StreamPeerTCP.STATUS_CONNECTING:
				#if TCP.get_available_bytes() > 0:
					#Parse_Data.parse_data(self,TCP,TCP.get_var(false))
				if disable_connect:
					break
				
			StreamPeerTCP.STATUS_NONE:
				connect_timer.call_deferred("stop")
				break
	print("Disconnecting TCP")
	TCP.disconnect_from_host()

func _exit_tree() -> void:
	NetworkThread.wait_to_finish()
	
func disable_connection():
	connect_timer.call_deferred("stop")
	disable_connect = true

### This is where we begin our ping test systems
### We will poll the server, then cut it once it obtains a response
func Poll_Server_Info(ip:String,port:String) -> void:
	connect_to_server(ip,port)
	await ServerPolled
	disable_connect = true
	print(server_info_holder)
	disable_connect = false
