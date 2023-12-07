extends Level

signal send_plant_resource_list(resource_list)

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
