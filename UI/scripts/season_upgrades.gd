extends CanvasLayer

func _ready():
	GameState.paused.connect(_on_paused)

func _on_paused(state):
	match state:
		GameState.PAUSE_STATES.UNPAUSED:
			visible = false
			$CenterContainer/HBoxContainer/PanelContainer.lock_shop.emit()
