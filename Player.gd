extends KinematicBody2D



var speed = 40


var velocity = Vector2.ZERO

remote func _set_position(pos):
	global_transform.origin = pos

func get_input():
	velocity.y = 0
	if Input.is_action_pressed("walk_up"):
		velocity.y += speed
	if Input.is_action_pressed("walk_down"):
		velocity.y -= speed

func _physics_process(delta):
	get_input()
	
	
	
	if is_network_master():
			velocity = move_and_slide(velocity, Vector2.UP)
			rpc_unreliable("_set_position", global_transform.origin)
	
