extends Node

@export var bullet_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.fire_from.connect(fire_from)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func fire_from(plant, direction):
	var bullet = bullet_scene.instantiate()
	
	bullet.damage = plant.damage
	bullet.poison_damage = plant.poison_damage
	bullet.poison_duration = plant.poison_duration
	bullet.slow_amount = plant.slow_amount
	bullet.slow_duration = plant.slow_duration

	bullet.direction = direction.normalized()
	bullet.flying = plant.flying
	bullet.global_position = plant.position + bullet.direction * plant.starting_distance
	bullet.collision.shape.radius = plant.bullet_collision_radius
	bullet.sprite.sprite_frames = plant.bullet_animation
	bullet.particles.process_material = plant.bullet_particles
	bullet.particles.lifetime = plant.bullet_particle_lifetime
	bullet.particles.texture = plant.bullet_particle_texture
	bullet.type = plant.bullet_type
	bullet.speed = plant.shot_speed * 10
	if bullet.direction.x < 0:
		bullet.angular_velocity = (plant.angular_velocity * -1) / 100
	else:
		bullet.angular_velocity = plant.angular_velocity / 100
	bullet.piercing_amount = plant.piercing_amount
	bullet.piercing_cooldown = plant.piercing_cooldown
	bullet.max_lifetime = plant.lifetime
	bullet.scale = plant.shot_size
	bullet.add_to_group("bullet")
	add_child(bullet)
	
