extends CanvasLayer

func _ready():
	GameState.paused.connect(_on_pause_pressed)

func _on_pause_pressed(who):
	match who:
		GameState.PAUSE_STATES.LEVEL_PAUSED:
			visible = true
		GameState.PAUSE_STATES.UNPAUSED:
			visible = false
