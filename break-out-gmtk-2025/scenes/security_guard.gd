extends Node2D

@onready var patrol_path: PathFollow2D = $Path2D/PatrolPath
@onready var guard_sprite: AnimatedSprite2D = $Path2D/PatrolPath/CharacterBody2D/AnimatedSprite2D
@onready var surveillance_module: Node2D = $Path2D/PatrolPath/CharacterBody2D/AnimatedSprite2D/SurveillanceModule

@export var patrol_pause_duration : float = 1.5
@export var patrol_time : float = 2.5

var patrol_tween : Tween
var guard_sprite_base_scale_y
var player

# Handles guard states
enum GuardStates {
	PATROLLING,
	SPOTTING
}

var guardsm = StateMachine.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Sets default guard behaviour
	guardsm.change_state(GuardStates.PATROLLING)
	
	# Grabs player
	if is_instance_valid(player):
		player = get_tree().get_nodes_in_group("Player")[0]
		print(player.global_position)
	
	# Sets up pathing variables
	guard_sprite_base_scale_y = guard_sprite.scale.y
	patrol_path.progress_ratio = 0.0
	
	setup_patrol()
	move_guard()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass


func move_guard():
	match guardsm.current_state:
		# Handles guard patrolling
		GuardStates.PATROLLING:
			if patrol_tween && !patrol_tween.is_running():
				patrol_tween.play()
		GuardStates.SPOTTING:
			if patrol_tween && patrol_tween.is_running():
				patrol_tween.pause()


func setup_patrol():
	patrol_tween = get_tree().create_tween().set_loops()
			
	# Move forward
	patrol_tween.tween_callback(flip)
	patrol_tween.tween_property(patrol_path, "progress_ratio", 1.0, patrol_time).set_trans(Tween.TRANS_SINE).from(0.0)
	patrol_tween.tween_interval(patrol_pause_duration)
	
	# Move backward
	patrol_tween.tween_callback(flip)
	patrol_tween.tween_property(patrol_path, "progress_ratio", 0.0, patrol_time).set_trans(Tween.TRANS_SINE).from(1.0)
	patrol_tween.tween_interval(patrol_pause_duration)
	
	patrol_tween.play()


func flip():
	if patrol_path.progress_ratio >= 1.0:
		guard_sprite.scale.y = -guard_sprite.scale.y
	elif patrol_path.progress_ratio < 1.0:
		guard_sprite.scale.y = guard_sprite_base_scale_y


func _on_surveillance_module_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("I'M SPOTTING YOUUUUU")
		guardsm.change_state(GuardStates.SPOTTING)
		move_guard()


func _on_surveillance_module_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		guardsm.change_state(GuardStates.PATROLLING)
		move_guard()
