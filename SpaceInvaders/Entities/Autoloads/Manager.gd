extends Node

signal S_START_GAME
signal S_NEXT_STAGE
signal S_ALIEN_CHANGED
signal S_START_BOSS
signal S_BOSS_CHANGED

var startGame : bool = false setget start_game_emitter
var stage : int = 1 setget stage_emitter
var movingTo = Constants.DIRECTION.RIGHT
var bossRequired : bool = false
var bossHPPercent : float = 0.0 setget boss_hp_changed

var aliens_on_scene : int = 0 setget on_aliens_change

func resetBoss() -> void:
	bossRequired = false

func setBoss() -> void:
	bossRequired = true

func isBossRequired() -> bool:
	return bossRequired

func next_stage() -> void:
	stage += 1

func start_game_emitter(val : bool) -> void:
	startGame = val
	if val:
		emit_signal("S_START_GAME")

func stage_emitter(val : int) -> void:
	stage = val
	movingTo =Constants.DIRECTION.RIGHT
	emit_signal("S_NEXT_STAGE")
	
func on_aliens_change(val : int) -> void:
	aliens_on_scene = val
	if val == 0:
		if !bossRequired:
			Manager.stage += 1
		else:
			emit_signal("S_START_BOSS")
	emit_signal("S_ALIEN_CHANGED")

func moveAliens() -> void:
	match(movingTo):
		Constants.DIRECTION.RIGHT:
			get_tree().call_group(Constants.G_ALIEN, "moveRight")
		Constants.DIRECTION.LEFT:
			get_tree().call_group(Constants.G_ALIEN, "moveLeft")
		Constants.DIRECTION.BOTTOM:
			get_tree().call_group(Constants.G_ALIEN, "moveBottom")
		_:
			print("ERROR IN MOVEALIENS, IN CONSTANTS")

func exited(right : bool) -> void:
	if(right):
		if movingTo == Constants.DIRECTION.RIGHT:
			get_tree().call_group(Constants.G_ALIEN, "moveDown")
			movingTo = Constants.DIRECTION.LEFT
	else:
		if movingTo == Constants.DIRECTION.LEFT:
			get_tree().call_group(Constants.G_ALIEN, "moveDown")
			movingTo = Constants.DIRECTION.RIGHT

func boss_hp_changed(val : float) -> void:
	bossHPPercent = val
	emit_signal("S_BOSS_CHANGED")