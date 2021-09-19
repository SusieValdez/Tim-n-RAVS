extends Node2D

export var start_time = 0.0

func _ready():
	$AnimationPlayer.play("Crush")
	$AnimationPlayer.seek(start_time, true)


func _on_Area2D_body_entered(body):
	if body is Player:
		body.die()
