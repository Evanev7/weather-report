extends Node

var weather_can_change: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.weather = GameState.WEATHER.Summer


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("change_weather") and weather_can_change:
		GameState.weather = (GameState.weather + 1) % 4
		weather_can_change = false
		$Timer.start()


func _on_timer_timeout():
	weather_can_change = true
