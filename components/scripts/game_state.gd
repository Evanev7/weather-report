extends Node

var debug = true

signal spawn_error(msg)
signal fire_from(plant, direction)
signal level_completed
signal paused(state: PAUSE_STATES)
signal weather_changed(weather: WEATHER)

enum LEVEL {MAIN_MENU, LEVEL}
var level: LEVEL
var level1 

enum WEATHER {Summer, Autumn, Winter, Spring}
const weather_names = ["Summer", "Autumn", "Winter", "Spring"]
var weather: WEATHER:
	set(value):
		weather = value
		weather_changed.emit(weather)


enum PAUSE_STATES {MAIN_MENU, UNPAUSED, LEVEL_PAUSED, SHOW_WEATHER_TREE}
var pause_state: PAUSE_STATES = PAUSE_STATES.UNPAUSED

func _ready():
	weather_changed.connect(_on_weather_changed)
	paused.connect(_on_paused)
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_paused(state):
	pause_state = state
	print(pause_state)
	match state:
		PAUSE_STATES.UNPAUSED, PAUSE_STATES.MAIN_MENU:
			get_tree().paused = false
		PAUSE_STATES.SHOW_WEATHER_TREE:
			get_tree().paused = true

func _input(event):
	if event.is_action_pressed("escape"):
		match pause_state:
			PAUSE_STATES.MAIN_MENU:
				get_tree().quit()
			PAUSE_STATES.UNPAUSED:
				get_tree().paused = true
				paused.emit(PAUSE_STATES.LEVEL_PAUSED)
			PAUSE_STATES.LEVEL_PAUSED:
				get_tree().paused = false
				paused.emit(PAUSE_STATES.UNPAUSED)

func show_error(msg):
	spawn_error.emit(msg)

func set_weather(new_weather):
	weather = new_weather


func _on_weather_changed(_weather):
	get_tree().call_group("plant", "set_weather")
	get_tree().call_group("enemy", "set_weather")
