extends CharacterBody2D

const GRAVITY = 0.8
const SPEED = 5.0
const FIRST_JUMP = 18.0
const DOUBLE_JUMP = 17.0
const MAXFALLSPEED = 30
const GLIDINGSPEED = 2

var move = Vector2(0, 0)
var fallspeed = MAXFALLSPEED
var doublejump = 0
var onfloor = 0

func _ready():
	$AnimatedSprite2D.play()

func _physics_process(_delta):
	move.x = 0
	move.y += GRAVITY 
	onfloor = is_on_floor()
	
	if onfloor:
		doublejump = 1
	if Input.is_action_pressed("move_up") && !onfloor:
		fallspeed = GLIDINGSPEED
	else:
		fallspeed = MAXFALLSPEED
	if move.y > fallspeed:
		move.y = fallspeed
	if Input.is_action_just_pressed("move_up"):
		if onfloor:
			move.y = -FIRST_JUMP
		else:
			if doublejump != 0:
				doublejump = 0
				move.y = -DOUBLE_JUMP
	if Input.is_action_pressed("move_left"):
		move.x -= SPEED
		$AnimatedSprite2D.flip_h = move.x < 0
	if Input.is_action_pressed("move_right"):
		move.x += SPEED
		$AnimatedSprite2D.flip_h = move.x < 0

	position += move
	move_and_slide()
	if (move.y < 0) || !onfloor:
		if (move.y > 10):
			$AnimatedSprite2D.animation = "Fall"
		else:
			$AnimatedSprite2D.animation = "Fly"
	elif move.x != 0:
		$AnimatedSprite2D.animation = "Walk"
	else:
		$AnimatedSprite2D.animation = "Idle"
