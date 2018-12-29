extends Control
const MAIN_SCENE = "res://Entities/Main.tscn"
const TITLE_TRANSITION_FACTORY = preload("res://Entities/Interface/TitleTransition.tscn")

var levels_list

func _ready():
	levels_list = $Levels/ItemList
	$Levels/Panel/HBoxContainer/Start.disabled = true
	for i in Constants.MAP_WAVES.keys().size():
		levels_list.add_item("Level " + str(i))
		levels_list.set_item_disabled(i, i > Manager.levels_passed)
		levels_list.set_item_selectable(i, i <= Manager.levels_passed)

func _on_ItemList_item_selected(index):
	if levels_list.is_item_selectable(index):
		$Levels/Panel/HBoxContainer/Level.text =  levels_list.get_item_text(index)
		$Levels/Panel/HBoxContainer/Start.disabled = false

func _on_BackToMain_pressed():
	$MainMenu.visible = true
	$Levels.visible = false

func _on_ExitButton_pressed():
	get_tree().quit()

func _on_StartButton_pressed():
	$MainMenu.visible = false
	$Levels.visible = true


func _on_Start_pressed():
	var transition = TITLE_TRANSITION_FACTORY.instance()
	get_tree().get_root().add_child(transition)
	transition.fadeOut()
	yield(transition, "fade_out")
	if(get_tree().change_scene(MAIN_SCENE)):
		OS.alert("Error when changing scene from Starting Screen to a stage")
