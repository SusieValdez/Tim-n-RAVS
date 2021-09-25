extends Node2D

var entered_god_ray = false

func _on_EvilCapsule_evil_capsule_collected():
	$RAVS.turn_evil()

func _on_Area2D_body_entered(body):
	if body is Player and not entered_god_ray:
		entered_god_ray = true
		$AnimationPlayer.play("EndCutScene")
		$Player.is_frozen = true
		$RAVS.is_frozen = true
