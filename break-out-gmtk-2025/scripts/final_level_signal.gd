extends Node2D

signal final_level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	final_level.emit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
