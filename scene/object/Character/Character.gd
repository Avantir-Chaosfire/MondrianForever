extends KinematicBody2D

onready var sprite = get_node("Sprite")

var acceleration = 100
var maxMovementSpeed = 210
var initialJumpSpeed = 380
var friction = 50
var gravity = 19.6

var velocity = Vector2()
var onGround = false

func _physics_process(delta):
	if abs(velocity.x) < friction:
		velocity.x = 0
	elif velocity.x > 0:
		velocity.x -= friction
	else:
		velocity.x += friction
		
	velocity.y += gravity
	
	if Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
		velocity.x -= acceleration
	elif Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
		velocity.x += acceleration
		
	if abs(velocity.x) > maxMovementSpeed:
		if velocity.x > 0:
			velocity.x = maxMovementSpeed
		else:
			velocity.x = -maxMovementSpeed

	if onGround and Input.is_action_just_pressed("jump"):
		velocity.y = -initialJumpSpeed

	var willCollide = test_move(transform, Vector2(0, velocity.y) * delta)
	move_and_slide(velocity)
	if willCollide:
		velocity.y = 0
		onGround = true
	else:
		onGround = false
		
	if onGround:
		sprite.frame = 0
	else:
		sprite.frame = 1
