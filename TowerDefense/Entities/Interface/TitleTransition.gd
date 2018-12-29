extends Control

signal fade_out
signal fade_in
signal fade_out_title
signal fade_in_title
signal title_finished

func _ready():
	$CenterContainer/Title.text = ""

func setTitleTransparent(transparent = true):
	if transparent:
		$CenterContainer/Title.add_color_override("font_color", Color(0,0,0,0))
	else:
		$CenterContainer/Title.add_color_override("font_color", Color(0,0,0,255))

func setBackground(black = true):
	$Background.color.a = float(black)

func setTitle(title : String):
	$CenterContainer/Title.text = title
	
func fadeInTitle() -> void:
	$TitleFade.play("FadeIn")
	$CenterContainer/Title.visible = true
func fadeOutTitle() -> void:
	$TitleFade.play("FadeOut")

func showTitle(title : String) -> void:
	setTitle(title)
	fadeInTitle()
	yield(self,"fade_in_title")
	fadeOutTitle()
	yield(self,"fade_out_title")
	emit_signal("title_finished")
	setTitle("")
	
func fadeInBackground() -> void:
	$BackgroundFade.play("FadeIn")
	$Background.visible = true

func fadeOutBackground() -> void:
	$BackgroundFade.play("FadeOut")

func _on_TitleFade_animation_finished(anim_name):
	match(anim_name):
		"FadeOut":
			emit_signal("fade_out_title")
			$CenterContainer/Title.visible = false
		"FadeIn":
			emit_signal("fade_in_title")

func _on_BackgroundFade_animation_finished(anim_name):
	match(anim_name):
		"FadeOut":
			emit_signal("fade_out")
			$Background.visible = false
		"FadeIn":
			emit_signal("fade_in")