extends CanvasLayer

signal finished
signal pause
signal resume
signal load_next_stage

func _ready():
	if(Manager.connect("S_NEXT_STAGE", self, "nextStage")):
		OS.alert("Error connecting S_NEXT_STAGE in Stage", "Signaling error")

func nextStage():
	$Control/VBoxContainer/Stage.text = "Stage " + str(Manager.stage)
	pauseBattle()
	show()
	emit_signal("load_next_stage")

func show():
	$AnimationPlayer.play("Show")

func hide():
	$AnimationPlayer.play("Hide")

func pauseBattle():
	emit_signal("pause")

func resumeBattle():
	emit_signal("resume")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Hide":
		emit_signal("finished")
