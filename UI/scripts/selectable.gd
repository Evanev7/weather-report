@tool
extends TextureButton

enum SELECTION {sunflower, daisies, tree, rose, mushroom, flytrap, vines}
@export var selection: SELECTION
@export var thumbnail: Texture2D

func _ready():
	pass
	
func set_thumbnail():
	$TextureRect.texture = thumbnail
