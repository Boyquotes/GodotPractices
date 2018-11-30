extends Node2D

#const LASER_FACTORY = preload("res://Entities/")

const FLOOR_NORMAL = Vector2(0, 1)
const SLOPE_SLIDE_STOP = 25.0
const WALK_SPEED = 250
const MAX_SPEED_AND_IMPULSE = 400
const Y_POS = -OS.window_position.y + 32

var linear_vel : Vector2 = Vector2()
var maxHP : float = 0.0
var hp : float = 0.0
var defeated : bool = false
var frozen : bool = false
var direction : Vector2 = Vector2(1,0)
var atacking : bool = false
var lastAnimation : String = ""
var minAtackTime : float = 0.0
var maxAtackTime : float = 0.0
var atackingTime : float = 0.0
enum STATE{
	LOADING,
	MOVING,
	ATACKING
}

var state = STATE.LOADING

func _ready():
	maxHP = 50*Manager.stage
	hp = maxHP
	add_to_group(Constants.G_ALIEN)
	Manager.aliens_on_scene += 1
	Manager.bossRequired = false
	
	get_tree().call_group(Constants.G_ALIEN, "freeze")
	get_tree().call_group(Constants.G_AIRSHIP, "freeze", true)
	minAtackTime = 2.0/Manager.stage + 0.5
	maxAtackTime = 1.0/Manager.stage
	atackingTime = Manager.stage/2.0
	
	$Atack.wait_time = randf()/maxAtackTime+minAtackTime
	$Atack.start()

func _physics_process(delta):
	if frozen or defeated:
		return
	match(state):
		STATE.LOADING:
			return
	move(delta)
	animate()
	process_collisions()

func move(_delta):
	linear_vel = direction*WALK_SPEED
	#We clamp the linear velocity
	linear_vel = linear_vel.clamped(MAX_SPEED_AND_IMPULSE)
	if(($body.global_position.x > OS.window_size.x/2 - 32 && linear_vel.x > 0)) or ($body.global_position.x < -OS.window_size.x/2 + 32 && linear_vel.x < 0):
		direction *= -1
	linear_vel = $body.move_and_slide(linear_vel, FLOOR_NORMAL, SLOPE_SLIDE_STOP)
	$body.global_position.y = Y_POS

func animate():
	if !atacking:
		if(lastAnimation != "Idle"):
			$AnimationPlayer.play("Idle")

func process_collisions():
	var collider = null
	for i in range($body.get_slide_count()):
		collider = $body.get_slide_collision(i).get_collider().get_parent()
		if(collider.is_in_group(Constants.G_AIRSHIP_LASER)):
			collider.queue_free()
			hurt(50)

func unfreeze():
	frozen = false

func freeze():
	frozen = true

func hurt(val):
	hp -= val
	if hp <= 0:
		hp = 0
		onDefeated()
	Manager.boss_hp_changed(hp / maxHP * 100)

func onDefeated() -> void:
	defeated = true
	$AnimationPlayer.play("Die")
	
func emitBossDefeated():
	Manager.aliens_on_scene -= 1
	#Manager.bossRequired = false
	#emit_signal("boss_defeated")

func finish_loading_anim():
	get_tree().call_group(Constants.G_ALIEN, "unfreeze")
	get_tree().call_group(Constants.G_AIRSHIP, "unfreeze")
	state = STATE.MOVING

func setGlobalPosition(pos : Vector2) -> void:
	$body.global_position = pos
