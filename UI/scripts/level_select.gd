extends CanvasLayer

signal set_level(level)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func go_to_level(level):
	SoundManager.select_button.play()
	visible = false
	set_level.emit(level)


func _on_quit_button_pressed():
	SoundManager.select_button.play()
	visible = false
	get_parent().get_node("MainMenu").visible = true
	get_parent().get_node("MainMenu/CenterContainer/VBoxContainer/OptionsMenu").visible = true
