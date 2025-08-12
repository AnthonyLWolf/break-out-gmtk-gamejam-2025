extends Control

@onready var coworkers_saved: Label = $CanvasLayer/Panel/VBoxContainer/CoworkersSaved

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.gsm.change_state(GameManager.GameStates.GAMEOVER)

func _process(delta: float) -> void:
	coworkers_saved.text = str(GameManager.coworkers_saved)

func _on_restart_button_pressed() -> void:
	SceneController.unload_current_scene()
	SceneController.load_scene("res://scenes/Menus/main_menu.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
