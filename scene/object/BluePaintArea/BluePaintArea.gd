extends Node2D

var paintAreaClass = preload("res://scene/object/PaintArea/PaintArea.tscn")

func _process(delta):
	var paintArea = paintAreaClass.instance()
	paintArea.setPaintColour("blue")
	paintArea.position = position
	get_parent().add_child(paintArea)
	queue_free()
