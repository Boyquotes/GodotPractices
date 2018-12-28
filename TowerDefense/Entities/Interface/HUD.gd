extends Control

var enemies : Label

func _ready():
	if(Manager.connect("enemies_update", self, "_on_enemiesUpdate")):
		OS.alert("Error when connecting manager to HUD")
	enemies = $PanelContainer/HBoxContainer/Enemies

func _on_enemiesUpdate():
	enemies.text = str(Manager.enemies_remaining_on_wave) + "/" + str(Manager.total_enemies_on_wave)

func _on_TextureButton_pressed():
	print("Level 1 pressed")
