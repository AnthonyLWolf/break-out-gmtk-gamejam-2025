extends Node2D

@onready var spotted_timer: Timer = $SpottedTimer
@onready var timer_label: RichTextLabel = $TimerLabel

const TIME_TO_SPOT = 3.0

var spotting_player : bool
var player_spotted : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spotting_player = false
	player_spotted = false
	spotted_timer.wait_time = TIME_TO_SPOT

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer_label.text = str(roundf(spotted_timer.time_left))
	
	if Input.is_action_pressed("break_loop"):
		player_spotted = false

# Handles player detection
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") && !player_spotted && spotted_timer.is_stopped():
		spotting_player = true
		spotted_timer.start()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player") && !player_spotted:
		spotting_player = false
		spotted_timer.stop()
		spotted_timer.wait_time = TIME_TO_SPOT

func _on_spotted_timer_timeout() -> void:
	player_spotted = true
	print("Player spotted!")
	spotted_timer.stop()
	spotted_timer.wait_time = TIME_TO_SPOT
