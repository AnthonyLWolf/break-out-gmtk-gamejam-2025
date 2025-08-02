extends Control

@onready var options_menu: Control = %OptionsMenu

func _ready() -> void:
	GameManager.gsm.change_state(GameManager.GameStates.MENUS)
	AudioManager.play_music(AudioManager.MAIN_MENU)

func _on_play_pressed() -> void: # press play button to play intro scene
	SceneController.load_scene("res://scenes/levels/game.tscn")

func _on_options_pressed() -> void: # press options button
	options_menu.visible = !options_menu.visible


func _on_exit_pressed() -> void: # press exit button
	get_tree().quit()


func _on_credits_pressed() -> void:
	SceneController.load_scene("res://scenes/ui/credits_menu.tscn")
