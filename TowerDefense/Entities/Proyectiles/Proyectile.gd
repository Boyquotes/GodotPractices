extends Node2D

var objective : WeakRef = null
var speed : float = 100.0

func _ready():
	add_to_group(Constants.G_PROYECTILE)

func setObjective() -> bool:
	var enemies = get_tree().get_nodes_in_group(Constants.G_ENEMY)
	if enemies.empty():
		queue_free()
		return true
	objective = weakref(enemies[0])
	var my_pos = $body.global_position
	for enemy in enemies:
		if my_pos.distance_to(enemy.getGlobalPosition()) < my_pos.distance_to(objective.get_ref().getGlobalPosition()):
			objective = weakref(enemy)
	return false
func _physics_process(delta):
	if objective == null or !objective.get_ref():
		var end = setObjective()
		if end:
			return
	var dir = objective.get_ref().getGlobalPosition() - $body.global_position
	var vel = dir.normalized() * speed * delta
	var _collision = $body.move_and_collide(vel)

func setGlobalPosition(pos : Vector2):
	$body.global_position = pos
	
func getFisDmg():
	return 0

func getMagDmg():
	return 0
