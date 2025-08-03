extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.gsm.change_state(GameManager.GameStates.MENUS)
	SceneController.load_scene("res://scenes/Menus/main_menu.tscn")
