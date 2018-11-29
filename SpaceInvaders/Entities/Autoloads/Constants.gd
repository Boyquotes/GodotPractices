extends Node2D

const G_AIRSHIP : String = "Airship"
const G_LASER : String = "Laser"
const G_AIRSHIP_LASER : String = "AirshipLaser"
const G_ALIEN_LASER : String = "AlienLaser"
const G_ALIEN : String = "Alien"
const G_BATTLE_SCENE : String = "BattleScene"

enum DIRECTION{
	TOP,
	BOTTOM,
	RIGHT,
	LEFT
}

const NUM_STAGES = 6
const STAGES = {
	1 : {"Cols" : 5, "Aliens": 15, "Boss" : true},
	2 : {"Cols" : 5, "Aliens": 20, "Boss" : false},
	3 : {"Cols" : 7, "Aliens": 35, "Boss" : false},
	4 : {"Cols" : 8, "Aliens": 48, "Boss" : false},
	5 : {"Cols" : 9, "Aliens": 54, "Boss" : false},
	6 : {"Cols" : 10, "Aliens": 100, "Boss" : false},
}