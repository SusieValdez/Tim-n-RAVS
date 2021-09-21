extends Sprite

const ROTATION_SPEED = 5

# Prevents race condition where capsule is captured multiple times
var captured = false

func _physics_process(delta):
	rotation += delta * ROTATION_SPEED

func _on_Area2D_body_entered(body):
	if body is Player and not captured:
		Globals.add_capsule()
		Globals.random_child($Sounds).play()
		visible = false
		captured = true

func _on_PickupCapsuleAudio_finished():
	queue_free()
