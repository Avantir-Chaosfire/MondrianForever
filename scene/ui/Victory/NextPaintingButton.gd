extends TextureButton

var normalTexture = texture_normal

func _process(delta):
	if Input.is_action_pressed("next_level"):
		texture_normal = texture_pressed
	else:
		texture_normal = normalTexture
