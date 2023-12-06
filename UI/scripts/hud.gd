extends CanvasLayer

@export var credits_label: RichTextLabel
@export var weather_label: RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_credits(credits):
	credits_label.text = str(credits)
	
func update_weather(weather):
	var text = "[right][wave]" + GameState.WEATHER.keys()[weather] + "[/wave][/right]"
	weather_label.text = text


