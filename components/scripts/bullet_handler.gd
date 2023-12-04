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
	bullet.speed = plant.shot_speed * 10
	add_child(bullet)
	
