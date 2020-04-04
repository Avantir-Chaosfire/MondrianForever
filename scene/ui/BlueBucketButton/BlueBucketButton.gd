extends Control

var hotkey = ""

func _process(delta):
	if Input.is_action_just_pressed(hotkey):
		useBucket()

func _on_Button_pressed():
	useBucket()

func useBucket():
	get_parent().bucketButtonPressed(self, "blue")
