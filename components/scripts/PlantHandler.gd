extends Node

signal remove_plant_from_array(plant)

@export var plant_scene: PackedScene
@export var plant_resource_list: Array[PlantResource]
	
func remove_plant_from_tilemap(plant):
	remove_plant_from_array.emit(plant)

