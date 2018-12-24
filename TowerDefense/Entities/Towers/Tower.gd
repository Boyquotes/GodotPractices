extends Node2D

const ALPHA = 0.2

var radius = 50
var areaColour = Color(0.8, 0.2, 0.2, ALPHA)

func _draw():
    draw_circle($Area2D.global_position, radius, areaColour)
	
func _physics_process(_delta):
	radius = $Area2D/CollisionShape2D.shape.radius
	update()