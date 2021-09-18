extends KinematicBody2D

onready var player = Globals.player

var time = 0
var velocity = Vector2.ZERO

func _ready():
	$AnimationPlayer.play("Hover")

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	var distance = global_position.distance_to(player.global_position)
	var close_velocity = Vector2(
		cos(time * 2) * 20 - direction.x,
		sin(time * 5) * 20 - direction.y - 5
	)
	var far_velocity = Vector2(
		direction.x,
		direction.y + sin(time * 5) / 10
	) * pow(distance, 3) / 8000
	velocity = move_and_slide(lerp(close_velocity, far_velocity, distance / 100))
	time += delta
