extends WeatherScript

func modify_summer(plant: Plant):
	plant.damage *= 1.5
	plant.fire_rate *= 1.5
	plant.wilting_rate *= 1.5

func modify_autumn(plant: Plant):
	plant.damage /= 1.5
	plant.fire_rate /= 1.5
	plant.wilting_rate /= 1.5
	
func modify_winter(plant: Plant):
	plant.firing_enabled = false
	plant.wilting_rate /= 1.5
	
func modify_spring(plant: Plant):
	plant.firing_enabled = true
	plant.wilting_rate *= 1.5

