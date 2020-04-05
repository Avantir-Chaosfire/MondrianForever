extends Control

onready var world = get_node("../..")

func _on_RestartButton_pressed():
	world.restartGame()
	get_parent().remove_child(self)
	queue_free()
