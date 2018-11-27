extends Node2D

const G_AIRSHIP : String = "Airship"
const G_LASER : String = "Laser"
const G_AIRSHIP_LASER : String = "AirshipLaser"
const G_ALIEN_LASER : String = "AlienLaser"
const G_ALIEN : String = "Alien"

enum DIRECTION{
	TOP,
	BOTTOM,
	RIGHT,
	LEFT
}

const NUM_LEVELS = 6
const LEVELS = {
	0 : {"Cols" : 5, "Aliens": 15, "Boss" : false},
	1 : {"Cols" : 5, "Aliens": 15, "Boss" : false},
	2 : {"Cols" : 5, "Aliens": 15, "Boss" : false},
	3 : {"Cols" : 5, "Aliens": 15, "Boss" : false},
	4 : {"Cols" : 5, "Aliens": 15, "Boss" : false},
	5 : {"Cols" : 5, "Aliens": 15, "Boss" : false},
}