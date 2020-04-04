extends Node2D

var levelClasses = [
	preload("res://scene/level/1/Level1.tscn")
]

var currentLevel = null

func _ready():
	currentLevel = levelClasses[0].instance()
	add_child(currentLevel)
