extends Node
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
var NetworkThread = Thread.new()
var TCP = StreamPeerTCP.new()
var Template_Packet = {
	"Type":0,
	"Content":{}
}

enum Networking_Valid_Types {
	Ping,
	Tick_Packet,
	Error,
	Client_Packet
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

var templatechar = {
	"Node":null
}

var char_data = {
	
}

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
	
func button_connect_to_server(ip:String,port:String) -> void:
	Core.Persistant_Core.loading_server()
	Current_Network_Mode = Networking_Mode.Connecting
	TCP.connect_to_host(ip,int(port))
	connect_timer.start()
	start_network()

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
		if Target != "Dead":
			i.get_node("TextureButton").self_modulate = Color(str(ServerData["ServerColor"]))
			i.get_node("TextureButton/Label2").text = "[left]"+str(ServerData["ServerName"])+"\n[font_size=10]localhost:5599"
			i.get_node("TextureButton/Label3").text = str(ServerData["CurrentPlayers"])+"/"+str(ServerData["MaxPlayers"])
		else:
			i.get_node("TextureButton").self_modulate = Color(1,0,0,1)
			i.get_node("TextureButton/Label3").text = str("?")+"/"+str("?")
			i.get_node("TextureButton/Label2").text = "[left]"+str("Server Offline...")+"\n[font_size=10]localhost:5599"

	for i in serverlist:
		i.get_node("TextureButton").pressed.connect(button_connect_to_server.bind(i.get_meta("ip"),i.get_meta("port")))
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
			match Current_Network_Mode:
				Networking_Mode.Connecting:
					Core.Persistant_Core.show_error("Error: Server Timed Out.")
					Core.Persistant_Core.show_last_room_before_error(10)
			connect_timer.call_deferred("stop")
			break

	TCP.disconnect_from_host()
	call_deferred("emit_signal","NextPing")
	

func send_data(id:Networking_Valid_Types,data:Dictionary):
	#print("Sending Data!")
	var Packet = Template_Packet.duplicate()
	Packet["Type"] = id
	Packet["Content"] = data
	match id:
		Networking_Valid_Types.Client_Packet:
			if Packet["Content"].has("PlayerData"):
				Packet["Content"]["PlayerData"] = {
					"Position" : Core.Persistant_Core.Player.global_position,
					"Rotation" : Core.Persistant_Core.Player.global_rotation,
					"Model_Rotation" : Core.Persistant_Core.Player.get_node("Hub").global_rotation,
					"Current_Animation" : str(Core.Persistant_Core.Player.get_node("Hub/Cubiix_Model/AnimationTree").get("parameters/Player_State/playback").get_current_node()),
				}
			if Packet["Content"].has("Update_PlayerChar"):
				Packet["Content"]["Update_PlayerChar"] = Core.Character_Gen.export_char(Core.Persistant_Core.Player)
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
		Networking_Valid_Types.Error:
			TCP.disconnect_from_host()
			Core.Persistant_Core.show_error(data["Content"]["Code"])
			Core.Persistant_Core.show_last_room_before_error(1)
		Networking_Valid_Types.Tick_Packet:
			print(data["Content"])
			if data["Content"].has("Unlock_Screen"):
				Core.Persistant_Core.call_deferred("show_play_screen")
			if data["Content"].has("Character_Update"):
				for i in data["Content"]["Character_Update"]:
					if char_data.has(i):
						char_data[i]["Node"].call_deferred("set_network_val", data["Content"]["Character_Update"][i])

				call_deferred("send_data",Networking_Valid_Types.Client_Packet,{"PlayerData":{}})
			if data["Content"].has("Spawn_Players"):
				for i in data["Content"]["Spawn_Players"]:
					var newplayer = load("res://Assets/Scenes/Client/cubiix_base.tscn").instantiate()
					#newplayer.hide()
					newplayer.name = i
					newplayer.Is_Networked = true
					char_data[i] = templatechar.duplicate(true)
					char_data[i]["Node"] = newplayer
					Core.Persistant_Core.get_node("Node3D/Network_Players").call_deferred("add_child", newplayer)
					
			if data["Content"].has("Despawn_Players"):
				for i in data["Content"]["Despawn_Players"]:
					if char_data.has(i):
						char_data[i]["Node"].call_deferred("queue_free")
						char_data.erase(i)
						
			if data["Content"].has("Update_Players"):
				for i in data["Content"]["Update_Players"]:
					if char_data.has(i):
						char_data[i]["Node"].call_deferred("queue_char_update",data["Content"]["Update_Players"][i])
			
func _exit_tree() -> void:
	NetworkThread.wait_to_finish()

func disable_connection():
	connect_timer.call_deferred("stop")
	match Current_Network_Mode:
		Networking_Mode.Connecting:
			Core.Persistant_Core.show_error("Error: Server Timed Out.")
			Core.Persistant_Core.show_last_room_before_error(1)
	disable_connect = true
