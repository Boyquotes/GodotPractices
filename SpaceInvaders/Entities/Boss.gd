extends Node2D

#const LASER_FACTORY = preload("res://Entities/")

#signal boss_defeated

const FLOOR_NORMAL = Vector2(0, 1)
const SLOPE_SLIDE_STOP = 25.0
const WALK_SPEED = 250
const MAX_SPEED_AND_IMPULSE = 400
const Y_POS = -OS.window_position.y - 32

var linear_vel : Vector2 = Vector2()

var hp : int = 50*Manager.stage
#var defeated : bool = false setget onDefeated
var frozen : bool = false
var direction : Vector2 = Vector2(1,0)

func _ready():
	add_to_group(Constants.G_ALIEN)
	Manager.aliens_on_scene += 1

func _physics_process(delta):
	if frozen:
		return
	move(delta)
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
	pass

func process_collisions():
	var collider = null
	for i in range($body.get_slide_count()):
		collider = $body.get_slide_collision(i).get_collider().get_parent()
		if(collider.is_in_group("Enemy")):
			pass

func unfreeze():
	frozen = false

func freeze():
	frozen = true

	
func hurt(val):
	hp -= val
	if hp <= 0:
		hp = 0
		#defeated = true

#func onDefeated(true):
	#Run Animation
#	emit_defeated()
	

#func emit_defeated():
	#emit_signal(self.boss_defeated)

func setGlobalPosition(pos : Vector2) -> void:
	$body.global_position = pos
