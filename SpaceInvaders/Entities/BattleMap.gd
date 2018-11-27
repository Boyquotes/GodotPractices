extends Node2D

var alienFactory = preload("res://Entities/Alien.tscn")

const ALIEN_H_DIST = 32
const ALIEN_V_DIST = 32

const STARS_SPEED = 100



func _ready():
	createAliens(1,1)
	$AlienMove.start()

func _process(delta):
	$ParallaxBackground/Stars.motion_offset.y += STARS_SPEED*delta

func loadLevel():
	if(Manager.level > Constants.NUM_LEVELS-1):
		OS.alert("Level is out of range in BattleMap", "Signaling error")

func createAliens(col : int, aliens : int) -> void:	
	var alienInstance = null
	var alienIdx : int = 0
	var colIdx : int = 0
	var rowIdx : int = 0
	var yOffset = -OS.window_size.y/2 + 32
	var xOffset = -OS.window_size.x/2 + 32
	while(alienIdx < aliens):
		alienInstance = alienFactory.instance()
		$Enemies.add_child(alienInstance)
		alienInstance.setGlobalPosition(Vector2(colIdx*ALIEN_H_DIST + xOffset, rowIdx*ALIEN_V_DIST + yOffset))
		colIdx += 1
		if colIdx >= col:
			colIdx = 0
			rowIdx += 1
		alienIdx += 1

func _on_AlienMove_timeout():
	Manager.moveAliens()