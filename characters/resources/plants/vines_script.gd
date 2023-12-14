extends WeatherScript

func modify_summer(_plant: Plant):
	pass

func modify_autumn(_plant: Plant):
	pass
	
func modify_winter(plant: Plant):
	plant.play("winter_se")
	plant.firing_enabled = false
	
func modify_spring(plant: Plant):
	plant.play("se")
	plant.firing_enabled = true
	plant.damage *= (1.5 * GameState.weather_handler.spring_resource.damage_multiplier)
	plant.slow_duration *= (1.5 * GameState.weather_handler.spring_resource.duration_multiplier)

