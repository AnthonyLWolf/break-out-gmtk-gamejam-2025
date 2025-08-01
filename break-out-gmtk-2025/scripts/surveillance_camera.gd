extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var rotation_speed : float = 3.0

var tween : Tween
var base_angle : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tween = get_tree().create_tween()
	tween.set_loops()
	base_angle = animated_sprite_2d.rotation_degrees
	
	rotate_camera(rotation_speed)

# Handles camera rotation
func rotate_camera(rotation_speed: float):
	tween.tween_property(animated_sprite_2d, "rotation_degrees", base_angle + 25, rotation_speed)
	tween.tween_interval(1)
	tween.tween_property(animated_sprite_2d, "rotation_degrees", base_angle - 25, rotation_speed)
	tween.tween_property(animated_sprite_2d, "rotation_degrees", base_angle - 25, rotation_speed)
	tween.tween_interval(1)
	tween.tween_property(animated_sprite_2d, "rotation_degrees", base_angle + 25, rotation_speed)
