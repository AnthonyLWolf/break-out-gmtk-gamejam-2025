extends Node

@onready var background_music_player: AudioStreamPlayer = $BackgroundMusicPlayer
@onready var office_fx_player: AudioStreamPlayer = $OfficeFXPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if is_instance_valid(background_music_player):
		background_music_player.stop()
		office_fx_player.stop()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
