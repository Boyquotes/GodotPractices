#warnings-disable
extends Node

signal wave_update
signal enemies_update
signal wave_finished
signal points_update

#Gameplay
var levels_passed = 0
var current_level_map = Constants.Map.M1

#Waves
var points : float = 0.0 setget setPoints
var wave : int = 0 setget setWave
var total_waves : int = 0
var total_enemies : int = 0
var enemies_remaining : int = 0
var enemies_remaining_on_wave : int = 0 setget setEnemies
var total_enemies_on_wave : int = 0

#Tower selection and upgrades
var towerSelected = null setget selectTower

func setWave(val : int) -> void:
	wave = val
	emit_signal("wave_update")
	
func setEnemies(val : int) -> void:
	enemies_remaining_on_wave = val
	emit_signal("enemies_update")
	if enemies_remaining_on_wave == 0:
		emit_signal("wave_finished")

func setPoints(val : float) -> void:
	points = val
	emit_signal("points_update")
	
func selectTower(tower) -> void:
	print("Tower selected")