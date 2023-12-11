extends WeatherScript

func modify_summer(plant: Plant):
	pass

func modify_autumn(plant: Plant):
	pass
	
func modify_winter(plant: Plant):
	plant.play("winter_se")
	plant.firing_enabled = false
	
func modify_spring(plant: Plant):
	plant.play("se")
	plant.firing_enabled = true

