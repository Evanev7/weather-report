@tool
extends TextureButton

enum SELECTION {plant, potato, garbage_hole}
@export var selection: SELECTION
@export var thumbnail: Texture2D

func _ready():
	pass
	
func set_thumbnail():
	$TextureRect.texture = thumbnail
