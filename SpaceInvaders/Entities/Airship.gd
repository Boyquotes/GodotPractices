extends Node2D

const LASER_FACTORY = preload("res://Entities/AirshipLaser.tscn")

const FLOOR_NORMAL = Vector2(0, 1)
const SLOPE_SLIDE_STOP = 25.0
const WALK_SPEED = 250
const LERP = 0.1
const MAX_SPEED_AND_IMPULSE = 400

var linear_vel : Vector2 = Vector2()
var target_vel : Vector2 = Vector2()

var shootCooldown : bool = false
var cleanCooldown : bool = false

var frozen : bool = true

func _ready():
	add_to_group(Constants.G_AIRSHIP)
	$AnimationPlayer.play("Shine")
	
func _physics_process(delta):
	if frozen:
		return
	read_input()
	process_skills()
	move(delta)
	process_collisions()
	
func read_input():
	target_vel.x = 0
	target_vel.y = 0
	if Input.is_action_pressed("ui_left"):
		target_vel.x += -1
	elif Input.is_action_pressed("ui_right"):
		target_vel.x += 1
	if Input.is_action_pressed("ui_shoot") && !shootCooldown:
		shootCooldown = true
		var laser = LASER_FACTORY.instance()
		add_child(laser)
		laser.global_position = $body.global_position + Vector2(0, -48)
		$ShootCooldown.start()
	target_vel = target_vel.normalized()

func process_skills():
	pass

func move(_delta):
	target_vel *= WALK_SPEED

	#linear_vel.x = lerp(linear_vel.x, target_vel.x, LERP)
	#linear_vel.y = lerp(linear_vel.y, target_vel.y, LERP)
	linear_vel = target_vel
	
	#We clamp the linear velocity
	linear_vel = linear_vel.clamped(MAX_SPEED_AND_IMPULSE)
	if($body.global_position.x > OS.window_size.x/2 - 32 && linear_vel.x > 0):
		linear_vel.x = 0
	elif($body.global_position.x < -OS.window_size.x/2 + 32 && linear_vel.x < 0):
		linear_vel.x = 0
	linear_vel = $body.move_and_slide(linear_vel, FLOOR_NORMAL, SLOPE_SLIDE_STOP)

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

func freeze(clean : bool = false):
	frozen = true
	if clean:
		get_tree().call_group(Constants.G_LASER, "queue_free")

func _on_ShootCooldown_timeout():
	shootCooldown = false

func _on_CleanCooldown_timeout():
	cleanCooldown = false