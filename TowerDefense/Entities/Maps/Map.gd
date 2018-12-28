extends Node2D

var enemies = Constants.MAP_WAVES[Constants.Map.M1]
var wave = null

func _ready():
	if(Manager.connect("wave_finished", self, "_on_waveFinished")):
		OS.alert("Error when connecting wave_finished on Map")
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
	var waveA = wave["A"]
	#var waveB = wave["B"][0]
	#var waveC = wave["C"][0]
	#var waveD = wave["D"][0]
	
	for i in waveA.size():
		num_enemies += waveA[i].values()[0]
	if loadToMemory:
		createWaveRound(waveA)
	return num_enemies

func createWaveRound(wave) -> void:
	var turn_offset = 0
	for i in wave.size():
		var enemyType = wave[i].keys()[0]
		var num_enemies = wave[i].values()[0]
		for j in num_enemies:
			var follow = PathFollow2D.new()
			var enemy = Constants.enemyFactory[enemyType].instance()
			follow.add_child(enemy)
			follow.set_name("FollowA")
			$PathA.add_child(follow)
			enemy.setTurn(turn_offset)
			turn_offset += 1

func _on_waveFinished():
	print("Wave finished")

func _on_Spawn():
	get_tree().call_group(Constants.G_ENEMY_ASLEEP, "wakeUp")