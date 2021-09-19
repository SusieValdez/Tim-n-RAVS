extends Sprite

const ROTATION_SPEED = 5

func _physics_process(delta):
	rotation += delta * ROTATION_SPEED

func _on_Area2D_body_entered(body):
	if body is Player:
		Globals.add_capsule()
	queue_free()
