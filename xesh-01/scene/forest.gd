extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Environment/Camera2D.position = $Environment/Harpy.position
	$Environment/StaticBody2D.position = Vector2($Environment/Camera2D.position.x, $Environment/StaticBody2D.position.y)
