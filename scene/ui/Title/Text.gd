extends TextureRect

onready var fadeInTimer = get_node("FadeIn")
onready var titleSoundEffect = get_node("TitleSoundEffect")
onready var startGameButton = get_node("../StartGameButton")

const preFadeInTime = 0
const soundEffectDuration = 5.4

var playedTitleSound = false

func _ready():
	fadeInTimer.start(soundEffectDuration + preFadeInTime)

func _process(_delta):
	var alpha = pow(1 - (fadeInTimer.time_left / (fadeInTimer.wait_time - preFadeInTime)), 2)
	if alpha > 0.03 and not playedTitleSound:
		titleSoundEffect.play()
		playedTitleSound = true
	modulate = Color(1, 1, 1, alpha)
	if fadeInTimer.time_left == 0:
		startGameButton.visible = true
