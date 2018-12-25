#warnings-disable
extends Node

var enemyDefaultFactory = preload("res://Entities/Enemies/Enemy.tscn")

const G_TOWER = "Tower"
const G_PROYECTILE = "Proyectile"
const G_ENEMY = "Enemy"

enum Map {
	M1,
	M2,
	M3
}

enum Enemy {
	Default
}

var enemyFactory = {
	Enemy.Default : enemyDefaultFactory
}

const MAP_WAVES = {
	Map.M1 : {
		"Num Waves" : 1,
		"Waves" : [
			{
				"A" : [
					{Enemy.Default: 1}
				],
				"B" : {},
				"C" : {},
				"D" : {}
			},
		]
	}
}