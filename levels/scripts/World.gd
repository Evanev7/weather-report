extends Node
class_name World

@export var levels: Array[PackedScene]
@onready var HUD: CanvasLayer = $TopBar
@onready var weather_handler: Node = $LogicComponents/WeatherHandler

func _ready():
	pass
	
func set_level(level):
	if Stats.player_data.tutorial_shown:
		$Tutorial.hide()
	else:
		$Tutorial.show()
	
	var level_to_set = levels[level].instantiate()
	GameState.level = level_to_set
	level_to_set.update_hud_credits.connect(HUD._on_level_1_update_hud_credits)
	level_to_set.send_plant_resource_list.connect(HUD.set_thumbnails)
	level_to_set.update_wave_label.connect(HUD.update_wave_label)
	level_to_set.enable_wave_button.connect(HUD.end_wave)
	level_to_set.game_over.connect(%PauseMenu._on_game_over)
	level_to_set.weather_handler = weather_handler
	%PauseMenu.restart_level.connect(level_to_set.start)
	HUD.next_wave.connect(level_to_set.next_wave)
	$LogicComponents/ShaderManager.tilemap = level_to_set.get_node("TileMap")
	add_child(level_to_set)
	move_child(level_to_set, 0)
	$TopBar.visible = true
	SoundManager.BG_audio.play()

func _input(event):
	if event is InputEventMouseMotion:
		$Camera2D.offset = (event.position - $Camera2D.get_viewport_rect().size/2)/32
