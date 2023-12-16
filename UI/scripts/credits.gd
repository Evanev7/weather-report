extends CanvasLayer


func _on_texture_button_pressed():
	SoundManager.select_button.play()
	hide()
