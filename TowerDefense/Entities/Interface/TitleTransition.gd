extends Control

signal fade_out
signal fade_in
signal fade_out_title
signal fade_in_title

func _ready():
	$CenterContainer/Title.text = ""

func setTitle(title : String):
	$CenterContainer/Title.text = title
	
func fadeInTile() -> void:
	$TitleFade.play("FadeIn")
	
func fadeOutTile() -> void:
	$TitleFade.play("FadeOut")

func fadeInBackground() -> void:
	$BackgroundFade.play("FadeIn")

func fadeOutBackground() -> void:
	$BackgroundFade.play("FadeOut")

func _on_TitleFade_animation_finished(anim_name):
	match(anim_name):
		"FadeOut":
			emit_signal("fade_out_title")
		"FadeIn":
			emit_signal("fade_in_title")

func _on_BackgroundFade_animation_finished(anim_name):
	match(anim_name):
		"FadeOut":
			emit_signal("fade_out")
		"FadeIn":
			emit_signal("fade_in")