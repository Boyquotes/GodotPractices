extends CanvasLayer

signal finished

func _ready():
	if(Manager.connect("S_NEXT_STAGE", self, "nextStage")):
		OS.alert("Error connecting S_NEXT_STAGE in Stage", "Signaling error")

func nextStage():
	$Control/VBoxContainer/Stage.text = "Stage " + str(Manager.stage)
	show()

func show():
	$AnimationPlayer.play("Show")

func hide():
	$AnimationPlayer.play("Hide")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Hide":
		emit_signal("finished")
