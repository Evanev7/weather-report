extends Sprite2D

@onready var tween

func _ready():
	GameState.weather_changed.connect(_on_weather_change)

func _on_weather_change(_weather):
	if not tween or not tween.is_valid():
		tween = create_tween()
	tween.tween_property(self, "rotation", -PI/2.0 , 1).as_relative().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
	
