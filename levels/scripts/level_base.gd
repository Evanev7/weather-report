extends Node
class_name Level

signal update_hud_credits(credits)

signal spawn_error(error_msg, location)
signal send_plant_resource_list(resource_list)
signal update_wave_label(wave)
signal enable_wave_button()

@onready var plant_resource_list: Array[PlantResource] = $TileMap.plant_resource_list



@export_category("Level Start Stats")

@export var starting_credits: int = 100
@export var starting_weather: GameState.WEATHER = GameState.WEATHER.Summer
@export var waves: Array[EnemyWave] = []

var water_credits
@onready var greenhouse = $Greenhouse

func _ready():
	start()
	
func start():
	send_plant_resource_list.emit(plant_resource_list)
	$EnemySpawner.reset(waves)
	water_credits = starting_credits


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
