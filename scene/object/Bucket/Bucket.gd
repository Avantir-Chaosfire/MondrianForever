extends Area2D

func _process(delta):
	for body in get_overlapping_bodies():
		body.collectBucket()
		get_parent().remove_child(self)
		queue_free()
		break
	
func isPaintArea():
	return false
