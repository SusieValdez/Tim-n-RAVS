extends StaticBody2D

func _on_Area2D_body_entered(body):
	if body is Player:
		body.set_speed_offset(-250)

func _on_Area2D_body_exited(body):
	if body is Player:
		body.set_speed_offset(0)
