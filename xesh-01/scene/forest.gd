extends Node2D
var player
var camera
var basicGround
var offset = Vector2(200, -300)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node("Harpy")
	camera = get_node("Camera2D")
	basicGround = get_node("StaticBody2D")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	camera.position = player.position + offset
	basicGround.position = Vector2(camera.position.x, basicGround.position.y)
