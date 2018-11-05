extends Node2D

export (bool) var moving
export (bool) var backwards
export (int) var jiggleFrames = 10
export (int) var jigglePixels = 5

export (bool) var isActive = false

var jiggleCount = 0

func _ready():
	pass

func _process(delta):
	if !isActive:
		$Treads.play('stopped')
		return
	
	if moving:
		$Treads.play('moving')
		shouldJiggle()
	else:
		$Treads.play('stopped')
	
	flippo(backwards)
	
	aim_Barrel()

func shouldJiggle():
	jiggleCount+=1
	var jigglo = jiggleCount % (jiggleFrames *2)
	
	if jigglo == jiggleFrames:
		$Doggo.offset = Vector2($Doggo.offset.x, 0)
		$Doggo/Turret.offset = Vector2($Doggo/Turret.offset.x, 0)
		
	if jigglo == 0:
		jiggleCount = 0
		$Doggo.offset = Vector2($Doggo.offset.x, jigglePixels)
		$Doggo/Turret.offset = Vector2($Doggo/Turret.offset.x, jigglePixels)
		
func flippo(flip):
	$Doggo.set_flip_h(flip)
	$Treads.set_flip_h(flip)
	$Doggo/Turret.set_flip_h(flip)
	
	if flip:
		$Doggo.offset = Vector2(60, $Doggo.offset.y)
		
	else:
		$Doggo.offset = Vector2(0, $Doggo.offset.y)
		
func aim_Barrel():
	var mousePos = get_global_mouse_position()
	
	var offset = 180
	if backwards:
		offset = 270
	
	var lookAngle = rad2deg(mousePos.angle_to_point($Doggo/Barrel.global_position)) + 360 
	
	## add some math trickery so the crossover point is dead under the tank.
	if lookAngle > 450:
		lookAngle -= 360
	
	var clampedAngl = deg2rad(clamp(lookAngle, offset, 90 + offset))
	
	$Doggo/Barrel.set_rotation(clampedAngl)
	
