extends Node2D

var alienFactory = preload("res://Entities/Alien.tscn")
var bossFactory = preload("res://Entities/Boss.tscn")

const ALIEN_H_DIST = 32
const ALIEN_V_DIST = 32

const STARS_SPEED = 100

func _ready():
	add_to_group(Constants.G_BATTLE_SCENE)
	loadStage()
	$AlienMove.start()
	if(Manager.connect("S_START_BOSS", self, "loadBoss")):
		OS.alert("Error connecting START_BOSS in BattleMap", "Signaling error")
func _process(delta):
	$ParallaxBackground/Stars.motion_offset.y += STARS_SPEED*delta

func loadStage():
	if(Manager.stage > Constants.NUM_STAGES-1):
		OS.alert("Level is out of range in BattleMap", "Signaling error")
	var stage = Constants.STAGES[Manager.stage]
	#Let's get sure there is no bullets on the scene
	get_tree().call_group(Constants.G_LASER, "queue_free")
	
	createAliens(stage["Cols"], stage["Aliens"])
	if(stage["Boss"]):
		Manager.bossRequired = true

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

func loadBoss():
	var boss = bossFactory.instance()
	$Enemies.add_child(boss)
	boss.setGlobalPosition(Vector2(0,0))

func _on_AlienMove_timeout():
	Manager.moveAliens()