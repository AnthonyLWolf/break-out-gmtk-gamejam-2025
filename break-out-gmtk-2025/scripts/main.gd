extends Node2D

@onready var grayscale_overlay: ColorRect = $CanvasLayer/GrayscaleOverlay

var loop : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	loop = true # Sets up loop for later breaking
	grayscale_overlay.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Breaks the loop and restores colour
	if Input.is_action_just_pressed("break_loop"):
		loop = false
		grayscale_overlay.visible = false
