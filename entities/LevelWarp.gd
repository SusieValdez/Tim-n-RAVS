extends AnimatedSprite

const ROTATION_SPEED = 1

func _physics_process(delta):
	rotation += delta * ROTATION_SPEED

func _on_Area2D_body_entered(body):
	if body is Player:
		body.disableInput()
		Globals.random_child($Sounds).play()

func _on_TeleportAudio_finished():
	Globals.next_level()
