extends Node2D

var HP : float = 5.0
var fisDef : float = 0.0 setget fisDefSet
var magDef : float = 0.0 setget magDefSet
var points : float = 5

func receiveDamage(fis : float = 0, mag : float = 0) -> void:
	HP -= fis*fisDef + mag*magDef
	if HP <= 0:
		HP = 0
		die()

func fisDefSet(def : float) -> void:
	if def > 0:
		OS.assert("Defense can't be more than 1.")
	fisDef = def

func magDefSet(def : float) -> void:
	if def > 0:
		OS.assert("Defense can't be more than 1.")
	magDef = def

func getPoints() -> float:
	return points

func die() -> void:
	queue_free()