extends TileMap

@export var plant_handler: Node

var flower := Vector2i(0, 2)
var grass_1 := Vector2i(0, 3)
var grass_2 := Vector2i(0, 4)
var decorations = [flower, grass_1, grass_2]
var decoratable_cells = []

var plant_nodes: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	get_decoratable_cells()
	randomise_decorations()
	GameState.weather_changed.connect(update_weather_decorations)




func update_weather_decorations(weather):
	match weather:
		GameState.WEATHER.Summer:
			randomise_decorations()
		GameState.WEATHER.Autumn:
			randomise_decorations(0.1)
		GameState.WEATHER.Winter:
			clear_decorations()
		GameState.WEATHER.Spring:
			randomise_decorations(0.1)

func get_decoratable_cells():
	var all_bottom_cells = get_used_cells(0)
	for i in all_bottom_cells.size():
		if get_cell_tile_data(0, all_bottom_cells[i]).get_custom_data("canPlaceDecor"):
			decoratable_cells.append(all_bottom_cells[i])

func randomise_decorations(percentage_covered: float = 1):
	for i in (decoratable_cells.size() * percentage_covered):
		set_cell(1, decoratable_cells[i], 2, decorations[randi() % decorations.size()])

func clear_decorations():
	for cell in decoratable_cells:
		set_cell(1, cell, -1, decorations[randi() % decorations.size()])

func _unhandled_input(_event):
	if Input.is_action_just_pressed("left_click"):
		var stored_plant = plant_handler.plant_resource_list[randi() % plant_handler.plant_resource_list.size()]
		var tile_mouse_pos = global_to_grid(get_global_mouse_position())
		var final_pos = grid_to_global(tile_mouse_pos)
		if not tile_has_plant(tile_mouse_pos, stored_plant):
			plant_nodes[tile_mouse_pos] = stored_plant
			plant_handler.place_plant_at_location(stored_plant, final_pos)

func tile_has_plant(coords, plant) -> bool:
	if get_cell_tile_data(0, coords).get_custom_data("canPlacePlants"):
		if plant_nodes.has(coords):
			print("plant already placed here!")
			#replace with some UI popup
			return true
		else:
			return false
	else:
		print("can't place plant here!")
		return true
		
#func _on_invasive_spread(origin_coords):
	#for plant in plant_nodes.get_neighbours(origin_coords):
		#plant.do_the_thing()
		
func remove_plant_from_array(plant):
	var plant_coords = global_to_grid(plant.position)
	if plant_nodes.has(plant_coords):
		plant_nodes.erase(plant_coords)

func global_to_grid(coords: Vector2i) -> Vector2i:
	return local_to_map(to_local(coords))

func grid_to_global(coords: Vector2i) -> Vector2i:
	return to_global(map_to_local(coords + Vector2i(1,-2)))

