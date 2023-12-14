extends Node

@export var shader_switch_duration: float = 1

@export var world: Node
@export var camera: Camera2D
var level: Node
var tilemap: TileMap

func _ready():
	GameState.weather_changed.connect(_on_weather_changed)
	#if not tilemap:
		#level = GameState.level1
		#tilemap = level.get_node("TileMap")
	pass

func _input(event):
	if event is InputEventMouseMotion:
		_on_mouse_moved(event.global_position)

func _on_mouse_moved(pos):
	if GameState.level1 is Level:
		pos *= camera.get_viewport_transform()
		#hacky. dont like
		pos /= camera.zoom*camera.zoom
		pos = tilemap.to_local(pos)
		var centre_pos = tilemap.to_global(quantize_tilemap(pos))
		RenderingServer.global_shader_parameter_set("active_tile",centre_pos)

func _on_weather_changed(weather):
	var tween = get_tree().create_tween()
	tween.tween_method(set_shader, float(weather-1), float(weather), shader_switch_duration)
	
func set_shader(weather: float):
	RenderingServer.global_shader_parameter_set("weather", weather)

#	var screen_coords = get_viewport_transform() * global_position
#	var normalized_screen_coords = screen_coords / Vector2(DisplayServer.screen_get_size())
#	RenderingServer.global_shader_parameter_set("player_position", normalized_screen_coords)

func _connect_tilemap(node: TileMap):
	level = node.get_node("TileMap")

func quantize_tilemap(pos: Vector2):
	return tilemap.map_to_local(tilemap.local_to_map(pos) - Vector2i(0,1))
