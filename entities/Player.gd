class_name Player
extends KinematicBody2D

const SPEED = 400
const GRAVITY = 35
const JUMPFORCE = -700
const WALL_FRICTION = 0.5
const DASH_SPEED = 400
const DASH_COOLDOWN_SECS = 4

const LEFT = "Left"
const RIGHT = "Right"

onready var sprite = $Sprite

const MAX_NUM_JUMPS = 2

var velocity = Vector2(0,0)
var num_jumps = 0
var direction = RIGHT
var wall_jump_direction = null
var was_recently_sliding = false
var speed_offset = 0
var num_secs_until_dash = 0
var is_dashing = false
var is_dying = false

func _ready():
	Globals.player = self

func _physics_process(_delta):
	# Disable input while dashing
	if not is_dashing:
		if Input.is_action_pressed("right"):
			direction = RIGHT
			velocity.x = SPEED
		elif Input.is_action_pressed("left"):
			direction = LEFT
			velocity.x = -SPEED
		else:
			velocity.x = 0
	else:
		if direction == LEFT:
			velocity.x -= DASH_SPEED
		else:
			velocity.x += DASH_SPEED
	
	var can_dash = num_secs_until_dash == 0
	if Input.is_action_just_pressed("dash") and can_dash:
		Globals.random_child($Sounds/Dash).play()
		is_dashing = true
		num_secs_until_dash = DASH_COOLDOWN_SECS - 1
		$DashLifetime.start()
		$DashCooldown.start()

	velocity.y = velocity.y + GRAVITY
	
	var is_wall_sliding = not is_on_floor() and is_on_wall()

	if is_wall_sliding and velocity.y > 0 and direction != wall_jump_direction:
		velocity.y *= WALL_FRICTION

	if is_on_floor():
		wall_jump_direction = null
		num_jumps = 0
	elif is_on_wall():
		was_recently_sliding = true
		$WasSlidingCooldown.start()
		num_jumps = 1
	# Can still jump for a bit after walking off platform: "Cyote Time"
	if not is_on_floor() and num_jumps == 0:
		$WalkOffPlatformCooldown.start()
	# Can only jump iff:
	# - Jump button is pressed (duh)
	# - We have an available jump slot
	# - We're jumping on a different wall as last time
	# - If we fall off the wall, we have to wait sometime before being allowed to jump again
	if Input.is_action_just_pressed("jump") and num_jumps < MAX_NUM_JUMPS and direction != wall_jump_direction and (is_on_wall() or not was_recently_sliding):
		if num_jumps == 0:
			Globals.random_child($Sounds/Jump).play()
		if num_jumps == 1:
			Globals.random_child($Sounds/DoubleJump).play()
		num_jumps += 1
		velocity.y = JUMPFORCE
		if is_wall_sliding:
			wall_jump_direction = direction
			if direction == RIGHT:
				velocity.x = -SPEED
			else:
				velocity.x = SPEED

	if is_dashing:
		$AnimationPlayer.play("Dash" + direction)
	elif is_on_floor():
		if velocity.x == 0:
			$AnimationPlayer.play("Idle" + direction)
		else:
			$AnimationPlayer.play("Run" + direction)
	elif is_on_wall():
		$AnimationPlayer.play("WallSlide" + direction)
	else:
		if num_jumps == 1:
			$AnimationPlayer.play("Jump" + direction)
		elif num_jumps == 2:
			$AnimationPlayer.play("Roll" + direction)
			
	velocity.x += clamp(speed_offset, -250, 250)
	velocity = move_and_slide(velocity, Vector2.UP)

func disableInput():
	$AnimationPlayer.play("Roll" + direction)
	set_physics_process(false)

func die():
	# Prevent death sound being played again
	if not is_dying:
		disableInput()
		Globals.random_child($Sounds/Death).play()
		is_dying = true

func _on_DeathAudio_finished():
	Globals.reset_level()

func _on_WalkOffPlatformCoolDown_timeout():
	num_jumps += 1

func _on_WasSlidingCooldown_timeout():
	was_recently_sliding = false

func _on_DashLifetime_timeout():
	is_dashing = false

func _on_DashCooldown_timeout():
	if num_secs_until_dash > 1:
		$DashCooldown.start()
	num_secs_until_dash -= 1
