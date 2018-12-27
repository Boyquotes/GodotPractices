#warnings-disable
extends Node

signal enemies_update
signal wave_update

var points : float = 0.0
var wave : int = 0 setget setWave
var total_waves : int = 0
var total_enemies : int = 0
var enemies_remaining : int = 0
var enemies_remaining_on_wave : int = 0 setget setEnemies
var total_enemies_on_wave : int = 0

var towerSelected = null

func setWave(val : int) -> void:
	wave = val
	emit_signal("wave_update")
	
func setEnemies(val : int) -> void:
	enemies_remaining_on_wave = val
	emit_signal("enemies_update")