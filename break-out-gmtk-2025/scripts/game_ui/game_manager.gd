extends Node

# Game states machine setup
enum GameStates {
	MENUS,
	LOOP,
	GAMEPLAY,
	LEVELCOMPLETE,
	PAUSED,
	GAMEOVER
}

var gsm : StateMachine

var current_level : String
var coworkers_saved : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gsm = StateMachine.new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		get_tree().quit()



#TODO: Implement text box for basic dialogue - set up queueing system here
