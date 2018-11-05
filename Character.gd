extends KinematicBody2D

var motion = Vector2()
var gravity = 10

# export vars
export (int) var movementSpeed

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
	motion.y += gravity
	
	if Input.is_action_pressed("ui_right"):
		motion.x = movementSpeed 
		$DoggoTank.moving = true
		$DoggoTank.backwards = true
	elif Input.is_action_pressed("ui_left"):
		motion.x = -movementSpeed 
		$DoggoTank.moving = true
		$DoggoTank.backwards = false
	else:
		motion.x = 0
		$DoggoTank.moving = false
		
	var collision = move_and_collide(motion * delta)
	if collision:
		motion = motion.slide(collision.normal)
	
