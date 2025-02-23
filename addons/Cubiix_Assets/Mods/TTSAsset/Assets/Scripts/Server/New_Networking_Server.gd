extends Node
@onready var Core = get_node("/root/Main_Scene/CoreLoader")
var NetworkThread = Thread.new()
var TCP = TCPServer.new()

enum networkCommand {
	ping, ## This will be for initial pinging in serverlist
	update, ## This will happen every time a server ping happens, and when recieving the data back
	chat_update ## Every time we send a chat messege
}
