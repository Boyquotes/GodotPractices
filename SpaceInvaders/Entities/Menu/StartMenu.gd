extends Node2D

var STARS_SPEED : float = 800.0
var STARS_ACCELERATION : float = 50.0

var accelerateStars : bool = false
var bufferedAcceleration : float = 0.0

func _process(delta):
	if accelerateStars:
		bufferedAcceleration += STARS_ACCELERATION
	$ParallaxBackground/Stars.motion_offset.y += (STARS_SPEED+bufferedAcceleration) * delta

func accelerate_stars():
	accelerateStars = true
	
func _on_StartButton_button_down():
	$CanvasLayer/Control/VBoxContainer/StartButton.disabled = true
	$CanvasLayer/Control/VBoxContainer/StartButton.visible = false
	Manager.startGame = true