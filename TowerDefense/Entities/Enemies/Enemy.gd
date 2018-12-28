extends Node2D

var HP : float = 50.0
var maxHP : float = 50.0
var fisDef : float = 1.0 setget fisDefSet
var magDef : float = 1.0 setget magDefSet
var speed = 50
var points : float = 5
var follow : PathFollow2D = null
var turnToAppear : int = 5
var enemyName  : String = "Enemy"

func _ready():
	add_to_group(Constants.G_ENEMY)
	add_to_group(Constants.G_ENEMY_ASLEEP)
	follow = get_parent()
	visible = false
	$Area2D/Name.text = enemyName
	$Area2D/HPBar.value = 100.0

func setTurn(turn : int) -> void:
	turnToAppear = turn+1

func wakeUp() -> void:
	turnToAppear -= 1
	if turnToAppear <= 0:
		turnToAppear = 0
		remove_from_group(Constants.G_ENEMY_ASLEEP)
		visible = true

func _physics_process(delta):
	if turnToAppear != 0:
		return #we are asleep
	follow.offset += delta*speed

func receiveDamage(fis : float = 0, mag : float = 0) -> void:
	HP -= fis*fisDef + mag*magDef
	$Area2D/HPBar.value = HP / maxHP * 100.0
	if HP <= 0:
		HP = 0
		die()

func setAttrs(_fisDef : float, _magDef : float, _HP : float, _points : int) -> void:
	maxHP = _HP
	HP = _HP
	fisDefSet(_fisDef)
	magDefSet(_magDef)
	points = _points
	
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

func getGlobalPosition() -> float:
	return $Area2D.global_position

func die() -> void:
	Manager.enemies_remaining_on_wave -= 1
	Manager.enemies_remaining -= 1
	queue_free()

func _on_Area2D_body_entered(body):
	var proyectile = body.get_parent()
	if !proyectile.is_in_group(Constants.G_PROYECTILE):
		return
	var fisDmg = proyectile.getFisDmg()
	var magDmg = proyectile.getMagDmg()
	receiveDamage(fisDmg, magDmg)
	proyectile.queue_free()
