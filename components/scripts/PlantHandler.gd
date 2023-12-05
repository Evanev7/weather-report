extends Node

signal remove_plant_from_array(plant)
signal update_hud_credits(credits)

@export var plant_scene: PackedScene
var position = Vector2(0, 0)
@export var plant_resource_list: Array[PlantResource]

@export var water_credits: float = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func place_plant_at_location(plant_resource, pos):
	water_credits -= plant_resource.COST
	if water_credits >= 0:
		var placed_plant = plant_scene.instantiate()
		placed_plant.set_plant_as_resource(plant_resource)
		update_hud_credits.emit(water_credits)
		placed_plant.position = pos
		placed_plant.connect("remove_from_node_array", remove_plant_from_tilemap)
		add_child(placed_plant)
	else:
		print("can't buy this!")
		water_credits += plant_resource.COST
	
func remove_plant_from_tilemap(plant):
	remove_plant_from_array.emit(plant)

func add_credits(value):
	water_credits += value
	update_hud_credits.emit(water_credits)

