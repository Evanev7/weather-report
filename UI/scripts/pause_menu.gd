extends CanvasLayer

signal restart_level()

func _ready():
	GameState.paused.connect(_on_pause_pressed)

func _on_pause_pressed(who):
	match who:
		GameState.PAUSE_STATES.LEVEL_PAUSED:
			visible = true
		GameState.PAUSE_STATES.UNPAUSED:
			visible = false

func _on_restart_button_pressed():
	restart_level.emit()
	GameState.paused.emit(GameState.PAUSE_STATES.UNPAUSED)
