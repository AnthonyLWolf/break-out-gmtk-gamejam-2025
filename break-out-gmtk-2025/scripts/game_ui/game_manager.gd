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
func _process(delta: float) -> void:
	if gsm.current_state != GameStates.PAUSED && gsm.current_state != GameStates.MENUS:
		if Input.is_action_just_pressed("pause"):
			gsm.change_state(GameStates.PAUSED)
			get_tree().paused = true
	elif gsm.current_state == GameStates.PAUSED:
		if Input.is_action_just_pressed("pause"):
			gsm.change_state(GameStates.GAMEPLAY)
			get_tree().paused = false



#TODO: Implement text box for basic dialogue - set up queueing system here
