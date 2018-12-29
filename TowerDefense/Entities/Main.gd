extends Node2D
const TRANSITION_FACTORY = preload("res://Entities/Interface/TitleTransition.tscn")

var transition

func _ready():
	var map = Constants.MAPS_FACTORY[Manager.current_level_map].instance()
	add_child(map)
	if(map.connect("wave_finished", self, "_on_waveFinished")):
		OS.alert("Error connecting signal wave finished on MAIN")
	
	var canvas = CanvasLayer.new()
	canvas.layer = 2 # Over the HUD
	add_child(canvas)
	canvas.name = "Transition"
	transition = TRANSITION_FACTORY.instance()
	canvas.add_child(transition)
	transition.setBackground(true) # true = black
	
	transition.fadeOutBackground()
	yield(transition, "fade_out")
	loadMap(map)
	
func loadMap(map) -> void:
	transition.visible = true
	transition.setTitleTransparent(true)
	transition.showTitle("Wave " + str(Manager.wave))
	yield(transition, "title_finished")
	map.loadEnemies(Constants.Map.M1)
	
func _on_waveFinished() -> void:
	print("wave finished on main")