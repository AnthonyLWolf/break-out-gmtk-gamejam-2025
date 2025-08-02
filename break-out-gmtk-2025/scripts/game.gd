extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var grayscale_overlay: ColorRect = $CanvasLayer/GrayscaleOverlay

var loop : bool

signal enter_planning
signal loop_broken

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	loop = true # Sets up loop for later breaking
	grayscale_overlay.visible = true
	
	var surveillance_modules = get_tree().get_nodes_in_group("SurveillanceModules")
	
	print(surveillance_modules)
	
	for module in surveillance_modules:
		module.connect("player_caught", _game_over)

func _input(event):
	# Enters the planning phase
	if event.is_action_pressed("break_loop") && GameManager.gsm.current_state != GameManager.GameStates.GAMEPLAY:
		GameManager.gsm.change_state(GameManager.GameStates.GAMEPLAY)
		player.psm.change_state(player.PlayerStates.PLANNING)
		grayscale_overlay.visible = false
		enter_planning.emit()
		
	# Exits planning phase and starts gameplay, breaking the corporate loop
	if player.psm.current_state == player.PlayerStates.PLANNING && event.is_action_pressed("click"):
		player.psm.change_state(player.PlayerStates.IDLE)
		loop_broken.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _game_over():
	Engine.time_scale = 0.5
	await get_tree().create_timer(1.0).timeout
	print("GAME OVER!!!")
	Engine.time_scale = 1.0
