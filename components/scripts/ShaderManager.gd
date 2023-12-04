extends Node

@export var camera: Camera2D
@export var level: Node
@onready var tilemap: TileMap = level.get_node("TileMap")

func _input(event):
	if event is InputEventMouseMotion:
		_on_mouse_moved(event.global_position)

func _on_mouse_moved(pos):
	pos *= camera.get_viewport_transform()
	pos = tilemap.to_local(pos)
	var centre_pos = tilemap.to_global(quantize_tilemap(pos))
	RenderingServer.global_shader_parameter_set("active_tile",centre_pos)

#	var screen_coords = get_viewport_transform() * global_position
#	var normalized_screen_coords = screen_coords / Vector2(DisplayServer.screen_get_size())
#	RenderingServer.global_shader_parameter_set("player_position", normalized_screen_coords)

func _connect_tilemap(node: TileMap):
	tilemap = node

func quantize_tilemap(pos: Vector2):
	return tilemap.map_to_local(tilemap.local_to_map(pos) - Vector2i(0,1))
