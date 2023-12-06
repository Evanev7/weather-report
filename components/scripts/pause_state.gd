extends Node
class_name PauseState

func _ready():
	GameState.register_pause_state.emit(self)

func enter():
	pass

func exit():
	pass
