extends Node

signal remove_plant_from_array(plant)
signal update_hud_credits(credits)

@export var plant_scene: PackedScene
var position = Vector2(0, 0)
@export var plant_resource_list: Array[PlantResource]

var water_credits: float

func place_plant_at_location(plant_resource, pos):
	var placed_plant = plant_scene.instantiate()
	placed_plant.position = pos
	if water_credits >= plant_resource.COST:
		water_credits -= plant_resource.COST
		placed_plant.set_plant_as_resource(plant_resource)
		update_hud_credits.emit(water_credits)
		placed_plant.connect("remove_from_node_array", remove_plant_from_tilemap)
		placed_plant.add_to_group("plant")
		add_child(placed_plant)
	else:
		remove_plant_from_tilemap(placed_plant)
		GameState.show_error("You can't afford this!")
	
func remove_plant_from_tilemap(plant):
	remove_plant_from_array.emit(plant)

func add_credits(value):
	water_credits += value
	update_hud_credits.emit(water_credits)

