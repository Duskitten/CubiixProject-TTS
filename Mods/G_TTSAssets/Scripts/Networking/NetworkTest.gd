extends Node

var coreobj = null
var clientobj = null
var networkingid = ""

func setup(core:Node, client:Node, netid:String) -> void:
	coreobj = core
	clientobj = client
	networkingid = netid
##This is what we'll send As
##Client A > Client B
#func sender_compile():
	#var data = {}
	#clientobj.append_new_packetdata(networkingid,data)

##This is what we'll recieve As
##Client B
func reciever_parse(data:Dictionary):
	clientobj.networkscriptlist["G_TTSAssets:playerjoin"].sender_compile()
	print("Hi!")
