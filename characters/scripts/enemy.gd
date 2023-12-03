extends PathFollow2D

@export var sprite: AnimatedSprite2D
@export var collision: CollisionShape2D

var speed: float

func _ready():
	pass # Replace with function body.
	
func set_enemy_as_resource(resource: EnemyResource):
	speed = resource.SPEED
	sprite.sprite_frames = resource.ANIMATION
	sprite.flip_h = resource.FLIP_H
	sprite.flip_v = true
	collision.shape.radius = resource.HITBOX_RADIUS
	
func _physics_process(delta):
	move(delta)
	
func move(delta):
	set_progress(get_progress() + speed * delta)
