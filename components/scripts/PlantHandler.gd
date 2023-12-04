extends Node

@export var plant_scene: PackedScene
var position = Vector2(0, 0)
@export var sunflower: PlantResource

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func place_plant_at_location(pos, plant_resource = sunflower):
	var placed_plant = plant_scene.instantiate()
	placed_plant.set_plant_as_resource(plant_resource)
	placed_plant.position = pos
	add_child(placed_plant)
