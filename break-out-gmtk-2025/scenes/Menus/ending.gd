extends Control

@export var link : String

@onready var coworkers : Label = $CanvasLayer/Panel/VBoxContainer/Coworkers
@onready var score_label : Label = $CanvasLayer/Panel/VBoxContainer/ScoreLabel
@onready var credits_panel: Panel = $CanvasLayer/CreditsPanel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	credits_panel.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	coworkers.text = str(GameManager.coworkers_saved)
	score_label.text = str(GameManager.coworkers_saved * 102)


func _on_restart_button_pressed() -> void:
	SceneController.load_scene("res://scenes/Menus/main_menu.tscn")


func _on_itch_button_pressed() -> void:
	OS.shell_open(link)


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_continue_pressed() -> void:
	credits_panel.show()
