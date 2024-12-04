extends Node
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
var NetworkThread = Thread.new()
var TCP = StreamPeerTCP.new()
var Template_Packet = {
	"Username":"",
	"Type":0,
	"Content":{}
}

enum Networking_Valid_Types {
	Ping,
	Player_Move,
	Player_Request_Info
}

enum Networking_Mode {
	Connecting,
	Pinging
}

signal NextPing
var LastPingTime = -1
var ServerData = {}
var disable_connect = false
var connect_timer:Timer = Timer.new()

var Current_Network_Mode:Networking_Mode = Networking_Mode.Pinging

var Local_Player = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(connect_timer)
	connect_timer.wait_time = 3
	connect_timer.timeout.connect(disable_connection)
	
func connect_to_server(ip:String,port:String) -> void:
	TCP.connect_to_host(ip,int(port))
	connect_timer.start()
	start_network()
	#Core.SceneData.Swap_Scene("Showcase")

func network_ping(serverlist:Array) -> void:
	Current_Network_Mode = Networking_Mode.Pinging
	
	for i in serverlist:
		LastPingTime = -1
		disable_connect = false
		connect_to_server(i.get_meta("ip"),i.get_meta("port"))
		await NextPing
		NetworkThread.wait_to_finish()
		await get_tree().create_timer(1).timeout
		i.get_node("TextureButton/Sprite2D/AnimationPlayer/AnimationTree").active = false
		print(LastPingTime)
		var Target = "Dead"
		if LastPingTime <= 50 && LastPingTime >= 0:
			Target = "Good"
		elif LastPingTime <= 200 && LastPingTime >= 51:
			Target = "Mid"
		elif  LastPingTime >= 201:
			Target = "Bad"
		i.get_node("TextureButton/Sprite2D/AnimationPlayer").play(Target)
		i.get_node("TextureButton").self_modulate = Color(str(ServerData["ServerColor"]))
		i.get_node("TextureButton/Label2").text = "[left]"+str(ServerData["ServerName"])+"\n[font_size=10]localhost:5599"
		i.get_node("TextureButton/Label3").text = str(ServerData["CurrentPlayers"])+"/"+str(ServerData["MaxPlayers"])

	for i in serverlist:
		i.get_node("TextureButton").disabled = false
		
	print("PingedServers!")

func start_network():
	NetworkThread.start(network_process)

func network_process():
	while true:
		if Core.Globals.KillThreads:
				break
		
		TCP.poll()
		if TCP.get_status() == StreamPeerTCP.STATUS_CONNECTED:
			connect_timer.call_deferred("stop")
			if TCP.get_available_bytes() > 0:
				parse_data(TCP.get_var(false))

		elif TCP.get_status() == StreamPeerTCP.STATUS_CONNECTING:
			if TCP.get_available_bytes() > 0:
				parse_data(TCP.get_var(false))
			if disable_connect:
				break
			
		elif TCP.get_status() == StreamPeerTCP.STATUS_NONE:
			connect_timer.call_deferred("stop")
			break

	TCP.disconnect_from_host()

	call_deferred("emit_signal","NextPing")
	

func send_data(id:Networking_Valid_Types,data:Dictionary):
	#print("Sending Data!")
	var Packet = Template_Packet.duplicate()
	Packet["Type"] = id
	Packet["Username"] = Core.Globals.LocalUser["Username"]
	Packet["Content"] = data
	
	TCP.put_var(Packet)
	
func parse_data(data:Dictionary):
	match data["Type"]:
		Networking_Valid_Types.Ping:
			if data["Content"].has("Time"):
				LastPingTime = ceil(data["Content"]["Time"] - Time.get_unix_time_from_system())
				ServerData = data["Content"]
				TCP.disconnect_from_host()
			else:
				match Current_Network_Mode:
					Networking_Mode.Pinging:
						send_data(Networking_Valid_Types.Ping,
						{"A":"Pinging",
						"Time":Time.get_unix_time_from_system()
						})
					Networking_Mode.Connecting:
						send_data(Networking_Valid_Types.Ping,
						{"A":"Connect",
						"Username":Core.Globals.LocalUser["Username"],
						"UserSecretCode":Core.Globals.LocalUser["UserSecretCode"],
						"URL":Core.Globals.LocalUser["URL"]
						})

func _exit_tree() -> void:
	NetworkThread.wait_to_finish()

func disable_connection():
	disable_connect = true
