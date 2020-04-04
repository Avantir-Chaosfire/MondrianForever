extends Control

var emptyBucketButtonClass = preload("res://scene/ui/EmptyBucketButton/EmptyBucketButton.tscn")
var redBucketButtonClass = preload("res://scene/ui/RedBucketButton/RedBucketButton.tscn")
var yellowBucketButtonClass = preload("res://scene/ui/YellowBucketButton/YellowBucketButton.tscn")
var blueBucketButtonClass = preload("res://scene/ui/BlueBucketButton/BlueBucketButton.tscn")

onready var world = get_node("../..")
onready var fillBucketSoundEffect = get_node("FillBucketSound")
onready var emptyBucketSoundEffect = get_node("EmptyBucketSound")

const buttonMarginSize = 15
const buttonSpacing = 52

func setAvailableBuckets(amount):
	for i in range(amount):
		var hotkey = "bucket_" + str(i + 1)
		addButton(emptyBucketButtonClass.instance(), hotkey, Vector2(buttonMarginSize + (buttonSpacing * i), buttonMarginSize))
		
func bucketButtonPressed(button, paintColour):
	var character = world.getCharacter()
	var currentPaintArea = character.getCurrentPaintArea()
	if not currentPaintArea == null:
		if not paintColour == currentPaintArea.paintColour and "white" in [paintColour, currentPaintArea.paintColour]:
			if currentPaintArea.paintColour == "white":
				addButton(emptyBucketButtonClass.instance(), button.hotkey, button.rect_position)
				emptyBucketSoundEffect.play()
			elif currentPaintArea.paintColour == "red":
				addButton(redBucketButtonClass.instance(), button.hotkey, button.rect_position)
				fillBucketSoundEffect.play()
			elif currentPaintArea.paintColour == "yellow":
				addButton(yellowBucketButtonClass.instance(), button.hotkey, button.rect_position)
				fillBucketSoundEffect.play()
			elif currentPaintArea.paintColour == "blue":
				addButton(blueBucketButtonClass.instance(), button.hotkey, button.rect_position)
				fillBucketSoundEffect.play()
			currentPaintArea.setPaintColour(paintColour)
			remove_child(button)
			
func addButton(button, hotkey, position):
	button.rect_position = position
	button.hotkey = hotkey
	add_child(button)
