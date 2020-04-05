extends Control

onready var world = get_node("../..")

func _on_StartGameButton_pressed():
	world.startGame()
	get_parent().remove_child(self)
	queue_free()
