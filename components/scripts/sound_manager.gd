extends Node

@onready var select_button = $SelectButton
@onready var small_select_button = $SmallSelect
@onready var BG_audio = $BG_audio
@onready var summer_ambience = $AudioStreamPlayer
@onready var autumn_ambience = $AudioStreamPlayer2
@onready var winter_ambience = $AudioStreamPlayer3

func fade_out(stream):
	var tween: Tween = create_tween()
	tween.tween_property(stream, "volume_db", -80, 2).from(linear_to_db(Stats.player_data.sfx_volume))
	tween.tween_callback(stream.stop)
	tween.tween_callback(func():
		stream.volume_db = 0)
