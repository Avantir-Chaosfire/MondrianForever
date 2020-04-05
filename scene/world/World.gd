extends Node2D

var inGameUIClass = preload("res://scene/ui/InGame/InGameUI.tscn")
var victoryMenuClass = preload("res://scene/ui/Victory/Victory.tscn")
var finalVictoryMenuClass = preload("res://scene/ui/FinalVictory/FinalVictory.tscn")
var titleClass = preload("res://scene/ui/Title/Title.tscn")

var levelClasses = [
	preload("res://scene/level/1/Level1.tscn"),
	preload("res://scene/level/2/Level2.tscn"),
	preload("res://scene/level/3/Level3.tscn"),
	preload("res://scene/level/4/Level4.tscn"),
	preload("res://scene/level/5/Level5.tscn"),
	preload("res://scene/level/6/Level6.tscn")
]

onready var gui = get_node("GUI")
onready var victorySoundEffect = get_node("VictorySoundEffect")
onready var finalVictorySoundEffect = get_node("FinalVictorySoundEffect")

var currentLevel = null
var inGameUI = null
var currentLevelIndex = 0
var victorious = false
var gameComplete = false
var inGame = false

func _ready():
	gui.add_child(titleClass.instance())
	
func startGame():
	inGame = true
	currentLevel = levelClasses[currentLevelIndex].instance()
	add_child(currentLevel)
	createInGameUI()

func _process(_delta):
	if inGame and not gameComplete:
		if Input.is_action_just_released("restart_level"):
			restartLevel()
			
		if not victorious:
			var satisfiesVictoryCondition = true
			for node in currentLevel.get_children():
				if node is StaticBody2D and node.isSplash():
					if not node.correctColour:
						satisfiesVictoryCondition = false
			if satisfiesVictoryCondition:
				victory()
		
func victory():
	victorious = true
	if currentLevelIndex < len(levelClasses) - 1:
		victorySoundEffect.play()
		gui.add_child(victoryMenuClass.instance())
	else:
		finalVictorySoundEffect.play()
		advanceLevel()
		
func advanceLevel():
	if not gameComplete:
		remove_child(currentLevel)
		currentLevel.queue_free()
		gui.remove_child(inGameUI)
		inGameUI.queue_free()
		currentLevelIndex += 1
		if currentLevelIndex >= len(levelClasses):
			completeGame()
		else:
			victorious = false
			currentLevel = levelClasses[currentLevelIndex].instance()
			add_child(currentLevel)
			
			createInGameUI()
	
func restartLevel():
	if not gameComplete:
		victorious = false
		remove_child(currentLevel)
		currentLevel.queue_free()
		currentLevel = levelClasses[currentLevelIndex].instance()
		add_child(currentLevel)
		
		gui.remove_child(inGameUI)
		inGameUI.queue_free()
		createInGameUI()
		
func restartGame():
	victorious = false
	gameComplete = false
	currentLevelIndex = 0
	startGame()
		
func completeGame():
	victorious = true
	gameComplete = true
	gui.add_child(finalVictoryMenuClass.instance())
	
func getCharacter():
	return currentLevel.get_node("Character")
	
func createInGameUI():
	inGameUI = inGameUIClass.instance()
	inGameUI.setAvailableBuckets(currentLevel.availableBucketCount)
	gui.add_child(inGameUI)
	
func addBucket(paintColour):
	inGameUI.addBucket(paintColour)
