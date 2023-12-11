extends Node
class_name World

@export var levels: Array[PackedScene]
@onready var HUD: CanvasLayer = $TopBar
var _autoplay = false

func _ready():
	pass
	
func set_level(level):
	var level_to_set = levels[level].instantiate()
	GameState.level1 = level_to_set
	if level_to_set is Level:
		level_to_set.update_hud_credits.connect(HUD._on_level_1_update_hud_credits)
		level_to_set.send_plant_resource_list.connect(HUD.set_thumbnails)
		level_to_set.update_wave_label.connect(HUD.update_wave_label)
		level_to_set.enable_wave_button.connect(HUD.end_wave)
		%PauseMenu.restart_level.connect(level_to_set.start)
		HUD.next_wave.connect(level_to_set.next_wave)
		$LogicComponents/ShaderManager.tilemap = level_to_set.get_node("TileMap")
	add_child(level_to_set)

func _input(event):
	if event is InputEventMouseMotion and !_autoplay:
		$Camera2D.offset = (event.position - $Camera2D.get_viewport_rect().size/2)/32

func autoplay(enabled: bool):
	_autoplay = enabled
	$TopBar.visible = !enabled
