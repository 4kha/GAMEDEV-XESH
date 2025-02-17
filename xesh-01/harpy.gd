extends CharacterBody2D
var move = Vector2(0, 0)
var gravity = 1

const SPEED = 5.0
const JUMP_VELOCITY = 25.0
const MAXFALLSPEED = 50

func _ready():
	$AnimatedSprite2D.play()
	position = get_parent().get_node("Start").position


func _physics_process(delta):
	move.x = 0
	move.y += gravity 
	if move.y > MAXFALLSPEED:
		move.y = MAXFALLSPEED
	if Input.is_action_pressed("move_up"):
		if is_on_floor():
			move.y -= JUMP_VELOCITY
	if Input.is_action_pressed("move_left"):
		move.x -= SPEED
	if Input.is_action_pressed("move_right"):
		move.x += SPEED

	position += move
	move_and_slide()

	if move.x != 0:
		$AnimatedSprite2D.animation = "Walk"
		$AnimatedSprite2D.flip_h = move.x < 0
	else:
		$AnimatedSprite2D.animation = "Idle"
	if move.y < 0 || !is_on_floor():
		$AnimatedSprite2D.animation = "Fly"
