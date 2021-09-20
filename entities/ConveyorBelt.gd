extends StaticBody2D

export var flipped = false
var speed_offset = 250 if flipped else -250

func _ready():
	$AnimatedSprite.flip_h = flipped

func _on_Area2D_body_entered(body):
	if body is Player:
		body.speed_offset += speed_offset

func _on_Area2D_body_exited(body):
	if body is Player:
		body.speed_offset -= speed_offset
