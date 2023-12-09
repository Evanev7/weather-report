extends Node
class_name World

@export var levels: Array[PackedScene]
var level
var _autoplay = false

func _input(event):
	if event is InputEventMouseMotion and !_autoplay:
		$Camera2D.offset = (event.position - $Camera2D.get_viewport_rect().size/2)/32

func autoplay(enabled: bool):
	_autoplay = enabled
	$TopBar.visible = !enabled
