extends Camera2D

@onready var main: Node2D = $".."
@onready var camera: Camera2D = $"."

var game_state
var start_tween : Tween
var plan_tween : Tween
var game_tween : Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main.enter_planning.connect(enter_planning_phase)
	main.loop_broken.connect(exit_planning_phase)
	
	camera.zoom = Vector2(2.0, 2.0)
	
	start_tween = get_tree().create_tween()
	
	if GameManager.gsm.current_state == GameManager.GameStates.LOOP:
		start_tween.tween_property(camera, "zoom", Vector2(1.5, 1.5), 5.0) \
			.set_trans(Tween.TRANS_LINEAR)

# Zooms out camera, slows down time for planning phase
func enter_planning_phase():
	start_tween.stop()
	plan_tween = get_tree().create_tween()
	plan_tween.tween_property(camera, "zoom", Vector2(0.4, 0.4), 0.5).set_trans(Tween.TRANS_SPRING)
	await get_tree().create_timer(0.5).timeout
	Engine.time_scale = 0.2
	
# Restores normal time, springs camera back in for the actual game
func exit_planning_phase():
	Engine.time_scale = 1.0
	plan_tween.stop()
	game_tween = get_tree().create_tween()
	game_tween.tween_property(camera, "zoom", Vector2(1.0, 1.0), 0.5).set_trans(Tween.TRANS_SPRING)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
