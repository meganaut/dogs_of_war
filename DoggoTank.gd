extends Node2D

export (bool) var moving
export (bool) var backwards
export (int) var jiggleFrames = 10
export (int) var jigglePixels = 5

var jiggleCount = 0

func _ready():
	pass

func _process(delta):
	if moving:
		$Treads.play('moving')
		shouldJiggle()
	else:
		$Treads.play('stopped')
	
	flippo(backwards)

func shouldJiggle():
	jiggleCount+=1
	var jigglo = jiggleCount % (jiggleFrames *2)
	var offset = $Doggo.offset
	
	if jigglo == jiggleFrames:
		$Doggo.offset = Vector2(offset.x, 0)
	if jigglo == 0:
		jiggleCount = 0
		$Doggo.offset = Vector2(offset.x, jigglePixels)
		
func flippo(flip):	
	$Doggo.set_flip_h(flip)
	$Treads.set_flip_h(flip)
	$Doggo/Turret.set_flip_h(flip)
	
	if flip:
		$Doggo.offset = Vector2(60, $Doggo.offset.y)
	else:
		$Doggo.offset = Vector2(0, $Doggo.offset.y)
