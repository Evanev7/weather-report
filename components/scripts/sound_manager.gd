extends Node

@onready var select_button = $SelectButton
@onready var small_select_button = $SmallSelect
@onready var BG_audio = $BG_audio

func fade_out(stream):
	var tween: Tween = create_tween()
	tween.tween_property(stream, "volume_db", -80, 2).from(linear_to_db(0.4))
	tween.tween_callback(stream.stop)
