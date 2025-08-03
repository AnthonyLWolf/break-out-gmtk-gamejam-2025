extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.gsm.change_state(GameManager.GameStates.GAMEOVER)




func _on_restart_button_pressed() -> void:
	SceneController.unload_current_scene()
	SceneController.load_level(SceneController.load_level(SceneController.current_level_index))


func _on_quit_button_pressed() -> void:
	get_tree().quit()
