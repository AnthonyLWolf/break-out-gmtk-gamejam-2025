extends Control

@onready var how_to_play_panel: Panel = $CanvasLayer/HowToPlayPanel

func _ready() -> void:
	GameManager.gsm.change_state(GameManager.GameStates.MENUS)
	how_to_play_panel.hide()
	if AudioManager.background_music_player.playing:
		AudioManager.background_music_player.stop()
	if !AudioManager.office_fx_player.playing:
		AudioManager.office_fx_player.play()
	

func _on_start_game_button_pressed() -> void:
	GameManager.coworkers_saved = 0
	SceneController.unload_current_scene()
	SceneController.load_level(0) # Loads first level using the Scene Controller


func _on_how_to_play_button_pressed() -> void:
	how_to_play_panel.show()


func _on_quit_game_pressed() -> void:
	get_tree().quit()


func _on_go_back_button_pressed() -> void:
	how_to_play_panel.hide()
