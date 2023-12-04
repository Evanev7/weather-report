extends TileMap

@export var plant_handler: Node

var flower := Vector2i(0, 2)
var grass_1 := Vector2i(0, 3)
var grass_2 := Vector2i(0, 4)
var decorations = [flower, grass_1, grass_2]
var decoratable_cells = []

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
		
func _input(event):
	if Input.is_action_just_pressed("left_click"):
		var mouse_pos = to_local(get_global_mouse_position())
		var tile_mouse_pos = local_to_map(mouse_pos)
		tile_mouse_pos.x += 1
		tile_mouse_pos.y -= 2
		var final_pos = to_global(map_to_local(tile_mouse_pos))
		plant_handler.place_plant_at_location(final_pos)
		

