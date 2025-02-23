extends Node
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
var NetworkThread = Thread.new()
var TCP = StreamPeerTCP.new()
