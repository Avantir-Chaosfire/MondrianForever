extends Area2D

var wallClass = preload("res://scene/object/Wall/Wall.tscn")

onready var borderDetector = get_node("BorderDetector")

const rayCastDistance = 4000

var paintColour = "white"
var wall = null

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
	if paintColour == "black":
		get_parent().remove_child(wall)
		z_index = -1
	
	paintColour = newPaintColour
	if paintColour == "white":
		modulate = Color("FFFFFF")
	elif paintColour == "black":
		modulate = Color("000000")
		wall = wallClass.instance()
		wall.position = position
		wall.scale = scale
		get_parent().add_child(wall)
		z_index = 1
	elif paintColour == "red":
		modulate = Color("FF0E00")
	elif paintColour == "blue":
		modulate = Color("286FFE")
	elif paintColour == "yellow":
		modulate = Color("FAFF08")
		
func isPaintArea():
	return true
