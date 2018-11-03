extends KinematicBody2D

var motion = Vector2()
export (int) var movementSpeed
export (int) var gravity

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
	motion.y += gravity
	
	if Input.is_action_pressed("ui_right"):
		motion.x = movementSpeed 
	elif Input.is_action_pressed("ui_left"):
		motion.x = -movementSpeed 
	else:
		motion.x = 0
		
	var collision = move_and_collide(motion * delta)
	if collision:
		motion = motion.slide(collision.normal)
	
