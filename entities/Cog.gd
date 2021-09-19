extends AnimatedSprite

export var flipped = false

func _ready():
	flip_h = flipped

func _on_Area2D_body_entered(body):
	if body is Player:
		body.die()
