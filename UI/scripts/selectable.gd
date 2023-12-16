@tool
extends TextureButton

enum SELECTION {sunflower, daisies, tree, rose, mushroom, flytrap, vines}
@export var selection: SELECTION
@export var thumbnail: Texture2D
@export var cost: int
@export var fav_weather: int
@export var weather_icon: Array[Texture2D]

func _ready():
	pass
	
func set_thumbnail():
	$TextureRect.texture = thumbnail
	if fav_weather != 4:
		material.set_shader_parameter("target_blend", GameState.weather_colours[fav_weather])
		material.set_shader_parameter("intensity", GameState.weather_intensities[fav_weather]+0.33)
	$TextureRect/Label.text = str(cost)
