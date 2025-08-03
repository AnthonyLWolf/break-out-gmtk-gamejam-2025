extends Node


var current_scene : Node = null

var levels := [
	"res://scenes/levels/level1.tscn",
	"res://scenes/levels/level2.tscn",
	"res://scenes/levels/level3.tscn",
	"res://scenes/levels/level4.tscn",
	"res://scenes/levels/level5.tscn"
]

var current_level_index := 0


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


func load_level(index: int):
	if index >= 0 and index < levels.size():
		current_level_index = index
		load_scene(levels[index])


func load_next_level():
	var next_index = current_level_index + 1
	if next_index < levels.size():
		load_level(next_index)
	else:
		load_scene("res://scenes/Menus/ending.tscn")
