extends Node2D

var proyectileFactory = preload("res://Entities/Proyectiles/Proyectile.tscn")

const ALPHA : float = 0.2

var radius : float = 50.0
var areaColour = Color(0.8, 0.2, 0.2, ALPHA)
var cooldown : bool = false

func _ready():
	add_to_group(Constants.G_TOWER)
	radius = $Area2D/CollisionShape2D.shape.radius

func _draw():
    draw_circle($Area2D.position, radius, areaColour)
	
func _physics_process(_delta):
	update()
	var enemies = $Area2D.get_overlapping_areas()
	if enemies != null and !enemies.empty() and !cooldown:
		shoot(enemies[0].get_parent())

func shoot(enemy : Node2D) -> void:
	var proyectile = proyectileFactory.instance()
	proyectile.setObjective(enemy)
	proyectile.setGlobalPosition($Area2D/SourceOfSpell.global_position)
	get_tree().get_root().add_child(proyectile)
	$Cooldown.start()
	cooldown = true

func _on_Cooldown_timeout():
	cooldown = false
