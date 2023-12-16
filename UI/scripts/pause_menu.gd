extends CanvasLayer

signal restart_level()

func _ready():
	GameState.paused.connect(_on_pause_pressed)

func _on_pause_pressed(who):
	match who:
		GameState.PAUSE_STATES.LEVEL_PAUSED:
			visible = true
			$OptionsMenu.visible = true
		_:
			SoundManager.select_button.play()
			visible = false
			Stats.save_game()
			$OptionsMenu.visible = false

func _on_restart_button_pressed():
	SoundManager.select_button.play()
	restart_level.emit()
	GameState.paused.emit(GameState.PAUSE_STATES.UNPAUSED)

func _on_game_over(won: bool):
	GameState.paused.emit(GameState.PAUSE_STATES.LEVEL_PAUSED)
	if won:
		%Title.text = "Victory!"
	else:
		%Title.text = "Defeat :("


func _on_main_menu_button_pressed():
	GameState.paused.emit(GameState.PAUSE_STATES.MAIN_MENU)
