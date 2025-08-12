extends Node2D

var coworker_to_spawn = preload("res://scenes/active_coworker.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if GameManager.coworkers_saved > 0:
		var saved_coworkers = GameManager.coworkers_saved
	
		for index in range(saved_coworkers):
			if index < saved_coworkers:
				var spawned_coworker = coworker_to_spawn.instantiate()
				# Scatter spawn
				var offset = Vector2(randi_range(-25,25), randi_range(-25, 25))
				spawned_coworker.position += offset
				add_child(spawned_coworker)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
