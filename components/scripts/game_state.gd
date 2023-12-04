extends Node

var debug = true
signal fire_from(position, direction)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _fire_from(position, direction):
	fire_from.emit(position, direction)
