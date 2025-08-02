extends Control

func _on_resume_pressed() -> void:
	GameManager.gsm.change_state(GameManager.gsm.previous_state)
	hide()

func _on_menu_pressed() -> void:
	GameManager.gsm.change_state(GameManager.GameStates.NORMAL)
	SceneController.load_scene("res://main.tscn")
	hide()

# Quits game
func _on_quit_pressed() -> void:
	get_tree().quit()
