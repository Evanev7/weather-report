extends PanelContainer

signal lock_shop

@onready var stat_screen = $VBoxContainer/StatScreen


func _on_display_resource(resource: WeatherUpgradeResource):
	stat_screen.stats_to_display = resource.displayed_stats
	%Name.text = resource.name
	%Cost.text = "Cost: "+var_to_str(resource.credit_value)
	%Icon.texture = resource.icon
	%Description.text = resource.description
