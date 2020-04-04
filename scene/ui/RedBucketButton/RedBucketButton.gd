extends Control

onready var button = get_node("Button")

var hotkey = ""
var normalTexture = null

func _ready():
	normalTexture = button.texture_normal

func _process(_delta):
	if Input.is_action_pressed(hotkey):
		button.texture_normal = button.texture_pressed
	else:
		button.texture_normal = normalTexture
		if Input.is_action_just_released(hotkey):
			useBucket()

func _on_Button_pressed():
	useBucket()

func useBucket():
	get_parent().bucketButtonPressed(self, "red")
