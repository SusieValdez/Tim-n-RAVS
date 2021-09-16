extends KinematicBody2D

const SPEED = 400
const GRAVITY = 35
const JUMPFORCE = -700

onready var sprite = $Sprite

var velocity = Vector2(0,0)
var can_jump = false
var num_jumps = 0
var direction = "Right"

func _physics_process(_delta):
	if Input.is_action_pressed("right"):
		direction = "Right"
		velocity.x = SPEED
	elif Input.is_action_pressed("left"):
		direction = "Left"
		velocity.x = -SPEED
	else:
		velocity.x = 0

	velocity.y = velocity.y + GRAVITY

	if is_on_floor():
		num_jumps = 0
	if not is_on_floor() and num_jumps == 0:
		$JumpTimer.start()
	if num_jumps < 2 and Input.is_action_just_pressed("jump"):
		velocity.y = JUMPFORCE
		num_jumps += 1
		
	if is_on_floor():
		if velocity.x == 0:
			$AnimationPlayer.play("Idle" + direction)
		else:
			$AnimationPlayer.play("Run" + direction)
	else:
		$AnimationPlayer.play("Jump" + direction)

	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.x = lerp(velocity.x, 0, 0.2)

func _on_JumpTimer_timeout():
	num_jumps += 1
