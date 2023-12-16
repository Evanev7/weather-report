extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_texture_button_2_pressed():
	hide()


func _on_texture_button_3_pressed():
	show_tutorial()
	Stats.player_data.tutorial_shown = true
	$Panel/Control.hide()
	GameState.paused.emit(GameState.PAUSE_STATES.TUTORIAL_SHOWN)

func show_tutorial():
	$Panel/Control2.show()


func _on_texture_button_pressed():
	hide()
	GameState.paused.emit(GameState.PAUSE_STATES.UNPAUSED)
