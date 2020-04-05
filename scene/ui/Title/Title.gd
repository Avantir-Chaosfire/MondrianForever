extends Control

onready var world = get_node("../..")

func _process(_delta):
	if Input.is_action_just_released("next_level"):
		startGame()

func _on_StartGameButton_pressed():
	startGame()
	
func startGame():
	world.startGame()
	get_parent().remove_child(self)
	queue_free()
