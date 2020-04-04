extends Area2D

onready var borderDetector = get_node("BorderDetector")

const rayCastDistance = 4000

var paintColour = "white"

func _ready():
	var negativeXDistance = getBorderDistance(Vector2(-1, 0))
	var positiveXDistance = getBorderDistance(Vector2(1, 0))
	var negativeYDistance = getBorderDistance(Vector2(0, -1))
	var positiveYDistance = getBorderDistance(Vector2(0, 1))
	
	position.x += (positiveXDistance - negativeXDistance) / 2
	position.y += (positiveYDistance - negativeYDistance) / 2
	scale.x = positiveXDistance + negativeXDistance
	scale.y = positiveYDistance + negativeYDistance
	
	borderDetector.enabled = false

func getBorderDistance(direction):
	borderDetector.cast_to = direction * rayCastDistance
	borderDetector.force_raycast_update()
	if borderDetector.is_colliding():
		return (position - get_parent().to_local(borderDetector.get_collision_point())).length()
	return 0

func setPaintColour(newPaintColour):
	paintColour = newPaintColour
	if paintColour == "white":
		modulate = Color(255, 255, 255)
	elif paintColour == "black":
		modulate = Color(0, 0, 0)
	elif paintColour == "red":
		modulate = Color(255, 0, 0)
	elif paintColour == "blue":
		modulate = Color(0, 0, 255)
	elif paintColour == "yellow":
		modulate = Color(255, 255, 0)
