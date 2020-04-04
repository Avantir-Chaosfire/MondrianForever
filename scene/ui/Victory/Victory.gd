extends Control

onready var world = get_node("../..")

func _on_NextPaintingButton_pressed():
	world.advanceLevel()
	world.gui.remove_child(self)
	queue_free()
