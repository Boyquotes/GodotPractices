extends Node2D

const WALK_SPEED = 250
const MAX_SPEED_AND_IMPULSE = 400

var linear_vel : Vector2 = Vector2()

func _ready():
	add_to_group(Constants.G_LASER)
	add_to_group(Constants.G_AIRSHIP_LASER)
	linear_vel.y = -1

func _physics_process(delta):
	move(delta)
	
func move(delta : float) -> void:
	linear_vel *= WALK_SPEED

	#We clamp the linear velocity
	linear_vel = linear_vel.clamped(MAX_SPEED_AND_IMPULSE)
	$body.move_and_collide(linear_vel*delta)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()