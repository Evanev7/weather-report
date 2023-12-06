extends Node

@onready var HUD: CanvasLayer = get_parent().get_node("main/World/HUD")

var debug = true
signal fire_from(plant, direction)
signal level_completed
signal paused(state: PAUSE_STATES)

enum LEVEL {MAIN_MENU, LEVEL}
var level: LEVEL

enum WEATHER {Summer, Autumn, Winter, Spring}
const weather_names = ["Summer", "Autumn", "Winter", "Spring"]
var weather: WEATHER

func set_weather(new_weather):
	weather = new_weather
	HUD.update_weather(weather)
	get_tree().call_group("plant", "set_weather")
	get_tree().call_group("enemy", "set_weather")

enum PAUSE_STATES {MAIN_MENU, UNPAUSED, LEVEL_PAUSED}
var pause_state: PAUSE_STATES = PAUSE_STATES.UNPAUSED

func _ready():
	paused.connect(_on_paused)
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_paused(state):
	pause_state = state
	if state == PAUSE_STATES.UNPAUSED:
		get_tree().paused = false

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
