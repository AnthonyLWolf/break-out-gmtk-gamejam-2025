extends CharacterBody2D

@export var follow_speed : int = 100
@export var acceleration : int = 50
@export var friction : int = 1000


@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var body: AnimatedSprite2D = $Body
@onready var found_icon: AnimatedSprite2D = $Body/FoundIcon

var player = null
var found : bool = false

enum CoworkerStates {
	WAITING,
	FOLLOWING,
	SAVED
}

var csm = StateMachine.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	found_icon.visible = false
	player = get_tree().get_first_node_in_group("Player")
	nav_agent.path_desired_distance = 200.0
	nav_agent.target_desired_distance = 50.0
	nav_agent.path_max_distance = 100.0
	csm.change_state(CoworkerStates.WAITING)

func _physics_process(delta: float) -> void:
	
	if csm.current_state == CoworkerStates.FOLLOWING:
		var direction : Vector2 = (nav_agent.get_next_path_position() - global_position).normalized()
		change_direction(direction.x)
		set_movement_target()
		
		if !nav_agent.is_target_reached():
			if direction != Vector2.ZERO:
				velocity = velocity.move_toward(direction * follow_speed, acceleration * delta)
				
		else:
			velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
			
		move_and_slide()
		
	if csm.current_state == CoworkerStates.SAVED:
		queue_free()

func set_movement_target() -> void:
	await get_tree().physics_frame
	nav_agent.target_position = player.position - Vector2(20.0, 20.0)
	
func change_direction(direction : float) -> void:
	if sign(direction) == -1:
		body.flip_h = false
	elif sign(direction) == 1:
		body.flip_h = true


func _on_found_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") && !found:
		found = true
		csm.change_state(CoworkerStates.FOLLOWING)
		found_icon.visible = true
		found_icon.play("found")
		await get_tree().create_timer(1.0).timeout
		found_icon.visible = false
		
