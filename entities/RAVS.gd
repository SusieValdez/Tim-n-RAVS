extends KinematicBody2D

onready var animationPlayer = $AnimationPlayer

func _ready():
	animationPlayer.play("Hover")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
