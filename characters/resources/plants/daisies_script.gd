extends WeatherScript

func modify_summer(_plant: Plant):
	pass

func modify_autumn(plant: Plant):
	plant.damage /= 1.5
	plant.lifetime /= 1.5
	plant.bullet_particle_lifetime /= 1.5
	
func modify_winter(plant: Plant):
	plant.play("winter_se")
	plant.firing_enabled = false
	
func modify_spring(plant: Plant):
	plant.play("se")
	plant.firing_enabled = true
	plant.fire_rate *= GameState.weather_handler.spring_resource.fire_rate_multiplier
	plant.damage *= (1.5 * GameState.weather_handler.spring_resource.damage_multiplier)
	plant.radius.scale *= (1.5 * GameState.weather_handler.spring_resource.range_multiplier)
	plant.lifetime *= (1.5 * GameState.weather_handler.spring_resource.lifetime_multiplier)
	plant.bullet_particle_lifetime *= (1.5 * GameState.weather_handler.spring_resource.lifetime_multiplier)

