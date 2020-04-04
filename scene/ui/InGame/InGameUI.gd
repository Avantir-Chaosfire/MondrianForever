extends Control

var emptyBucketButtonClass = preload("res://scene/ui/EmptyBucketButton/EmptyBucketButton.tscn")
var redBucketButtonClass = preload("res://scene/ui/RedBucketButton/RedBucketButton.tscn")
var yellowBucketButtonClass = preload("res://scene/ui/YellowBucketButton/YellowBucketButton.tscn")
var blueBucketButtonClass = preload("res://scene/ui/BlueBucketButton/BlueBucketButton.tscn")

onready var world = get_node("../..")

const buttonMarginSize = 15
const buttonSpacing = 52

func setAvailableBuckets(amount):
	for i in range(amount):
		addButton(emptyBucketButtonClass.instance(), Vector2(buttonMarginSize + (buttonSpacing * i), buttonMarginSize))
		
func bucketButtonPressed(button, paintColour):
	var character = world.getCharacter()
	var currentPaintArea = character.getCurrentPaintArea()
	if not currentPaintArea == null:
		if not paintColour == currentPaintArea.paintColour:
			if currentPaintArea.paintColour == "white":
				addButton(emptyBucketButtonClass.instance(), button.rect_position)
			elif currentPaintArea.paintColour == "red":
				addButton(redBucketButtonClass.instance(), button.rect_position)
			elif currentPaintArea.paintColour == "yellow":
				addButton(yellowBucketButtonClass.instance(), button.rect_position)
			elif currentPaintArea.paintColour == "blue":
				addButton(blueBucketButtonClass.instance(), button.rect_position)
			currentPaintArea.setPaintColour(paintColour)
			remove_child(button)
			
func addButton(button, position):
	button.rect_position = position
	add_child(button)
