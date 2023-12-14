extends TextureButton


func _on_pressed():
	GameState.paused.emit(GameState.PAUSE_STATES.UNPAUSED)
	owner.owner.hide()
