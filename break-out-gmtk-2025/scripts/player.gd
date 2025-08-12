extends CharacterBody2D

@onready var player_camera: Camera2D = $"../PlayerCamera"
@onready var coworkers_saved_label: Label = $CanvasLayer/ScoreLabel
@onready var spacebar_prompt: Label = $CanvasLayer/SpacebarPrompt
@onready var click_prompt: Label = $CanvasLayer/ClickPrompt

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
	if GameManager.coworkers_saved == 0:
		coworkers_saved_label.visible = false
	
	psm = StateMachine.new()
	psm.change_state(PlayerStates.LOOPING)
	GameManager.gsm.change_state(GameManager.GameStates.LOOP)
	
	spacebar_prompt.hide()
	click_prompt.hide()
	
	target = global_position

func _input(event):
	pass
	

func _physics_process(delta: float) -> void:
	if psm.current_state != PlayerStates.LOOPING && psm.current_state != PlayerStates.PLANNING:
		
		# Use is_action_pressed to only accept single taps as input instead of mouse drags.
		if Input.is_action_pressed("click"):
			target = get_global_mouse_position()
	
	if psm.current_state != PlayerStates.SPOTTED:
		velocity = position.direction_to(target) * speed * 1.8
		#look_at(target)
		if position.distance_to(target) > 5:
			move_and_slide()

func _process(delta: float) -> void:
	
	if psm.current_state == PlayerStates.LOOPING:
		await get_tree().create_timer(1.5).timeout
		spacebar_prompt.show()
		
	if psm.current_state == PlayerStates.PLANNING:
		spacebar_prompt.hide()
		await get_tree().create_timer(1.5).timeout
		click_prompt.text = "Prepare to run (hold left click)..."
		click_prompt.show()
		
	if psm.current_state != PlayerStates.LOOPING && psm.current_state != PlayerStates.PLANNING:
		spacebar_prompt.hide()
		click_prompt.hide()
		
	
	if GameManager.coworkers_saved > 0:
		coworkers_saved_label.visible = true
		coworkers_saved_label.text = "Saved: " + str(GameManager.coworkers_saved)
