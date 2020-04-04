extends Node2D

var levelClasses = [
	preload("res://scene/level/1/Level1.tscn"),
	preload("res://scene/level/1/Level1_tutorial.tscn")
]

var currentLevel = null
var currentLevelIndex = 0

func _ready():
	currentLevel = levelClasses[currentLevelIndex].instance()
	add_child(currentLevel)

func _process(delta):
	if Input.is_action_just_pressed("next_level"):
		advanceLevel()
		
func advanceLevel():
	remove_child(currentLevel)
	currentLevelIndex += 1
	if currentLevelIndex >= len(levelClasses):
		currentLevelIndex = 0
	currentLevel = levelClasses[currentLevelIndex].instance()
	add_child(currentLevel)
