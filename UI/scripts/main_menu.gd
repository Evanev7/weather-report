extends CanvasLayer

@export var world: Node

func _ready():
	if visible:
		world.autoplay(true)
		GameState.paused.emit(GameState.PAUSE_STATES.MAIN_MENU)

func _on_quit_button_pressed():
	get_tree().quit()
