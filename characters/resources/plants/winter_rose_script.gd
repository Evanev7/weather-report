extends WeatherScript

func modify_summer(plant: Plant):
	plant.play("warm_sw")
	plant.firing_enabled = false

func modify_autumn(plant: Plant):
	plant.play("cold_sw")
	plant.firing_enabled = true
	
func modify_winter(plant: Plant):
	plant.play("cold_sw")
	plant.firing_enabled = true
	plant.fire_rate *= (2 * GameState.weather_handler.winter_resource.fire_rate_multiplier)
	plant.damage *= (2 * GameState.weather_handler.winter_resource.damage_multiplier)
	plant.radius.scale *= GameState.weather_handler.winter_resource.range_multiplier
	plant.shot_speed *= 2
	plant.piercing_amount += 2
	
func modify_spring(plant: Plant):
	plant.play("warm_sw")
	plant.firing_enabled = false

