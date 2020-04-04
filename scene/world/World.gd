extends Node2D

var inGameUIClass = preload("res://scene/ui/InGame/InGameUI.tscn")

var levelClasses = [
	preload("res://scene/level/1/Level1.tscn"),
	preload("res://scene/level/1/Level1_tutorial.tscn")
]

onready var gui = get_node("GUI")

var currentLevel = null
var inGameUI = null
var currentLevelIndex = 0

func _ready():
	currentLevel = levelClasses[currentLevelIndex].instance()
	add_child(currentLevel)
	createInGameUI()

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
	
	remove_child(inGameUI)
	createInGameUI()
	
func getCharacter():
	return currentLevel.get_node("Character")
	
func createInGameUI():
	inGameUI = inGameUIClass.instance()
	inGameUI.setAvailableBuckets(3)
	gui.add_child(inGameUI)
