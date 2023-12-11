extends Sprite2D

@onready var tween
var weather_amount 

func _ready():
	GameState.weather_changed.connect(_on_weather_change)

func _on_weather_change(_weather):
	tween = create_tween()
	tween.tween_property(self, "rotation", -PI/2.0 * GameState.weather, 1).from(-PI/2.0 * (GameState.weather-1))\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
