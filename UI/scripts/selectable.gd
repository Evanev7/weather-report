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
		$TextureRect/TextureRect2.texture = weather_icon[fav_weather]
	$TextureRect/Label.text = str(cost)
