extends CharacterBody2D
@onready var DashSFX = preload("res://dash_sfx.tscn")

const SCALING = 1
const GRAVITY = 0.8 * SCALING
const SPEED = 5.0 * SCALING
const FIRST_JUMP = 18.0 * SCALING
const DOUBLE_JUMP = 17.0 * SCALING
const MAXFALLSPEED = 30 * SCALING
const GLIDINGSPEED = 2 * SCALING
const DASHSPEED = 20 * SCALING

var move = Vector2(0, 0)
var dashmath = Vector2(0, 0)
var fallspeed = MAXFALLSPEED
var doublejump = 0
var onfloor = 0
var dash = 0
var dashing = 0

func _ready():
	$AnimatedSprite2D.play()

func _physics_process(_delta):
	onfloor = is_on_floor()
	
	if onfloor:
		doublejump = 1
		dash = 1
	if dashing == 0:
		move.y += GRAVITY 
		move.x = 0
		if Input.is_action_pressed("jump") && !onfloor:
			fallspeed = GLIDINGSPEED
		else:
			fallspeed = MAXFALLSPEED
		if move.y > fallspeed:
			move.y = fallspeed
		if Input.is_action_just_pressed("jump"):
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
	else:
		var Sfx = DashSFX.instantiate()
		Sfx.position = position
		Sfx.scale = scale
		Sfx.z_index = -1
		Sfx.sprite($AnimatedSprite2D.frame, $AnimatedSprite2D.flip_h)
		get_parent().add_child(Sfx)

	if Input.is_action_just_pressed("dash") && dash != 0 && dashing == 0:
		dashmath.x = 0
		dashmath.y = 0
		$DashTimer.start()
		if Input.is_action_pressed("move_right"):
			dashmath.x += 1
		if Input.is_action_pressed("move_down"):
			dashmath.y += 1
		if Input.is_action_pressed("move_up"):
			dashmath.y += -1
		if Input.is_action_pressed("move_left"):
			dashmath.x += -1
		if dashmath != Vector2(0, 0):
			dash = 0
			dashing = 1
			move = dashmath.normalized() * DASHSPEED

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

func _on_dash_timer_timeout():
	dashing = 0
