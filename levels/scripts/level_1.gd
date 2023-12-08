extends Level

signal send_plant_resource_list(resource_list)
signal update_wave_label(wave)
signal enable_wave_button()

@onready var plant_resource_list: Array[PlantResource] = $PlantHandler.plant_resource_list

@export_category("Level Start Stats")

@export var starting_credits: int = 100
@export var starting_weather: GameState.WEATHER = GameState.WEATHER.Summer
@export var waves: Array[EnemyWave] = []

func _ready():
	start()
	
func start():
	send_plant_resource_list.emit(plant_resource_list)
	$EnemySpawner.reset(waves)
	$PlantHandler.water_credits = starting_credits

func end_wave():
	enable_wave_button.emit()

func next_wave():
	$EnemySpawner.start_wave()

func update_wave_label_on_hud(wave):
	update_wave_label.emit(wave)
