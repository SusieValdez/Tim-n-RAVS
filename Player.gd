extends KinematicBody2D

const SPEED = 400
const GRAVITY = 35
const JUMPFORCE = -700
const MAX_SPEED = 500
const ACCELERATION = 600
const FRICTION = 500


onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

var velocity = Vector2.ZERO
var can_jump = false

enum {
	MOVE, 
}

var state = MOVE

func _process(delta):
	match state:
		MOVE:
			move_state(delta)

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
		if can_jump and Input.is_action_just_pressed("jump"):
			velocity.y = JUMPFORCE
	
	velocity.y = velocity.y + GRAVITY
	if is_on_floor():
		can_jump = true
	if not is_on_floor() and $JumpTimer.is_stopped():
		$JumpTimer.start()
	
	move()
	

func move():
	velocity = move_and_slide(velocity)


func _on_JumpTimer_timeout():
	can_jump = false
