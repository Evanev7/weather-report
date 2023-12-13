extends Node
class_name Level

signal update_hud_credits(credits)
signal send_plant_resource_list(resource_list)
signal spawn_error(error_msg, location)
signal update_wave_label(wave)
signal enable_wave_button()

@onready var plant_resource_list: Array[PlantResource] = $TileMap.plant_resource_list
@onready var HUD: CanvasLayer = get_parent().get_node("TopBar")

@export_category("Level Start Stats")

@export var starting_credits: int = 100
@export var starting_weather: GameState.WEATHER = GameState.WEATHER.Summer
@export var waves: Array[EnemyWave] = []

var weather_handler: Node

var water_credits
@onready var greenhouse = $Greenhouse

func _ready():
	start()
	
func start():
	get_tree().call_group("plant", "wilt")
	get_tree().call_group("enemy", "remove")
	get_tree().call_group("bullet", "remove")
	
	GameState.weather = starting_weather
	send_plant_resource_list.emit(plant_resource_list)
	weather_handler.reset_weather_resources()
	$TileMap.reset_resource_list()
	$EnemySpawner.end_wave()
	$EnemySpawner.reset(waves)
	update_wave_label_on_hud(0)
	water_credits = starting_credits
	update_hud_credits.emit(water_credits)


func end_wave():
	enable_wave_button.emit()

func next_wave():
	$EnemySpawner.start_wave()

func update_wave_label_on_hud(wave):
	update_wave_label.emit(wave)

func add_water_credits(value: int):
	water_credits += value
	update_hud_credits.emit(water_credits)

func damage_greenhouse(value: float):
	greenhouse.take_damage(value)
