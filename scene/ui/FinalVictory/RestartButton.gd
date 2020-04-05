extends TextureButton

var normalTexture = texture_normal

func _process(_delta):
	if Input.is_action_pressed("restart_level"):
		texture_normal = texture_pressed
	else:
		texture_normal = normalTexture
