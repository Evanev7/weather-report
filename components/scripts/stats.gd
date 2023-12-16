extends Node

signal display_stats(who)

var _save: SaveGame

var player_data = PlayerData: set = set_stats

## LOCAL STATS
var credits_spent: int = 0
var credits_gained: int = 0
var waves_completed: int = 0
var enemies_killed: int = 0
var damage_dealt: float = 0

func _ready():
	GameState.level_completed.connect(_on_level_completed)
	Stats.display_stats.connect(_on_display_stats)
	create_or_load_save()

func set_stats(new_stats: PlayerData):
	player_data = new_stats
	
func _on_display_stats(who):
	match GameState.pause_state:
		GameState.PAUSE_STATES.MAIN_MENU:
			var stat_screen = who.get_node_or_null("%StatScreen") 
			if stat_screen:
				stat_screen.stats_to_display = {
					"Credits spent": player_data.credits_spent,
					"Credits gained": player_data.credits_gained,
					"Waves completed": player_data.waves_completed,
					"Enemies killed": player_data.enemies_killed,
					"Damage dealth": player_data.damage_dealt
				}
		GameState.PAUSE_STATES.LEVEL_PAUSED:
			var stat_screen = who.get_node_or_null("%StatScreen") 
			if stat_screen:
				stat_screen.stats_to_display = {
					"Credits spent": credits_spent,
					"Credits gained": credits_gained,
					"Waves completed": waves_completed,
					"Enemies killed": enemies_killed,
					"Damage dealth": damage_dealt
				}

func _on_level_completed():
	player_data.credits_spent += credits_spent
	player_data.credits_gained += credits_gained
	player_data.waves_completed += waves_completed
	player_data.enemies_killed += enemies_killed
	player_data.damage_dealt += damage_dealt
		
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
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
