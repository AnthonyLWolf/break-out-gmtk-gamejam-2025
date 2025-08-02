extends Node2D

@onready var spotted_timer: Timer = $SpottedTimer
@onready var spotted_bar: ProgressBar = $Control/HBoxContainer/SpottedBar
@onready var spotted_mark: Sprite2D = $SpottedMark
@onready var raycast_spawn: Node2D = $RaycastSpawn
@onready var cone_of_vision: AnimatedSprite2D = $RaycastSpawn/ConeOfVision

@export var time_to_spot = 0.5

signal player_caught

# Player properties
var spotting_player : bool
var player_spotted : bool

# Raycast properties
var sightrays : Array[RayCast2D]
var target = null
var angle_cone_of_vision = deg_to_rad(45.0)
var max_view_distance = -175.0
var angle_between_rays = deg_to_rad(5.0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spotting_player = false
	player_spotted = false
	spotted_timer.wait_time = time_to_spot
	spotted_bar.max_value = time_to_spot
	spotted_bar.visible = false
	spotted_mark.visible = false
	create_raycasts()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if spotting_player:
		spotted_bar.visible = true
		spotted_bar.value = spotted_timer.time_left

# Handles player detection
func create_raycasts() -> void:
	var ray_count = angle_cone_of_vision / angle_between_rays
	for index in ray_count:
		var ray = RayCast2D.new()
		var angle = angle_between_rays * (index - ray_count / 2.0)
		ray.target_position = Vector2.UP.rotated(angle) * max_view_distance
		ray.position = raycast_spawn.position
		add_child(ray)
		sightrays.append(ray)
		ray.enabled = true

func _physics_process(delta: float) -> void:
	target = null
	
	if !spotting_player:
		cone_of_vision.play("idle")
	elif spotting_player:
		cone_of_vision.play("alert")
	
	for ray in sightrays:
		if ray.is_colliding() && ray.get_collider() == get_tree().get_first_node_in_group("Player"):
			target = ray.get_collider()
			break
			
	var does_see_player = target != null

	if does_see_player && !spotting_player && !player_spotted:
		spotting_player = true
		spotted_timer.start()
	elif !does_see_player && spotting_player && !player_spotted:
		spotting_player = false
		spotted_timer.stop()
		spotted_timer.wait_time = time_to_spot
		spotted_bar.visible = false

func _on_spotted_timer_timeout() -> void:
	player_spotted = true
	spotted_mark.visible = true
	player_caught.emit()
	print("Player spotted!")
	spotted_timer.stop()
	spotted_timer.wait_time = time_to_spot
