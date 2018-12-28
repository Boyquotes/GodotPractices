extends Node2D


func _on_Area2D_area_shape_entered(_area_id, area, _area_shape, _self_shape):
	var enemy = area.get_parent()
	Manager.points -= enemy.getPoints()
	enemy.die(true) # we lose points if they go away
