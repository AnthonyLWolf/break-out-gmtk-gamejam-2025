extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.gsm.change_state(GameManager.GameStates.LEVELCOMPLETE)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_continue_button_pressed() -> void:
	SceneController.load_next_level()
	GameManager.gsm.change_state(GameManager.GameStates.LOOP)


func _on_quit_button_pressed() -> void:
	SceneController.load_scene("res://scenes/Menus/game_over.tscn")
