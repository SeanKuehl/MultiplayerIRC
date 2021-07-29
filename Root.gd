extends Control


func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")


func _on_CreateServer_pressed():
	var net = NetworkedMultiplayerENet.new()
	net.create_server(6969, 2)	#this port number is fine, I can keep it the way it is and max 2 connections is fine for this application
	get_tree().set_network_peer(net)
	


func _on_Join_Server_pressed():
	var net = NetworkedMultiplayerENet.new()
	#net.create_client("127.0.0.1", 6969) #this attempts a connection, the IP is the device(of all the devices in the world), 
	#IP 127... uses the current device(localhost). I would have to replace this with the port I forward.
	#for Riley to be able to connect, otherwise it would try to connect to an open server on his computer which would not exist
	#this is still useful for testing
	net.create_client("", 6969)	#I'll need to put the IP that Riley forwards here, 
	get_tree().set_network_peer(net)


func _player_connected(id):
	Globals.player2id = id
	var game = preload("res://IRC.tscn").instance()
	
	get_tree().get_root().add_child(game)
	hide()
