extends Control

func _ready():
	$Levels/Panel/HBoxContainer/Start.disabled = true
	for i in Constants.MAP_WAVES.keys().size():
		$Levels/ItemList.add_item("Level " + str(i))

func _on_ItemList_item_selected(index):
	$Levels/Panel/HBoxContainer/Level.text =  $Levels/ItemList.get_item_text(index)
	$Levels/Panel/HBoxContainer/Start.disabled = false

func _on_BackToMain_pressed():
	$MainMenu.visible = true
	$Levels.visible = false

func _on_ExitButton_pressed():
	get_tree().quit()

func _on_StartButton_pressed():
	$MainMenu.visible = false
	$Levels.visible = true
