extends Area2D
class_name Bullet

@export var sprite: AnimatedSprite2D
@export var collision: CollisionShape2D
@export var particles: GPUParticles2D

var type: PlantResource.BULLET_TYPE

var damage: float
var poison_damage: float = 0
var poison_duration: float = 0
var slow_amount: float = 0
var slow_duration: float = 0

var direction: Vector2 = Vector2(0, 0)
var speed: float
var angular_velocity: float
var max_lifetime: float
var piercing_amount: int
var piercing_cooldown: float
@onready var current_piercing_cooldown: float = piercing_cooldown
var lifetime: float

var hit_targets: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	if particles.process_material:
		particles.emitting = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	transport(delta)
	for area in get_overlapping_areas():
		if area.owner is Enemy:
			var target = area.owner
			check_for_hit(target)
			
	current_piercing_cooldown += 1

func transport(delta) -> void:
	position += direction * speed * delta
	if angular_velocity != 0:
		rotation += angular_velocity
	else:
		rotation = direction.angle()
	lifetime += delta
	if lifetime >= max_lifetime:
		remove()

func check_for_hit(target):
	if target in hit_targets:
		if current_piercing_cooldown >= piercing_cooldown:
			current_piercing_cooldown = 0
			hit(target)
		return
		
	hit_targets.append(target)
	hit(target)


func hit(target):
	target.hurt(damage, poison_damage, poison_duration, slow_amount, slow_duration)
	match type:
		PlantResource.BULLET_TYPE.Normal:
			piercing_amount -= 1
			if piercing_amount <= 0:
				remove()
		PlantResource.BULLET_TYPE.AOE:
			pass
	
func remove():
	queue_free()
