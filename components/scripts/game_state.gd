extends Node

var debug = true

@onready var weather_handler: Node = get_parent().get_node("main/World/LogicComponents/WeatherHandler")

signal spawn_error(msg)
signal fire_from(plant, direction)
signal level_completed
signal paused(state: PAUSE_STATES)
signal weather_changed(weather: WEATHER)

var level

enum WEATHER {Summer, Autumn, Winter, Spring}
const weather_names = ["Summer", "Autumn", "Winter", "Spring"]
const weather_colours = [Color(1,1,0,1),Color(0.72,0.29,0.03,1),Color(0,1,1,1),Color(1,0,1,1)]
const weather_intensities = [0.33,0.66,0.33,0.33]
var weather: WEATHER:
	set(value):
		weather = value
		weather_changed.emit(weather)


enum PAUSE_STATES {MAIN_MENU, UNPAUSED, LEVEL_PAUSED, SHOW_WEATHER_TREE, TUTORIAL_SHOWN}
var pause_state: PAUSE_STATES = PAUSE_STATES.UNPAUSED

func _ready():
	weather_changed.connect(_on_weather_changed)
	paused.connect(_on_paused)
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_paused(state):
	pause_state = state
	match state:
		PAUSE_STATES.UNPAUSED:
			get_tree().paused = false
		PAUSE_STATES.MAIN_MENU:
			get_tree().paused = false
			if level:
				level.queue_free()
				level = null
			get_parent().get_node("main/MainMenu").visible = true
		PAUSE_STATES.SHOW_WEATHER_TREE, PAUSE_STATES.LEVEL_PAUSED, PAUSE_STATES.TUTORIAL_SHOWN:
			get_tree().paused = true

func _input(event):
	if event.is_action_pressed("escape"):
		match pause_state:
			PAUSE_STATES.MAIN_MENU:
				get_tree().quit()
			PAUSE_STATES.UNPAUSED:
				paused.emit(PAUSE_STATES.LEVEL_PAUSED)
			PAUSE_STATES.LEVEL_PAUSED:
				paused.emit(PAUSE_STATES.UNPAUSED)

func show_error(msg):
	spawn_error.emit(msg)

func set_weather(new_weather):
	weather = new_weather


func _on_weather_changed(_weather):
	get_tree().call_group("plant", "set_weather")
	get_tree().call_group("enemy", "set_weather")
