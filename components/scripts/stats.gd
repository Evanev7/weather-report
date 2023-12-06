extends Node

signal display_stats(who)

var global_stats: Dictionary
var local_stats: Dictionary

func _ready():
	GameState.level_completed.connect(_on_level_completed)
	Stats.display_stats.connect(_on_display_stats)

func _on_display_stats(_who):
	match GameState.pause_state:
		GameState.PAUSE_STATES.MAIN_MENU:
			pass
		GameState.PAUSE_STATES.LEVEL_PAUSED:
			pass

func _on_level_completed():
	for key in global_stats.keys():
		global_stats[key] += local_stats[key]

