extends Node2D

var inGameUIClass = preload("res://scene/ui/InGame/InGameUI.tscn")
var victoryMenuClass = preload("res://scene/ui/Victory/Victory.tscn")

var levelClasses = [
	preload("res://scene/level/1/Level1.tscn"),
	preload("res://scene/level/1/Level1_tutorial.tscn"),
	preload("res://scene/level/2/Level2.tscn"),
]

onready var gui = get_node("GUI")
onready var victorySoundEffect = get_node("VictorySoundEffect")

var currentLevel = null
var inGameUI = null
var currentLevelIndex = 0
var victory = false

func _ready():
	currentLevel = levelClasses[currentLevelIndex].instance()
	add_child(currentLevel)
	createInGameUI()

func _process(delta):
	if Input.is_action_just_pressed("restart_level"):
		restartLevel()
	elif Input.is_action_just_pressed("next_level"):
		advanceLevel()
		
	if not victory:
		var satisfiesVictoryCondition = true
		for node in currentLevel.get_children():
			if node is StaticBody2D and node.isSplash():
				if not node.correctColour:
					satisfiesVictoryCondition = false
		if satisfiesVictoryCondition:
			victory()
		
func victory():
	victory = true
	victorySoundEffect.play()
	gui.add_child(victoryMenuClass.instance())
		
func advanceLevel():
	victory = false
	remove_child(currentLevel)
	currentLevel.queue_free()
	currentLevelIndex += 1
	if currentLevelIndex >= len(levelClasses):
		currentLevelIndex = 0
	currentLevel = levelClasses[currentLevelIndex].instance()
	add_child(currentLevel)
	
	gui.remove_child(inGameUI)
	inGameUI.queue_free()
	createInGameUI()
	
func restartLevel():
	remove_child(currentLevel)
	currentLevel.queue_free()
	currentLevel = levelClasses[currentLevelIndex].instance()
	add_child(currentLevel)
	
	gui.remove_child(inGameUI)
	inGameUI.queue_free()
	createInGameUI()
	
func getCharacter():
	return currentLevel.get_node("Character")
	
func createInGameUI():
	inGameUI = inGameUIClass.instance()
	inGameUI.setAvailableBuckets(currentLevel.availableBucketCount)
	gui.add_child(inGameUI)
