extends KinematicBody2D

const SPEED = 400
const GRAVITY = 35
const JUMPFORCE = -700

onready var sprite = $Sprite

var velocity = Vector2(0,0)
var can_jump = false

func _physics_process(_delta):
	if Input.is_action_pressed("right"):
		velocity.x = SPEED
		sprite.flip_h = false
	elif Input.is_action_pressed("left"):
		velocity.x = -SPEED
		sprite.flip_h = true
	
	velocity.y = velocity.y + GRAVITY
	print(is_on_floor(), can_jump)
	if is_on_floor():
		can_jump = true
	if not is_on_floor() and $JumpTimer.is_stopped():
		$JumpTimer.start()
	
	if can_jump and Input.is_action_just_pressed("jump"):
		velocity.y = JUMPFORCE
	
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.x = lerp(velocity.x, 0, 0.2)

func _on_JumpTimer_timeout():
	can_jump = false
