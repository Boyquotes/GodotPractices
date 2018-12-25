extends Node2D

const ALPHA = 0.2

var radius = 50
var areaColour = Color(0.8, 0.2, 0.2, ALPHA)
func _ready():
	add_to_group(Constants.G_TOWER)
	radius = $Area2D/CollisionShape2D.shape.radius

func _draw():
    draw_circle($Area2D.global_position, radius, areaColour)
	
func _physics_process(_delta):
	update()
	var enemies = $Area2D.get_overlapping_bodies()
	if enemies != null and !enemies.empty():
		print("There are bodies")