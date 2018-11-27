extends Node2D

const LATERAL_SHIFT : int = 20
const VERTICAL_SHIFT : int = 50

var frozen : bool = true

func _ready():
	add_to_group(Constants.G_ALIEN)
	Manager.aliens_on_scene += 1

func moveRight() -> void:
	move(Vector2(1,0), true)

func moveLeft() -> void:
	move(Vector2(-1,0), true)

func moveDown() -> void:
	move(Vector2(0, 1), false)

func move(direction : Vector2, lateral : bool = true) -> void:
	if frozen:
		return
	if lateral:
		$body.global_position += direction*LATERAL_SHIFT
	else:
		$body.global_position += direction*VERTICAL_SHIFT

func unfreeze():
	frozen = false

func freeze():
	frozen = true

func setGlobalPosition(position : Vector2) -> void:
	$body.global_position = position

func _on_VisibilityNotifier_screen_exited():
	Manager.exited($body.global_position.x > 0)


func _on_body_body_entered(body):
	$body.collision_mask = 0 #Once we collide we don't want to get more collisions
	var collider = body.get_parent()
	#Before we free, we dissable the visibility notifiers to not emit any signal
	$body/LeftVisibilityNotifier.disconnect("screen_exited", self, "_on_VisibilityNotifier_screen_exited")
	$body/RightVisibilityNotifier.disconnect("screen_exited", self, "_on_VisibilityNotifier_screen_exited")
	Manager.aliens_on_scene -= 1
	collider.queue_free()
	queue_free()
