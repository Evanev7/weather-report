extends WeatherScript

var leaf: Texture2D = preload("res://objects/assets/particles/orange_leaf.png")
var branch: Texture2D = preload("res://objects/assets/bullets/branch.png")

func modify_summer(plant: Plant):
	plant.play("warm_SE")
	plant.bullet_animation.set_frame("leaves", 0, branch)
	plant.bullet_collision_radius = 35
	plant.starting_distance = 50
	plant.damage = 1.5
	plant.shot_speed = 0
	plant.angular_velocity = 1
	plant.fire_rate = 5
	plant.lifetime = 3
	plant.shot_size = Vector2(2, 2)
	plant.piercing_amount = 10
	plant.piercing_cooldown = 100

func modify_autumn(plant: Plant):
	plant.play("autumn_SE")
	plant.bullet_animation.set_frame("leaves", 0, leaf)
	plant.starting_distance = 0
	plant.bullet_collision_radius = 20
	plant.damage = 0.5
	plant.shot_speed = 200
	plant.fire_rate = 50
	plant.lifetime = 1
	plant.shot_size = Vector2(1, 1)
	plant.piercing_amount = 1
	plant.piercing_cooldown = 0
	
func modify_winter(plant: Plant):
	plant.play("winter_SE")
	plant.firing_enabled = false
	
func modify_spring(plant: Plant):
	plant.play("warm_SE")
	plant.bullet_animation.set_frame("leaves", 0, branch)
	plant.bullet_collision_radius = 35
	plant.starting_distance = 50
	plant.firing_enabled = true
	plant.damage = 1.5
	plant.shot_speed = 0
	plant.angular_velocity = 1
	plant.fire_rate = 5
	plant.lifetime = 3
	plant.shot_size = Vector2(2, 2)
	plant.piercing_amount = 10
	plant.piercing_cooldown = 100

