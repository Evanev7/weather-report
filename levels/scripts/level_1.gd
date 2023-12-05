extends Node

signal update_hud_credits(credits)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_plant_handler_update_hud_credits(credits):
	update_hud_credits.emit(credits)
