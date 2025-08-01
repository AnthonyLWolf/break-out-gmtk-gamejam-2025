extends CharacterBody2D

@export var speed = 300.0

var target = Vector2.ZERO

func _ready():
	target = global_position

func _input(event):
	# Use is_action_pressed to only accept single taps as input instead of mouse drags.
	if event.is_action_pressed("click"):
		target = get_global_mouse_position()

func _physics_process(delta: float) -> void:
	
	velocity = position.direction_to(target) * speed
	#look_at(target)
	if position.distance_to(target) > 10:
		move_and_slide()
