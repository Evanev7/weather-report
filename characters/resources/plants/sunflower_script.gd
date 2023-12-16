extends WeatherScript

func modify_summer(plant: Plant):
	plant.damage *= (1.5 * GameState.weather_handler.summer_resource.damage_multiplier)
	plant.radius.scale *= GameState.weather_handler.summer_resource.range_multiplier
	plant.fire_rate *= (1.5 * GameState.weather_handler.summer_resource.fire_rate_multiplier)
	plant.wilting_rate *= 1.5

func modify_autumn(_plant: Plant):
	pass
	
func modify_winter(plant: Plant):
	plant.firing_enabled = false
	plant.wilting_rate /= 1.5
	
func modify_spring(plant: Plant):
	plant.firing_enabled = true

