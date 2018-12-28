extends Control

signal fade_out
signal fade_in

func _on_AnimationPlayer_animation_finished(anim_name):
	match(anim_name):
		"FadeOut":
			emit_signal("fade_out")
		"FadeIn":
			emit_signal("fade_in")

func fadeIn():
	$AnimationPlayer.play("FadeIn")
	
func fadeOut():
	$AnimationPlayer.play("FadeOut")