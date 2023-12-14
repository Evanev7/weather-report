extends WeatherScript

func modify_summer(plant: Plant):
	plant.damage *= GameState.weather_handler.summer_resource.damage_multiplier
	plant.poison_damage *= GameState.weather_handler.summer_resource.damage_multiplier
	plant.poison_duration *= GameState.weather_handler.summer_resource.poison_duration_multiplier

func modify_autumn(plant: Plant):
	plant.damage *= GameState.weather_handler.autumn_resource.damage_multiplier
	plant.poison_damage *= GameState.weather_handler.autumn_resource.damage_multiplier
	plant.poison_duration *= GameState.weather_handler.autumn_resource.poison_duration_multiplier
	
func modify_winter(plant: Plant):
	plant.damage *= GameState.weather_handler.winter_resource.damage_multiplier
	plant.poison_damage *= GameState.weather_handler.winter_resource.damage_multiplier
	plant.poison_duration *= GameState.weather_handler.winter_resource.poison_duration_multiplier
	
func modify_spring(plant: Plant):
	plant.damage *= GameState.weather_handler.spring_resource.damage_multiplier
	plant.poison_damage *= GameState.weather_handler.spring_resource.damage_multiplier
	plant.poison_duration *= GameState.weather_handler.spring_resource.poison_duration_multiplier

