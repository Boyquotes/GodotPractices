extends Node2D

var enemies = Constants.MAP_WAVES[Constants.Map.M1]
var wave = null

func _ready():
	loadEnemies(Constants.Map.M1)
	var timer = Timer.new()
	timer.one_shot = false
	timer.wait_time = 1.0
	timer.connect("timeout", self, "_on_Spawn")
	add_child(timer)
	timer.start()

func loadEnemies(map) -> void:
	enemies = Constants.MAP_WAVES[map]
	Manager.wave = 0
	Manager.total_waves = enemies["Num Waves"]
	Manager.enemies_remaining = loadNumberOfEnemies()
	loadWave()

func loadWave():
	wave = enemies["Waves"][Manager.wave]
	Manager.total_enemies_on_wave = loadNumberOfEnemiesOnWave(Manager.wave)
	Manager.enemies_remaining_on_wave = Manager.total_enemies_on_wave
	

func loadNumberOfEnemies() -> int:
	var num_enemies = 0
	for wave in range(enemies["Waves"].size()):
		num_enemies += loadNumberOfEnemiesOnWave(wave, false)
	return num_enemies

func loadNumberOfEnemiesOnWave(wave_num : int, loadToMemory : bool = true) -> int:
	var num_enemies = 0
	var wave  = enemies["Waves"][wave_num]
	var turn_offset = 0
	for wave_round in wave["A"]:
		num_enemies += wave_round.values()[0]
		if loadToMemory:
			createWaveRound(wave_round, turn_offset)
		turn_offset += wave_round.values()[0]
	for wave_round in wave["B"]:
		num_enemies += wave_round.values()[0]
		if loadToMemory:
			createWaveRound(wave_round, turn_offset)
		turn_offset += wave_round.values()[0]
	for wave_round in wave["C"]:
		num_enemies += wave_round.values()[0]
		if loadToMemory:
			createWaveRound(wave_round, turn_offset)
		turn_offset += wave_round.values()[0]
	for wave_round in wave["D"]:
		num_enemies += wave_round.values()[0]
		if loadToMemory:
			createWaveRound(wave_round, turn_offset)
		turn_offset += wave_round.values()[0]
	return num_enemies

func createWaveRound(wave_round, _turn_offset : int) -> void:
	var enemyType = Constants.enemyFactory[wave_round.keys()[0]]
	for _enemy in range(wave_round.values()[0]):
		var follow = PathFollow2D.new()
		var enemy = enemyType.instance()
		follow.add_child(enemy)
		follow.set_name("FollowA")
		$PathA.add_child(follow)
		enemy.setTurn(_turn_offset)
		_turn_offset += 1
		
func _on_Spawn():
	get_tree().call_group(Constants.G_ENEMY_ASLEEP, "wakeUp")