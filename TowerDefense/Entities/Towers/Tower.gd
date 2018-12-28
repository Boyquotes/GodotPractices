extends Node2D

var proyectileFactory = preload("res://Entities/Proyectiles/Proyectile.tscn")

const ALPHA : float = 0.2

var radius : float = 50.0
var areaColour = Color(0.8, 0.2, 0.2, ALPHA)
var cooldown : bool = false

var towerName : String = "Tower"
var fisDmg : float = 5.0
var magDmg : float = 5.0

func _on_Clicking_input_event(_viewport, event, _shape_idx):
	if event.is_pressed():
		print("Clicked")
		
func _ready():
	add_to_group(Constants.G_TOWER)
	radius = $Area2D/CollisionShape2D.shape.radius
	$Area2D.set_process_input(true)
	
func _draw():
    draw_circle($Area2D.position, radius, areaColour)
	
func _physics_process(_delta):
	update()
	var enemies = $Area2D.get_overlapping_areas()
	if enemies != null and !enemies.empty() and !cooldown:
		shoot()

func shoot() -> void:
	var proyectile = proyectileFactory.instance()
	get_tree().get_root().add_child(proyectile)
	proyectile.setGlobalPosition($Area2D/SourceOfSpell.global_position)
	proyectile.setAttr(fisDmg, magDmg)
	$Cooldown.start()
	cooldown = true
	$AnimationPlayer.play("Attacking")

func _on_Cooldown_timeout():
	cooldown = false

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Attacking":
		$AnimationPlayer.play("Idle")

func getName():
	return towerName