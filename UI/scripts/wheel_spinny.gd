extends Sprite2D

@onready var tween
@export_range(0,TAU) var rotation_offset: float
var weather_amount 

func _ready():
	GameState.weather_changed.connect(_on_weather_change)

func _on_weather_change(_weather):
	tween = create_tween()
	var target_rotation = -PI/2.0 * GameState.weather + rotation_offset
	tween.tween_property(self, "rotation", target_rotation, 1).from(target_rotation+PI/2.0)\
		.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
