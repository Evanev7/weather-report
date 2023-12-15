extends WeatherUpgrade

func modify_plant_type(weather_resource, _plant = null):
	weather_resource.damage_multiplier *= 1.5
