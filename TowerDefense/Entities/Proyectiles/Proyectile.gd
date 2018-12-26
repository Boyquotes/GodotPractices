extends Node2D

var objective : Node2D = null
var speed : float = 350.0

func _ready():
	add_to_group(Constants.G_PROYECTILE)

func setObjective(_objective) -> void:
	objective = _objective

func _physics_process(delta):
	if objective == null:
		queue_free()
	var dir = objective.getGlobalPosition() - $body.global_position
	var vel = dir.normalized() * speed * delta
	var _collision = $body.move_and_collide(vel)

func setGlobalPosition(pos : Vector2):
	$body.global_position = pos
	
func getFisDmg():
	return 0

func getMagDmg():
	return 0
