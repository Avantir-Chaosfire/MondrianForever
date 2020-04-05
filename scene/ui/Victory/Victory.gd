extends Control

onready var world = get_node("../..")

func _on_NextPaintingButton_pressed():
	advanceLevel()

func _process(_delta):
	if Input.is_action_just_released("next_level"):
		advanceLevel()
		
func advanceLevel():
	world.advanceLevel()
	world.gui.remove_child(self)
	queue_free()
