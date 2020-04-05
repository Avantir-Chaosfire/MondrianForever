extends Area2D

func _process(_delta):
	for body in get_overlapping_bodies():
		body.collectBucket("blue")
		get_parent().remove_child(self)
		queue_free()
		break
	
func isPaintArea():
	return false
