extends PanelContainer

signal lock_shop

@onready var stat_screen = $VBoxContainer/StatScreen


func _on_display_resource(resource: WeatherUpgradeResource, weather: String, value: int):
	stat_screen.stats_to_display = resource.displayed_stats
	%Name.text = resource.name
	%Cost.text = "Cost: "+var_to_str(value)
	%Icon.texture = resource.icon
	var formatted_text = resource.description % weather
	%Description.text = formatted_text
