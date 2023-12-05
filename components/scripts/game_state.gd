extends Node

var debug = true
signal fire_from(plant, direction)

enum WEATHER {Summer, Autumn, Winter, Spring}
var weather: WEATHER


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func set_weather(new_weather):
	weather = new_weather
	get_tree().call_group("plant", "set_weather")
	get_tree().call_group("enemy", "set_weather")
