extends Node2D
signal s_wave_end
signal s_stage_end

var enemies = Constants.MAP_WAVES[Constants.Map.M1]
var wave = null

func _ready():
	loadEnemies(Constants.Map.M1)

func loadEnemies(map) -> void:
	enemies = Constants.MAP_WAVES[map]
	Manager.wave = 1
	Manager.total_waves = enemies["Num Waves"]
	Manager.enemies_remaining = loadNumberOfEnemies()
	print(Manager.enemies_remaining)
	loadWave()

func loadWave():
	wave = enemies["Waves"][Manager.wave-1]
	Manager.enemies_remaining_on_wave = loadNumberOfEnemiesOnWave(Manager.wave-1)
func loadNumberOfEnemies() -> int:
	var num_enemies = 0
	for wave in range(enemies["Waves"].size()):
		num_enemies += loadNumberOfEnemiesOnWave(wave)
	return num_enemies

func loadNumberOfEnemiesOnWave(wave_num : int) -> int:
	var num_enemies = 0
	var wave  = enemies["Waves"][wave_num]
	for wave_round in wave["A"]:
		num_enemies += wave_round.values()[0]
	for wave_round in wave["B"]:
		num_enemies += wave_round.values()[0]
	for wave_round in wave["C"]:
		num_enemies += wave_round.values()[0]
	for wave_round in wave["D"]:
		num_enemies += wave_round.values()[0]
	return num_enemies
	
func _on_SpawnTimer_timeout():
	if Manager.enemies_remaining == 0:
		if Manager.total_waves == Manager.wave:
			emit_signal("s_stage_end")
			return
		emit_signal("s_wave_end")
		return
	var enemyType = wave["A"][0].keys()[0]
	if(wave["A"][Manager.wave_round][enemyType]) <= 0:
		pass
	var follow = PathFollow2D.new()
	follow.add_child(Constants.enemyFactory[enemyType].instance())
	follow.set_name("FollowA")
	$PathA.add_child(follow)
	follow.rotation = 0
	wave["A"][0][enemyType] -= 1
	print(wave["A"])