extends Node

var current_scene : Node = null


func load_scene(scene: String):
	if current_scene:
		current_scene.queue_free()
	var new_scene = load(scene).instantiate()
	add_child(new_scene)
	current_scene = new_scene

	
func unload_current_scene():
	if current_scene:
		current_scene.queue_free()
		current_scene = null
