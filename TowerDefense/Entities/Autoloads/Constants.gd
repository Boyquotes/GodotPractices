#warnings-disable
extends Node

var enemyDefaultFactory = preload("res://Entities/Enemies/Enemy.tscn")
var poroFactory = preload("res://Entities/Enemies/Poro/Poro.tscn")

const G_TOWER = "Tower"
const G_PROYECTILE = "Proyectile"
const G_ENEMY = "Enemy"
const G_ENEMY_ASLEEP = "EnemyAsleep"

enum Map {
	M1,
	M2,
	M3
}

enum Enemy {
	Default,
	Poro
}

var enemyFactory = {
	Enemy.Default : enemyDefaultFactory,
	Enemy.Poro : poroFactory
}

const MAP_WAVES = {
	Map.M1 : {
		"Num Waves" : 1,
		"Waves" : [
			{
				"A" : [
					{Enemy.Default: 2}
				],
				"B" : {},
				"C" : {},
				"D" : {}
			}
		]
	}
}