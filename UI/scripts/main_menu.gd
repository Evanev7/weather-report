extends CanvasLayer

@export var world: Node

func _ready():
	pass
	#if visible:
		#world.autoplay(true)
		#GameState.paused.emit(GameState.PAUSE_STATES.MAIN_MENU)
		
func set_level(level):
	visible = false
	world.set_level(level)

func _on_level_select_pressed():
	get_parent().get_node("LevelSelect").visible = true
	visible = false
	
func _on_quit_button_pressed():
	get_tree().quit()
