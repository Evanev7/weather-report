extends Node

signal display_stats(who)

var _save: SaveGame

var player_data = PlayerData: set = set_stats

@export var global_stats: Dictionary
@export var local_stats: Dictionary

func _ready():
	GameState.level_completed.connect(_on_level_completed)
	Stats.display_stats.connect(_on_display_stats)
	create_or_load_save()

func set_stats(new_stats: PlayerData):
	player_data = new_stats
	
func _on_display_stats(_who):
	match GameState.pause_state:
		GameState.PAUSE_STATES.MAIN_MENU:
			pass
		GameState.PAUSE_STATES.LEVEL_PAUSED:
			pass

func _on_level_completed():
	for key in local_stats.keys():
		global_stats[key] += local_stats[key]
		
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		print("quit")
		save_game()
		get_tree().quit()
		
func create_or_load_save():
	if SaveGame.save_exists():
		_save = SaveGame.load_savegame() as SaveGame
	else:
		_save = SaveGame.new()
		_save.write_savegame()

	player_data = _save.player_data
	
	AudioServer.set_bus_volume_db(0, linear_to_db(player_data.master_volume))
	AudioServer.set_bus_volume_db(1, linear_to_db(player_data.sfx_volume))
	AudioServer.set_bus_volume_db(2, linear_to_db(player_data.music_volume))
	
func save_game():
	_save.write_savegame()
