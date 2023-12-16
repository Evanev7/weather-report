extends Node

@export var default_weather_resource: WeatherResource
var weather_can_change: bool = true
@export var summer_resource_group: UpgradeGroup
@export var autumn_resource_group: UpgradeGroup
@export var winter_resource_group: UpgradeGroup
@export var spring_resource_group: UpgradeGroup
@onready var weather_groups: Array[UpgradeGroup] = [summer_resource_group, autumn_resource_group, winter_resource_group, spring_resource_group]
var summer_resource: WeatherResource
var autumn_resource: WeatherResource
var winter_resource: WeatherResource
var spring_resource: WeatherResource

# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.weather = GameState.WEATHER.Summer

func reset_weather_resources():
	summer_resource = default_weather_resource.duplicate()
	autumn_resource = default_weather_resource.duplicate()
	winter_resource = default_weather_resource.duplicate()
	spring_resource = default_weather_resource.duplicate()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("change_weather"):
		try_change_weather()

func try_change_weather():
	if weather_can_change:
		GameState.weather = (GameState.weather + 1) % 4 as GameState.WEATHER
		weather_can_change = false
		$Timer.start()

func _on_timer_timeout():
	weather_can_change = true
 

func _on_season_upgrade_visibility_changed():
	for i in weather_groups.size():
		var resource_to_upgrade: WeatherResource
		match i:
			0:
				summer_resource = default_weather_resource.duplicate()
				resource_to_upgrade = summer_resource
			1:
				autumn_resource = default_weather_resource.duplicate()
				resource_to_upgrade = autumn_resource
			2:
				winter_resource = default_weather_resource.duplicate()
				resource_to_upgrade = winter_resource
			3:
				spring_resource = default_weather_resource.duplicate()
				resource_to_upgrade = spring_resource
		for j in weather_groups[i].active_resources.values().size():
			var script = weather_groups[i].active_resources.values()[j].upgrade_script.new()
			script.modify_plant_type(resource_to_upgrade)
	get_tree().call_group("plant", "reset_resource")
	get_tree().call_group("plant", "modify_weather")
