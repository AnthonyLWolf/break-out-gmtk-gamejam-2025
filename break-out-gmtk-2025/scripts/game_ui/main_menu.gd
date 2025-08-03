extends Control

func _ready() -> void:
	GameManager.gsm.change_state(GameManager.GameStates.MENUS)
	#AudioManager.play_music(AudioManager.MAIN_MENU)
	

func _on_start_game_button_pressed() -> void:
	SceneController.unload_current_scene()
	SceneController.load_level(0) # Loads first level using the Scene Controller
	


func _on_quit_game_pressed() -> void:
	get_tree().quit()
