extends TextureButton


func _on_pressed():
	SoundManager.select_button.play()
	GameState.paused.emit(GameState.PAUSE_STATES.UNPAUSED)
	owner.owner.hide()
	owner.lock_shop.emit()
