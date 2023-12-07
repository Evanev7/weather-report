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
	bullet.global_position = plant.position
	bullet.damage = plant.damage
	bullet.direction = direction.normalized()
	bullet.sprite.sprite_frames = plant.bullet_animation
	bullet.type = plant.bullet_type
	bullet.speed = plant.shot_speed * 10
	bullet.angular_velocity = plant.angular_velocity / 100
	bullet.piercing_amount = plant.piercing_amount
	bullet.piercing_cooldown = plant.piercing_cooldown
	bullet.max_lifetime = plant.lifetime
	bullet.scale = plant.shot_size
	add_child(bullet)
	
