extends WeatherScript

func modify_summer(plant: Plant):
	plant.shot_size /= 1.5
	plant.damage /= 1.5
	plant.lifetime /= 1.5

func modify_autumn(plant: Plant):
	plant.shot_size /= 1.5
	plant.damage /= 1.5
	plant.lifetime /= 1.5
	
func modify_winter(plant: Plant):
	plant.firing_enabled = false
	
func modify_spring(plant: Plant):
	plant.firing_enabled = true
	plant.shot_size *= 1.5
	plant.damage *= 1.5
	plant.lifetime *= 1.5

