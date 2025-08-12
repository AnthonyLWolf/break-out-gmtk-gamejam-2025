extends Control

@onready var canvas_layer: CanvasLayer = $CanvasLayer


func _ready() -> void:
	hide()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") && !get_tree().paused:
		get_tree().paused = true
		canvas_layer.show()
	elif event.is_action_pressed("pause") && get_tree().paused:
		get_tree().paused = false
		canvas_layer.hide()

func _on_unpause_button_pressed() -> void:
	GameManager.gsm.change_state(GameManager.gsm.previous_state)
	canvas_layer.hide()


func _on_quit_button_pressed() -> void:
	SceneController.load_scene("res://scenes/Menus/game_over.tscn")
