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
func sender_compile():
	var data = {
		"room":"",
		"animation":"",
		"transform":Transform3D()
	}
	clientobj.append_new_packetdata(networkingid,data)

##This is what we'll recieve As
##Client B
func reciever_parse(data:Dictionary):
	##This is where we would update and move the player and stuff.
	##We dont have players yet so, cant yet.
	pass
