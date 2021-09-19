extends KinematicBody2D

const START_FACE_FRAME = 5

onready var player = Globals.player

var time = 0
var velocity = Vector2.ZERO

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

	var num_capsules = Globals.get_num_capsules()
	$Face.frame = START_FACE_FRAME + num_capsules
	$Ring.frame = player.DASH_COOLDOWN_SECS - 1 - player.num_secs_until_dash
