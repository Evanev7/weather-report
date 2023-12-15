extends TileMap

@export var selector_buttongroup: ButtonGroup = preload("res://UI/resources/plant_selector_group.tres")
@export var plant_scene: PackedScene
@export var default_plant_resource_list: Array[PlantResource]
var plant_resource_list: Array[PlantResource]
@export var ghost: AnimatedSprite2D
@export var ghost_radius: Sprite2D

var show_ghost: bool = false
var flower1 := Vector2i(0, 2)
var flower2 := Vector2i(0, 3)
var flower3 := Vector2i(0, 4)
var grass_1 := Vector2i(0, 5)
var grass_2 := Vector2i(0, 6)
var decorations = [flower1, grass_1, grass_2, flower2, flower3]
var decoratable_cells = []

var plant_nodes: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	reset_resource_list()
	get_decoratable_cells()
	randomise_decorations()
	GameState.weather_changed.connect(update_weather_decorations)
	
func reset_resource_list():
	plant_resource_list = default_plant_resource_list.duplicate(true)
	
	
func _process(_delta):
	var mouse_pos = get_global_mouse_position()
	var tile_pos = global_to_grid(mouse_pos)
	var tile_data = get_cell_tile_data(0, tile_pos)
	
	if tile_data is TileData:
		if tile_data.get_custom_data("canPlacePlants"):
			var selection = get_selection()
			if selection < plant_resource_list.size():
				show_plant_ghost(tile_pos, selection)
		else:
			ghost.hide()

func place_plant_at_location(plant_resource, pos):
	var placed_plant = plant_scene.instantiate()
	placed_plant.position = pos
	if owner.water_credits >= plant_resource.COST:
		owner.add_water_credits(-plant_resource.COST)
		owner.ysort.add_child(placed_plant)
		placed_plant.set_plant_as_resource(plant_resource)
		placed_plant.connect("remove_from_node_array", remove_plant_from_array)
		placed_plant.add_to_group("plant")
		$AudioStreamPlayer.play()
		placed_plant.play_spawn_sound()
	else:
		remove_plant_from_array(placed_plant)
		GameState.show_error("You can't afford this!")

func update_weather_decorations(weather):
	#set_tileset()
	match weather:
		GameState.WEATHER.Summer:
			modulate = Color(1, 1, 1)
			randomise_decorations()
		GameState.WEATHER.Autumn:
			modulate = Color(1, 0.87, 0.87)
			clear_decorations()
			randomise_decorations(0.4)
		GameState.WEATHER.Winter:
			clear_decorations()
			modulate = Color(0.7, 1, 1)
		GameState.WEATHER.Spring:
			modulate = Color(1, 1, 1)
			randomise_decorations(0.7)

func get_decoratable_cells():
	var all_bottom_cells = get_used_cells(0)
	for i in all_bottom_cells.size():
		if get_cell_tile_data(0, all_bottom_cells[i]).get_custom_data("canPlaceDecor"):
			decoratable_cells.append(all_bottom_cells[i])

func randomise_decorations(percentage_covered: float = 1):
	for i in (decoratable_cells.size()):
		if randf() < percentage_covered:
			var decoration_index = randi() % (decorations.size() if GameState.weather == GameState.WEATHER.Spring else 3)
			set_cell(1, decoratable_cells[i], 0, decorations[decoration_index])
				
func clear_decorations():
	for cell in decoratable_cells:
		set_cell(1, cell, -1, decorations[randi() % decorations.size() - 2])

func _unhandled_input(event):
	if event.is_action_pressed("left_click"):
		var selection = get_selection()
		if selection < plant_resource_list.size():
			attempt_spawn_plant(get_global_mouse_position(), selection)

func get_selection() -> int:
	var button = selector_buttongroup.get_pressed_button()
	
	if not button or not button.selection:
		return 0
	return button.selection

func attempt_spawn_plant(at_position, plant_id):
	var stored_plant = plant_resource_list[plant_id]
	var tile_mouse_pos = global_to_grid(at_position)
	var final_pos = grid_to_global(tile_mouse_pos)
	if not tile_has_plant(tile_mouse_pos, stored_plant):
		plant_nodes[tile_mouse_pos] = stored_plant
		place_plant_at_location(stored_plant, final_pos)

func show_plant_ghost(at_tile_position, plant_id):
	var stored_plant = plant_resource_list[plant_id]
	var final_pos = grid_to_global(at_tile_position)
	ghost.show()
	ghost.sprite_frames = stored_plant.ANIMATION
	ghost_radius.scale.x = stored_plant.RANGE * 42
	ghost_radius.scale.y = stored_plant.RANGE * 21
	ghost.global_position = final_pos
	
	
func tile_has_plant(coords, _plant) -> bool:
	if get_cell_tile_data(0, coords).get_custom_data("canPlacePlants"):
		if plant_nodes.has(coords):
			GameState.show_error("A plant is already in this location!")
			return true
		else:
			return false
	else:
		GameState.show_error("You can't place plants here!")
		return true
		
#func _on_invasive_spread(origin_coords):
	#for plant in plant_nodes.get_neighbours(origin_coords):
		#plant.do_the_thing()
		
func remove_plant_from_array(plant):
	var plant_coords = global_to_grid(plant.position)
	plant_coords.x -= 1
	plant_coords.y += 2
	if plant_nodes.has(plant_coords):
		plant_nodes.erase(plant_coords)

func global_to_grid(coords: Vector2i) -> Vector2i:
	return local_to_map(to_local(coords))

func grid_to_local(coords: Vector2i) -> Vector2i:
	return map_to_local(coords + Vector2i(1,-2))

func grid_to_global(coords: Vector2i) -> Vector2i:
	return to_global(map_to_local(coords + Vector2i(1,-2)))

