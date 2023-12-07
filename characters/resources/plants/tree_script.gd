extends WeatherScript

func modify_summer(plant: Plant):
	plant.play("tree_warm_SE")
	plant.bullet_animation.set_animation_loop("branch", false)
	plant.damage = 1.5
	plant.shot_speed = 3
	plant.angular_velocity = 3
	plant.fire_rate = 5
	plant.lifetime = 5
	plant.shot_size = Vector2(2, 2)
	plant.piercing_amount = 10
	plant.piercing_cooldown = 100

func modify_autumn(plant: Plant):
	plant.play("tree_autumn_SE")
	plant.bullet_animation.set_animation_loop("leaves", false)
	plant.damage = 0.5
	plant.shot_speed = 200
	plant.fire_rate = 50
	plant.lifetime = 1
	plant.shot_size = Vector2(1, 1)
	plant.piercing_amount = 1
	plant.piercing_cooldown = 0
	
func modify_winter(plant: Plant):
	plant.play("tree_winter_SE")
	plant.firing_enabled = false
	
func modify_spring(plant: Plant):
	plant.play("tree_warm_SE")
	plant.bullet_animation.set_animation_loop("branch", false)
	plant.firing_enabled = true
	plant.damage = 1.5
	plant.shot_speed = 3
	plant.angular_velocity = 3
	plant.fire_rate = 5
	plant.lifetime = 5
	plant.shot_size = Vector2(2, 2)
	plant.piercing_amount = 10
	plant.piercing_cooldown = 100

