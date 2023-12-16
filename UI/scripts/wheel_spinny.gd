extends Sprite2D

@onready var tween
@export_range(0,TAU) var rotation_offset: float
var weather_amount 

func _ready():
	print(position)
	GameState.weather_changed.connect(_on_weather_change)

func _on_weather_change(_weather):
	if GameState.level is Level:
		$turn.play()
	tween = create_tween()
	var overshoot = randf_range(PI/24, PI/12)
	var target_rotation = -PI/2.0 * GameState.weather + rotation_offset
	tween.tween_property(self, "rotation", target_rotation, 0.6).from(target_rotation+PI/2.0)\
		.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "rotation", - overshoot, 0.1).as_relative()\
		.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "rotation", overshoot, 0.3).as_relative()\
		.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if (to_local(event.position) - position).length() < 1000:
			GameState.weather_handler.try_change_weather()
