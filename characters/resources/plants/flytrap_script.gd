extends WeatherScript

func modify_summer(plant: Plant):
	plant.play("se")
	plant.damage *= GameState.weather_handler.summer_resource.damage_multiplier
	plant.shot_size *= (2 * GameState.weather_handler.summer_resource.size_multiplier)
	pass

func modify_autumn(plant: Plant):
	plant.play("se")
	pass
	
func modify_winter(plant: Plant):
	plant.play("winter_se")
	plant.firing_enabled = false
	
func modify_spring(plant: Plant):
	plant.play("se")
	plant.firing_enabled = true

