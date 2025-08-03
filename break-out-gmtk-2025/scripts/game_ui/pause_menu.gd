extends Control


func _on_unpause_button_pressed() -> void:
	GameManager.gsm.change_state(GameManager.gsm.previous_state)
	hide()


func _on_quit_button_pressed() -> void:
	SceneController.load_scene("res://scenes/Menus/game_over.tscn")
