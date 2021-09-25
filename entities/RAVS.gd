extends KinematicBody2D


onready var player = Globals.player

export var is_evil = false

const EVIL_SPEED = 250

var start_face_frame = 10
var time = 0
var velocity = Vector2.ZERO
var is_transforming = false
var is_frozen = false

func _ready():
	if is_evil:
		turn_evil()

func turn_normal():
	is_transforming = true
	is_evil = false
	start_face_frame = 10
	$AnimationPlayer.play("TurnNormal")

func turn_evil():
	is_transforming = true
	is_evil = true
	start_face_frame = 15
	$AnimationPlayer.play("TurnEvil")

func _physics_process(delta):
	time += delta
	if is_frozen:
		return
	if is_evil:
		var direction = global_position.direction_to(player.global_position)
		velocity = move_and_slide(direction * EVIL_SPEED)
	else:
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

	var num_capsules = Globals.get_num_capsules()
	$Ring.frame = player.DASH_COOLDOWN_SECS - 1 - player.num_secs_until_dash
	if not is_transforming:
		$Face.frame = start_face_frame + num_capsules

func _on_AnimationPlayer_animation_finished(_anim_name):
	is_transforming = false

func _on_DeathZone_body_entered(body):
	if is_evil and body is Player:
		body.die()
