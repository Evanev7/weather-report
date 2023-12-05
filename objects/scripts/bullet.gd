extends Area2D
class_name Bullet

@export var sprite: AnimatedSprite2D

var type: PlantResource.BULLET_TYPE
var damage: float
var direction: Vector2 = Vector2(0, 0)
var speed: float
var max_lifetime: float
var piercing_amount: int
var piercing_cooldown: float
@onready var current_piercing_cooldown: float = piercing_cooldown
var lifetime: float

var hit_targets: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	transport(delta)
	current_piercing_cooldown += 1

func transport(delta) -> void:
	position += direction * speed * delta
	rotation = direction.angle()
	lifetime += delta
	if lifetime >= max_lifetime:
		remove()

func check_hit(target):
	if target in hit_targets:
		if current_piercing_cooldown >= piercing_cooldown:
			target.hurt(damage)
			current_piercing_cooldown = 0
		return
		
	hit_targets.append(target)
	target.hurt(damage)
	match type:
		PlantResource.BULLET_TYPE.Normal:
			piercing_amount -= 1
			if piercing_amount <= 0:
				remove()
		PlantResource.BULLET_TYPE.AOE:
			pass
	
func remove():
	queue_free()
