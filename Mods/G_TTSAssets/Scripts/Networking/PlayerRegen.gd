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
		"character":"",
		"animation":"",
		"transform":Transform3D()
	}
	clientobj.append_new_packetdata(networkingid,data)

##This is what we'll recieve As
##Client B
func reciever_parse(data:Dictionary):
	##This is where we recieve a character updoot.
	##This will just find an existing player and update the mesh/texture/color/etc
	pass
