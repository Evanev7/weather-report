extends Node

signal remove_plant_from_array(plant)

@export var plant_scene: PackedScene
var position = Vector2(0, 0)
@export var sunflower: PlantResource

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func place_plant_at_location(plant_resource, pos):
	var placed_plant = plant_scene.instantiate()
	placed_plant.set_plant_as_resource(plant_resource)
	placed_plant.position = pos
	placed_plant.connect("remove_from_node_array", remove_plant_from_tilemap)
	add_child(placed_plant)
	
func remove_plant_from_tilemap(plant):
	remove_plant_from_array.emit(plant)
