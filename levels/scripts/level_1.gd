extends Node

signal update_hud_credits(credits)

@export var tilemap: TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func update_weather_decorations(weather):
	match weather:
		GameState.WEATHER.Summer:
			tilemap.randomise_decorations()
		GameState.WEATHER.Autumn:
			tilemap.randomise_decorations(0.1)
		GameState.WEATHER.Winter:
			tilemap.clear_decorations()
		GameState.WEATHER.Spring:
			tilemap.randomise_decorations(0.1)


func _on_plant_handler_update_hud_credits(credits):
	update_hud_credits.emit(credits)
