extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func upgrade_summer():
	GameState.weather_handler.upgrade_summer()


func back_button_pressed():
	GameState.paused.emit(GameState.PAUSE_STATES.UNPAUSED)
	hide()
