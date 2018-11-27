extends Node

signal S_START_GAME
signal S_NEXT_STAGE
signal S_ALIEN_CHANGED

var startGame : bool = false setget start_game_emitter
var stage : int = 1 setget stage_emitter
var movingTo = Constants.DIRECTION.RIGHT

var level : int = 0

var aliens_on_scene : int = 0 setget on_aliens_change

func next_level():
	level += 1

func start_game_emitter(val : bool) -> void:
	startGame = val
	if val:
		emit_signal("S_START_GAME")

func stage_emitter(val : int) -> void:
	stage = val
	emit_signal("S_NEXT_STAGE")
	
func on_aliens_change(val : int) -> void:
	aliens_on_scene = val
	if val == 0:
		Manager.stage += 1
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