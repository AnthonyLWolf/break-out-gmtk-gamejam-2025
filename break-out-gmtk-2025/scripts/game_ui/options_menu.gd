extends Control

@onready var options_menu: Control = %OptionsMenu

@onready var MASTER_BUS_ID = AudioServer.get_bus_index("Master")
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")


func _on_return_pressed() -> void: # press return button
	options_menu.visible = !options_menu.visible

func _on_master_slider_value_changed(value: float) -> void: # master volume
	AudioServer.set_bus_volume_db(MASTER_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(MASTER_BUS_ID, value < 0.05)


func _on_music_slider_value_changed(value: float) -> void: # music volume
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(MUSIC_BUS_ID, value < 0.05)


func _on_sfx_slider_value_changed(value: float) -> void: # sfx volume
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(SFX_BUS_ID, value < 0.05)
