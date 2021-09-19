extends AnimatedSprite

export var next_scene: PackedScene

const ROTATION_SPEED = 5

func _physics_process(delta):
	rotation += delta * ROTATION_SPEED

func _on_Area2D_body_entered(body):
	Globals.next_level()
	if body is Player:
		# warning-ignore:return_value_discarded
		get_tree().change_scene_to(next_scene)
