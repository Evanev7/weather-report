extends Level

signal send_resource_list(resource_list)

@onready var plant_resource_list: Array[PlantResource] = $PlantHandler.plant_resource_list

func _ready():
	send_resource_list.emit(plant_resource_list)
