extends WeatherScript

func modify_summer(plant: Plant):
	plant.damage *= GameState.weather_handler.summer_resource.damage_multiplier
	plant.radius.scale *= GameState.weather_handler.summer_resource.range_multiplier
	plant.flying = GameState.weather_handler.autumn_resource.is_flying
	plant.fire_rate *= GameState.weather_handler.summer_resource.fire_rate_multiplier
	plant.poison_damage *= GameState.weather_handler.summer_resource.damage_multiplier
	plant.poison_duration *= GameState.weather_handler.summer_resource.duration_multiplier

func modify_autumn(plant: Plant):
	plant.damage *= GameState.weather_handler.autumn_resource.damage_multiplier
	plant.radius.scale *= GameState.weather_handler.autumn_resource.range_multiplier
	plant.fire_rate *= GameState.weather_handler.autumn_resource.fire_rate_multiplier
	plant.flying = GameState.weather_handler.autumn_resource.is_flying
	plant.poison_damage *= GameState.weather_handler.autumn_resource.damage_multiplier
	plant.poison_duration *= GameState.weather_handler.autumn_resource.duration_multiplier
	
func modify_winter(plant: Plant):
	plant.damage *= GameState.weather_handler.winter_resource.damage_multiplier
	plant.radius.scale *= GameState.weather_handler.winter_resource.range_multiplier
	plant.fire_rate *= GameState.weather_handler.winter_resource.fire_rate_multiplier
	plant.flying = GameState.weather_handler.autumn_resource.is_flying
	plant.poison_damage *= GameState.weather_handler.winter_resource.damage_multiplier
	plant.poison_duration *= GameState.weather_handler.winter_resource.duration_multiplier
	
func modify_spring(plant: Plant):
	plant.damage *= GameState.weather_handler.spring_resource.damage_multiplier
	plant.radius.scale *= GameState.weather_handler.spring_resource.range_multiplier
	plant.fire_rate *= GameState.weather_handler.spring_resource.fire_rate_multiplier
	plant.flying = GameState.weather_handler.autumn_resource.is_flying
	plant.poison_damage *= GameState.weather_handler.spring_resource.damage_multiplier
	plant.poison_duration *= GameState.weather_handler.spring_resource.duration_multiplier

