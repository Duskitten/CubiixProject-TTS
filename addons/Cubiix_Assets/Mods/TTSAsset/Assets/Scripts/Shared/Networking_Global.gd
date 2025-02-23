class_name NetworkingGlobal
extends Node

## This script is designed to hold networking global variables for the 
## networking functions, so I can actually use them sanely.

## Put all **essential** things in this enum
enum networkCommand_TCP { 
	ping_init, ## This will be for when we initially interact
	ping_response, ## This will be for when we need to send back the server info
	
	player_update, ## This will happen every time a server ping happens, and when recieving the data back
	spawn_player, ## This is for spawning a new player.
	despawn_player, ## This is for removing a player
	
	chat_update ## Every time we send a chat messege
}
