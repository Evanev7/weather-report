extends CanvasLayer

@export var world: Node

func _ready():
	pass
		
func set_level(level):
	visible = false
	world.set_level(level)
	GameState.paused.emit(GameState.PAUSE_STATES.UNPAUSED)

func _on_level_select_pressed():
	SoundManager.select_button.play()
	get_parent().get_node("LevelSelect").visible = true
	visible = false
	
func _on_quit_button_pressed():
	get_tree().quit()
