extends StaticBody2D

var correctColour = false

func isSplash():
	return true

func getPaintColour():
	return "red"
	
func nowCorrectColour():
	correctColour = true
	z_index = -3
	
func nowIncorrectColour():
	correctColour = false
	z_index = -1
