extends Node2D

@onready var path_follow: PathFollow2D = $Path2D/PathFollow2D

# In seconds for the tween
@export var path_speed := 5.0

var progress_tween : Tween

func _ready() -> void:
	setup_progress_tween()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func setup_progress_tween() -> void:
	progress_tween = get_tree().create_tween().set_loops()
	
	progress_tween.tween_property(path_follow, "progress_ratio", 1.0, path_speed).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	progress_tween.tween_property(path_follow, "progress_ratio", 0.0, path_speed).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
