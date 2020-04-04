extends Control

onready var world = get_node("../..")

func _on_NextPaintingButton_pressed():
	world.advanceLevel()
	queue_free()
