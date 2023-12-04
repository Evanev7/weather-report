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
	for i in range(200):
		randomise_decorations()
		await get_tree().create_timer(0.1).timeout

func get_decoratable_cells():
	var all_bottom_cells = get_used_cells(0)
	for i in all_bottom_cells.size():
		if get_cell_tile_data(0, all_bottom_cells[i]).get_custom_data("canPlaceDecor"):
			decoratable_cells.append(all_bottom_cells[i])

func randomise_decorations():
	for cell in decoratable_cells:
		set_cell(1, cell, 2, decorations[randi() % decorations.size()])


func _input(_event):
	if Input.is_action_just_pressed("left_click"):
		var stored_plant = plant_handler.sunflower
		var mouse_pos = to_local(get_global_mouse_position())
		var tile_mouse_pos = local_to_map(mouse_pos)
		tile_mouse_pos.x += 1
		tile_mouse_pos.y -= 2
		var final_pos = to_global(map_to_local(tile_mouse_pos))
		if not tile_has_plant(tile_mouse_pos, stored_plant):
			plant_handler.place_plant_at_location(stored_plant, final_pos)

func tile_has_plant(coords, plant):
	coords.x -= 1
	coords.y += 2
	if get_cell_tile_data(0, coords).get_custom_data("canPlacePlants"):
		if plant_nodes.has(coords):
			print("plant already placed here!")
			#replace with some UI popup
			return true
		else:
			plant_nodes[coords] = plant
			return false
	else:
		print("can't place plant here!")
		return true
		
#func _on_invasive_spread(origin_coords):
	#for plant in plant_nodes.get_neighbours(origin_coords):
		#plant.do_the_thing()
		
func remove_plant_from_array(plant):
	var plant_coords = local_to_map(to_local(plant.position))
	if plant_nodes.has(plant_coords):
		plant_nodes.erase(plant_coords)


