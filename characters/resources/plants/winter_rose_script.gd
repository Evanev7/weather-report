extends WeatherScript

func modify_summer(plant: Plant):
	plant.play("warm_sw")
	plant.firing_enabled = false

func modify_autumn(plant: Plant):
	plant.play("cold_sw")
	plant.firing_enabled = true
	plant.fire_rate /= 2
	plant.damage /= 2
	plant.shot_speed /= 2
	plant.piercing_amount -= 2
	
func modify_winter(plant: Plant):
	plant.play("cold_sw")
	plant.firing_enabled = true
	plant.fire_rate *= 2
	plant.damage *= 2
	plant.shot_speed *= 2
	plant.piercing_amount += 2
	
func modify_spring(plant: Plant):
	plant.play("warm_sw")
	plant.firing_enabled = false

