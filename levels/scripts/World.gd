extends Node2D
class_name World

enum WEATHER {Summer, Autumn, Winter, Spring}
static var weather: WEATHER

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(event):
	if event is InputEventMouseMotion:
		$Camera2D.offset = (event.position - get_viewport_rect().size/2)/32

static func set_weather(new_weather):
	weather = new_weather
