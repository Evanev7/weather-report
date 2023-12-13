extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func upgrade_summer():
	print("upgrades summer")


func back_button_pressed():
	GameState.paused.emit(GameState.PAUSE_STATES.UNPAUSED)
	hide()
