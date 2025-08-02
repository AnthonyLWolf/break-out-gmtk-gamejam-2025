extends Node
class_name StateMachine

# Keeps track of states
var current_state
var previous_state

# Simple function to change state
func change_state(new_state) -> void:
	previous_state = current_state
	current_state = new_state
