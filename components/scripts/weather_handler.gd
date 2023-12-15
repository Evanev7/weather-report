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
	if Input.is_action_just_pressed("change_weather") and weather_can_change:
		GameState.weather = (GameState.weather + 1) % 4 as GameState.WEATHER
		weather_can_change = false
		$Timer.start()

func _on_timer_timeout():
	weather_can_change = true


#func upgrade_summer():
	#summer_resource.upgrade_level += 1
	#match summer_resource.upgrade_level:
		#1:
			#summer_resource.damage_multiplier = 1.5
		#2:
			#summer_resource.damage_multiplier = 2
			#
	#get_tree().call_group("plant", "reset_resource")
	#get_tree().call_group("plant", "modify_weather")


func _on_season_upgrade_visibility_changed():
	for group in weather_groups:
		for upgrade in group.active_resources.values():
			print(upgrade)
			var script = upgrade.upgrade_script.new()
			print(script)
			script.modify_plant_type(summer_resource)
			print(summer_resource.damage_multiplier)
