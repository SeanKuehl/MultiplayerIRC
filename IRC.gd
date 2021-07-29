extends Control

var textToSend = ""
var numberOfMessagesSent = 0
var userName = ""

onready var player1pos = $Player1Pos
onready var player2pos = $Player2Pos



func _ready():
	var player1 = preload("res://Player.tscn").instance()
	player1.set_name(str(get_tree().get_network_unique_id()))
	player1.set_network_master(get_tree().get_network_unique_id())
	player1.global_transform = player1pos.global_transform
	add_child(player1)
	
	var player2 = preload("res://Player.tscn").instance()
	player2.set_name(str(Globals.player2id))
	player2.set_network_master(Globals.player2id)
	player2.global_transform = player2pos.global_transform
	add_child(player2)
	
	
	
	


#if is_network_master():
		#	velocity = move_and_slide(velocity, Vector2.UP)
			#rpc_unreliable("_set_position", global_transform.origin)

#remote func executes the code on the client/other people or as the docs say "remotely", rpc probably does it for all other clients
remote func UpdateTextChat(newTextToDisplay):
	$TextBackground/TextDisplay.text = newTextToDisplay


func _on_SendButton_pressed():
	
	#this works!
	if get_tree().is_network_server():
		#Riley will be doing the port forwarding, thus will be hosting so it's his computer
		#that will be the host
		userName = "Riley"
	else:
		userName = "Sean"
	
	textToSend = $TextEnter.text
	$TextBackground/TextDisplay.text += userName+": "+textToSend+"\n"
	numberOfMessagesSent += 1
	
	if numberOfMessagesSent >= 20:
		numberOfMessagesSent = 0
		$TextBackground/TextDisplay.text = ""
	
	#the text stuff doesn't have an explicit network master so that might be why it did nothing
	rpc("UpdateTextChat", $TextBackground/TextDisplay.text)
	
	
