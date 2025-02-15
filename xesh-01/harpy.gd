extends CharacterBody2D
var move = Vector2()

const SPEED = 20.0
const JUMP_VELOCITY = -400.0

func _ready():
	$AnimatedSprite2D.play()
	position = get_parent().get_node("Start").position


func _physics_process(_delta):
	move.x = 0
	move.y = 0
	if Input.is_action_pressed("move_up"):
		move.y =- SPEED
	if Input.is_action_pressed("move_down"):
		move.y =+ SPEED
	if Input.is_action_pressed("move_left"):
		move.x =- SPEED
	if Input.is_action_pressed("move_right"):
		move.x =+ SPEED
		
	move_and_slide()
	position += move
