extends Node2D

var HP : float = 5.0
var fisDef : float = 0.0 setget fisDefSet
var magDef : float = 0.0 setget magDefSet
var speed = 50
var points : float = 5
var follow : PathFollow2D = null

func _ready():
	add_to_group(Constants.G_ENEMY)
	follow = get_parent()

func _physics_process(delta):
	follow.offset += delta*speed

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