extends WeatherScript

func modify_summer(plant: Plant):
	plant.damage /= 1.5
	plant.lifetime /= 1.5
	plant.bullet_particle_lifetime /= 1.5

func modify_autumn(plant: Plant):
	plant.damage /= 1.5
	plant.lifetime /= 1.5
	plant.bullet_particle_lifetime /= 1.5
	
func modify_winter(plant: Plant):
	plant.firing_enabled = false
	
func modify_spring(plant: Plant):
	plant.firing_enabled = true
	plant.damage *= 1.5
	plant.lifetime *= 1.5
	plant.bullet_particle_lifetime *= 1.5

