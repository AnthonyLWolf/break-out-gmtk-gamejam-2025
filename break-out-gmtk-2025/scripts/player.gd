@icon("res://prototype/sprites/Player1.png")

extends CharacterBody2D

@onready var player_camera: Camera2D = $"../PlayerCamera"
@onready var coworkers_saved_label: Label = $CanvasLayer/ScoreLabel
@onready var spacebar_prompt: Label = $CanvasLayer/SpacebarPrompt
@onready var click_prompt: Label = $CanvasLayer/ClickPrompt
@onready var pl_sprite: AnimatedSprite2D = $Sprite2D

@export var speed = 200.0
@export var acceleration = 1000.0

# Position variables
var origin_position = Vector2.ZERO
var target = Vector2.ZERO

# Trail variables
@export var trail_spacing = 6.0

var distance_walked = 0
var previous_position : Vector2
var position_buffer : Vector2
var coworker_trail : Array = []

# Direction variables
var direction = Vector2.ZERO

var moving_left = false
var moving_up = false

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
	
	previous_position = global_position
	
	target = global_position

func _input(event):
	pass
	

func _physics_process(delta: float) -> void:
	if psm.current_state != PlayerStates.LOOPING && psm.current_state != PlayerStates.PLANNING:
		
		# Use is_action_pressed to only accept single taps as input instead of mouse drags.
		if Input.is_action_pressed("click"):
			target = get_global_mouse_position()
			
			if target.x > position.x:
				pl_sprite.flip_h = false
				moving_left = false
			elif target.x < position.x:
				pl_sprite.flip_h = true
				moving_left = true
				
			if target.y > position.y:
				moving_up = false
			elif target.y < position.y:
				moving_up = true
		
	
	# Moves player if NOT spotted and calculates direction vector
	if psm.current_state != PlayerStates.SPOTTED:
		velocity = position.direction_to(target) * (speed * acceleration) * delta
		#global_position = global_position.move_toward(target, (speed * acceleration) * delta) ## Move_toward does not detect collision?
		if position.distance_to(target) > 5:
			
			# Keeps track of distance walked
			if distance_walked != trail_spacing:
				distance_walked += 1
			elif distance_walked >= trail_spacing:
				distance_walked = 0
				previous_position = position_buffer
				position_buffer = global_position
				
			origin_position = global_position
			direction = (target - origin_position).normalized()
	
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
