@icon("res://prototype/sprites/Coworkers2.png")

extends CharacterBody2D


@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var body: AnimatedSprite2D = $Body
@onready var found_icon: AnimatedSprite2D = $Body/FoundIcon
@onready var active_coworker: CharacterBody2D = $"."

# Reference variables
var player = null
var portal = null
var found : bool = false

# Position variables
var starting_position = global_position
var player_start_position : Vector2
var player_current_position : Vector2
var target_position : Vector2

# Movement variables
@export var move_speed : int = 11
@export var acceleration : int = 30

# Breadcrumbs variables
@export var trail_spacing = 3.0
var distance_walked = 0.0
var previous_position : Vector2
var position_buffer : Vector2
var current_index : int

enum CoworkerStates {
	WAITING,
	FOLLOWING,
	SAVING,
	SAVED
}
var csm = StateMachine.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	found_icon.visible = false
	player = get_tree().get_first_node_in_group("Player")
	portal = get_tree().get_first_node_in_group("CoworkerPortal")
	
	# Gets the starting position for navigation
	previous_position = global_position
	position_buffer = global_position
	
	# OLD WAY: Nav agent variables
	nav_agent.path_desired_distance = 100.0
	nav_agent.target_desired_distance = 50.0
	nav_agent.path_max_distance = 50.0
	csm.change_state(CoworkerStates.WAITING)

func _physics_process(delta: float) -> void:
	
	if csm.current_state == CoworkerStates.FOLLOWING:
		
		if distance_walked <= trail_spacing:
			distance_walked += 1
		elif distance_walked >= trail_spacing:
			distance_walked = 0
			previous_position = position_buffer
			position_buffer = global_position
		
		current_index = player.coworker_trail.find(active_coworker, 0)
		
		# Follows player position with an offset based on the player's most recent position relative to trail spacing
		if current_index == 0:
			target_position = player.previous_position
			global_position = global_position.move_toward(target_position, (move_speed * acceleration) * delta)
		else:
			if is_instance_valid(player.coworker_trail[current_index - 1]):
				target_position = player.coworker_trail[current_index - 1].previous_position
				global_position = global_position.move_toward(target_position, (move_speed * acceleration) * delta)
	
	# Makes all coworkers in the current trail aim for the portal as soon as the first one is saved
	if csm.current_state == CoworkerStates.SAVING:
		global_position = global_position.move_toward(portal.global_position, (move_speed * acceleration) * delta)
	
	# Saves all coworkers currently in the queue and shifts queue positions (score handled in portal logic)
	if csm.current_state == CoworkerStates.SAVED:
		for coworker in player.coworker_trail:
			coworker.csm.change_state(coworker.CoworkerStates.SAVING)
		player.coworker_trail.clear()
		queue_free()


func change_direction(direction : float) -> void:
	if sign(direction) == -1:
		body.flip_h = false
	elif sign(direction) == 1:
		body.flip_h = true

# Handles queue when coworker is found
func _on_found_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") && !found:
		found = true
		player.coworker_trail.push_front(active_coworker) # Pushes active coworker to the front of the queue
		csm.change_state(CoworkerStates.FOLLOWING)
		found_icon.visible = true
		found_icon.play("found")
		await get_tree().create_timer(1.0).timeout
		found_icon.visible = false
		
