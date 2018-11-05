extends KinematicBody2D

var gravity = 10

var firing = false

export (float) var chargeRate = 200

var charging = false
var chargePower = 0
var chargeDown = false

var motion = Vector2()

# export vars
export (int) var movementSpeed

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
func _process(delta):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		if !charging:
			chargePower = 0
			charging = true
			$DoggoTank.isActive = false
	
	else:
		if charging:
			print("fire projectile with power: ", chargePower)
			charging = false
		$DoggoTank.isActive = true
	
	handle_charge(delta)
	

func _physics_process(delta):
	handle_movement(delta)
	
func handle_movement(delta):	
	motion.y += gravity
	
	if Input.is_action_pressed("ui_right") && !charging:
		motion.x = movementSpeed 
		$DoggoTank.moving = true
		$DoggoTank.backwards = true
	elif Input.is_action_pressed("ui_left") && !charging:
		motion.x = -movementSpeed 
		$DoggoTank.moving = true
		$DoggoTank.backwards = false
	else:
		motion.x = 0
		$DoggoTank.moving = false
		
	var collision = move_and_collide(motion * delta)
	if collision:
		motion = motion.slide(collision.normal)
	
func drawChargeBar():
	$ChargeBorder.visible = true
	$ChargeBar.visible = true
	$ChargeBar.scale = Vector2(chargePower / 100, 1)
	
func hideChargeBar():
	$ChargeBorder.visible = false
	$ChargeBar.visible = false
	
func handle_charge(delta):
	if charging:
		if chargeDown:
			chargePower -= chargeRate * delta
		else:
			chargePower += chargeRate * delta
			
		chargePower = clamp(chargePower, 0, 100)
				
		if chargePower == 100:
			chargeDown = true
		elif chargePower == 0:
			chargeDown = false
		
		drawChargeBar()
	else:
		hideChargeBar()
