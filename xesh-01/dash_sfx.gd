extends Node2D
var free = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var twiner = create_tween()
	twiner.tween_property(self, "modulate", Color(1, 1, 1, 0), 0.2)
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if free == 1:
		queue_free()

func _on_timer_timeout():
	free = 1

func sprite(value):
	$AnimatedSprite2D.frame = value
