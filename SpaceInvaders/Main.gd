extends Node2D

const GAME_FACTORY = preload("res://Entities/BattleMap.tscn")
const START_SCREEN_FACTORY = preload("res://Entities/Menu/StartMenu.tscn")

enum STATE {
	START_SCREEN,
	LOADING_GAME,
	GAME_STARTED
}

var currentState = STATE.START_SCREEN

# Called when the node enters the scene tree for the first time.
func _ready():
	$HUD.hide(true)
	
	$TransitionLayer/Transitions.play("Initialise")
	if(Manager.connect("S_START_GAME", self, "start_game")):
		OS.alert("Error connecting START_GAME in Main", "Signaling error")
	var menu = START_SCREEN_FACTORY.instance()
	self.add_child(menu)
	menu.set_name("Menu")
	
func start_game() -> void:
	$Menu/AnimationPlayer.play("Start")

func load_game() -> void:
	var menu = get_tree().get_root().find_node("Menu", true, false)
	remove_child(menu)
	menu.call_deferred("queue_free")
	
	var battle_scene = GAME_FACTORY.instance()
	self.add_child(battle_scene)
	currentState = STATE.LOADING_GAME
	$TransitionLayer/Transitions.play("FadeToNormal")
	$HUD.show()
	
func _on_Transitions_animation_finished(anim_name):
	match(anim_name):
		"FadeToNormal":
			match(currentState):
				STATE.LOADING_GAME:
					$Stage.show()
		"FadeToBlack":
			match(currentState):
				STATE.START_SCREEN:
					load_game()
		"Initialise":
			pass
		_:
			OS.alert("Error in animation finished in Main", "Animation error")

func _on_Stage_finished():
	currentState = STATE.GAME_STARTED
	get_tree().call_group(Constants.G_ALIEN, "unfreeze")
	get_tree().call_group(Constants.G_AIRSHIP, "unfreeze")