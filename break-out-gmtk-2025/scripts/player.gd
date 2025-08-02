extends CharacterBody2D

@onready var player_camera: Camera2D = $"../PlayerCamera"

@export var speed = 300.0

var target = Vector2.ZERO

enum PlayerStates {
	LOOPING,
	PLANNING,
	IDLE,
	WALKING,
	READING,
	SPOTTED
}

var psm : StateMachine

func _ready():
	psm = StateMachine.new()
	psm.change_state(PlayerStates.LOOPING)
	GameManager.gsm.change_state(GameManager.GameStates.LOOP)
	
	target = global_position

func _input(event):
	if psm.current_state != PlayerStates.LOOPING && psm.current_state != PlayerStates.PLANNING:
		# Use is_action_pressed to only accept single taps as input instead of mouse drags.
		if event.is_action_pressed("click"):
			target = get_global_mouse_position()

func _physics_process(delta: float) -> void:
	
	velocity = position.direction_to(target) * speed
	#look_at(target)
	if position.distance_to(target) > 5:
		move_and_slide()
