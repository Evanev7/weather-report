extends Node
class_name Level

signal update_hud_credits(credits)

func _on_plant_handler_update_hud_credits(credits):
	update_hud_credits.emit(credits)
