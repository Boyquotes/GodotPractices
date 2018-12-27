extends Control

func _ready():
	if(Manager.connect("enemies_update", self, "_on_enemiesUpdate")):
		OS.alert("Error when connecting manager to HUD")

func _on_enemiesUpdate():
	$HBoxContainer/Enemies.text = str(Manager.enemies_remaining_on_wave) + "/" + str(Manager.total_enemies_on_wave)