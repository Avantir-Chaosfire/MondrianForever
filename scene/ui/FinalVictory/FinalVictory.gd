extends Control

onready var world = get_node("../..")

func _process(_delta):
	if Input.is_action_just_released("restart_level"):
		restartGame()

func _on_RestartButton_pressed():
	restartGame()
	
func restartGame():
	world.restartGame()
	get_parent().remove_child(self)
	queue_free()
