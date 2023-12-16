extends Node
class_name Level

signal update_hud_credits(credits)
signal send_plant_resource_list(resource_list)
signal spawn_error(error_msg, location)
signal update_wave_label(wave)
signal enable_wave_button()
signal game_over(won: bool)

@onready var plant_resource_list: Array[PlantResource] = $TileMap.plant_resource_list
@onready var HUD: CanvasLayer = get_parent().get_node("TopBar")
@onready var ysort: Node2D = $YSort

@export_category("Level Start Stats")

@export var starting_credits: int = 100
@export var starting_weather: GameState.WEATHER = GameState.WEATHER.Summer
@export var waves: Array[EnemyWave] = []

var weather_handler: Node

var water_credits:
	set(val):
		var old_val = val
		if water_credits:
			old_val = water_credits
		water_credits = val
		if old_val > water_credits:
			Stats.player_data.credits_spent += old_val - water_credits
		elif old_val < water_credits:
			Stats.player_data.credits_gained += water_credits - old_val
		update_hud_credits.emit(water_credits)

@onready var greenhouse = $Greenhouse

func _ready():
	start()
	
func start():
	get_tree().call_group("plant", "wilt")
	get_tree().call_group("enemy", "remove")
	get_tree().call_group("bullet", "remove")
	
	GameState.weather = starting_weather
	GameState.weather_handler.reset_weather_resources()
	send_plant_resource_list.emit(plant_resource_list)
	weather_handler.reset_weather_resources()
	greenhouse.restart()
	$TileMap.reset_resource_list()
	$YSort/EnemySpawner.spawning_disabled = true
	end_wave()
	$YSort/EnemySpawner.reset(waves)
	update_wave_label_on_hud(0)
	water_credits = starting_credits
	update_hud_credits.emit(water_credits)


func end_wave():
	enable_wave_button.emit()

func next_wave():
	$YSort/EnemySpawner.start_wave()

func update_wave_label_on_hud(wave):
	update_wave_label.emit(wave)

func add_water_credits(value: int):
	water_credits += value
	update_hud_credits.emit(water_credits)

func damage_greenhouse(value: float):
	greenhouse.take_damage(value)
