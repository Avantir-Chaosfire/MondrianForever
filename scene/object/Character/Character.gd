extends KinematicBody2D

onready var world = get_node("../..")
onready var sprite = get_node("Sprite")
onready var bucketTarget = get_node("BucketTarget")
onready var jumpSoundEffect = get_node("JumpSoundEffect")
onready var landSoundEffect = get_node("LandSoundEffect")
onready var swimSoundEffect = get_node("Swim2SoundEffect")
onready var bucketPickupSoundEffect = get_node("BucketPickupSoundEffect")

const acceleration = 100
const maxMovementSpeed = 210
const initialJumpSpeed = 430
const yellowJumpSpeedMultiplier = 1.45
const friction = 50
const gravity = 19.6

var velocity = Vector2()
var onGround = false

func _physics_process(delta):
	var paintColours = getOverlappingPaintColours()
	
	if "blue" in paintColours:
		processSwimming(delta)
	else:
		processWalking(delta, paintColours)
		
	var willCollide = test_move(transform, Vector2(0, velocity.y) * delta)
	velocity = move_and_slide(velocity)
	
	if not onGround and willCollide:
		landSoundEffect.play(0.07)
	
	if willCollide:
		velocity.y = 0
		onGround = true
	else:
		onGround = false
		
	if onGround:
		sprite.frame = 0
	else:
		sprite.frame = 1
		
func processSwimming(delta):
	applyHorizontalFriction()
	moveHorizontally()
	
	applyVerticalFriction()
	moveVertically()
	
func processWalking(delta, paintColours):
	applyHorizontalFriction()
	moveHorizontally()
	
	velocity.y += gravity

	if onGround and Input.is_action_just_pressed("jump") and not "red" in paintColours:
		jumpSoundEffect.play()
		velocity.y = -initialJumpSpeed
		if "yellow" in paintColours:
			velocity.y *= yellowJumpSpeedMultiplier
	
func applyHorizontalFriction():
	if abs(velocity.x) < friction:
		velocity.x = 0
	elif velocity.x > 0:
		velocity.x -= friction
	else:
		velocity.x += friction
	
func applyVerticalFriction():
	if abs(velocity.y) < friction:
		velocity.y = 0
	elif velocity.y > 0:
		velocity.y -= friction
	else:
		velocity.y += friction
		
func moveHorizontally():
	if Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
		velocity.x -= acceleration
	elif Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
		velocity.x += acceleration
		
	if abs(velocity.x) > maxMovementSpeed:
		if velocity.x > 0:
			velocity.x = maxMovementSpeed
		else:
			velocity.x = -maxMovementSpeed
		
func moveVertically():
	var moveUp = Input.is_action_pressed("move_up") or Input.is_action_pressed("jump")
	if moveUp and not Input.is_action_pressed("move_down"):
		velocity.y -= acceleration
	elif Input.is_action_pressed("move_down") and not moveUp:
		velocity.y += acceleration
		
	if abs(velocity.y) > maxMovementSpeed:
		if velocity.y > 0:
			velocity.y = maxMovementSpeed
		else:
			velocity.y = -maxMovementSpeed

func getOverlappingPaintColours():
	var colours = []
	for node in get_parent().get_children():
		if node is Area2D and node.isPaintArea() and node.overlaps_body(self):
			colours.append(node.paintColour)
	return colours
	
func getCurrentPaintArea():
	for node in get_parent().get_children():
		if node is Area2D and node.isPaintArea() and node.overlaps_area(bucketTarget):
			return node
	return null

func _on_SwimSoundTimer_timeout():
	if "blue" in getOverlappingPaintColours():
		swimSoundEffect.play()
		
func collectBucket():
	bucketPickupSoundEffect.play()
	world.addBucket()
