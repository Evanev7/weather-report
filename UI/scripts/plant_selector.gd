extends CanvasLayer

@export var credits_label: RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_level_1_update_hud_credits(credits):
	credits_label.text = str(credits)
