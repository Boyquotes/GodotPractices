extends CanvasLayer

func _ready():
	$Control/VBoxContainer/HBoxContainer/Aliens/AlienNumber.text = str(Manager.aliens_on_scene)
	if(Manager.connect("S_ALIEN_CHANGED", self, "on_alien_changed")):
		OS.alert("Error connecting ALIEN_CHANGED in HUD", "Signaling error")
	if(Manager.connect("S_NEXT_STAGE", self, "on_stage_changed")):
		OS.alert("Error connecting STAGE_CHANGED in HUD", "Signaling error")	



func hide(inmediate : bool  = false):
	if(inmediate):
		$Control.visible = false
		$Control.self_modulate.a = 0
	else:
		$AnimationPlayer.play("Hide")

func show(inmediate : bool  = false):
	if(inmediate):
		$Control.visible = true
		$Control.self_modulate.a = 1
	else:
		$AnimationPlayer.play("Show")

func on_alien_changed():
	$Control/VBoxContainer/HBoxContainer/Aliens/AlienNumber.text = str(Manager.aliens_on_scene)
func on_stage_changed():
	$Control/VBoxContainer/HBoxContainer/Stage/StageNumber.text = str(Manager.stage)