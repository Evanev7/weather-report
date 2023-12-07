@tool
extends TextureButton

enum SELECTION {plant, potato, garbage_hole, etc}
@export var selection: SELECTION
@export var thumbnail: Texture2D

func _ready():
	$TextureRect.texture = thumbnail
