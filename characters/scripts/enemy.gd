extends PathFollow2D
class_name Enemy

signal removed()
signal attack_greenhouse(damage: float)
signal add_water_credits(value: int)

@export var sprite: AnimatedSprite2D
@export var collision: CollisionShape2D
@export var hp_bar: ProgressBar
@export var bounce_anim: AnimationPlayer
@export var hurt_anim: AnimationPlayer
@export var dead_anim: AnimationPlayer
@export var poison_timer: Timer
@export var slow_timer: Timer

@onready var path = get_parent()

var health: float
var default_speed: float
var speed: float
var value: float
var move_direction = 0

var damage: float
var poisoned: bool = false
var poison_damage: float = 0
var poison_time: float = 0

var poison_tween: Tween

var dead: bool = false

func _ready():
	pass
	
func set_enemy_as_resource(resource: EnemyResource):
	dead_anim.play("spawn")
	health = resource.MAX_HP
	hp_bar.max_value = health
	hp_bar.value = health
	default_speed = resource.SPEED
	speed = default_speed
	damage = resource.DAMAGE
	value = resource.VALUE
	sprite.sprite_frames = resource.ANIMATION
	sprite.flip_h = resource.FLIP_H
	collision.shape.radius = resource.HITBOX_RADIUS
	
func _physics_process(delta):
	var prepos = global_position
	move(delta)
	var pos = global_position
	move_direction = (pos.angle_to_point(prepos) / PI) * 180
	
	if poisoned == true:
		poison_time += delta
		if poison_time > 0.5:
			poison(poison_damage)
			poison_time -= 0.5
	
func _process(_delta):
	animate()
	
func animate():
	var animation_direction = "sw"
	if move_direction <= -90 and move_direction >= -180:
		animation_direction = "sw"
		sprite.flip_h = true
	if move_direction <= -0 and move_direction >= -90:
		animation_direction = "sw"
		sprite.flip_h = false
	if move_direction <= 90 and move_direction >= 0:
		animation_direction = "nw"
		sprite.flip_h = false
	if move_direction <= 180 and move_direction >= 90:
		animation_direction = "nw"
		sprite.flip_h = true
		
	sprite.animation = animation_direction
	
func move(delta):
	set_progress(progress + speed * delta)
	if progress_ratio >= 1.0:
		attack_greenhouse.emit(damage)
		remove()
		
		
func hurt(damage_taken, _poison_damage: float = 0, poison_duration: float = 0, slow_amount: float = 0, slow_duration: float = 0):
	if not dead:
		health -= damage_taken
		update_health()
		hurt_anim.stop()
		hurt_anim.play("hurt")
		
		if _poison_damage:
			poison_damage = _poison_damage
			poisoned = true
			poison_timer.start(poison_duration)
		
		if slow_amount:
			speed = default_speed/slow_amount
			slow_timer.start(slow_duration)
	
func poison(damage_taken):
	hurt(damage_taken)
	poison_tween = create_tween()
	poison_tween.tween_property(sprite, "modulate", Color(1, 1, 1), 0.3).from(Color(0, 1, 0))
	
func _on_poison_timer_timeout():
	poisoned = false
	
func _on_slow_timer_timeout():
	speed = default_speed
	
func update_health():
	hp_bar.value = health
	if health <= 0 and not dead:
		dead = true
		hurt_anim.stop()
		bounce_anim.stop()
		dead_anim.play("dead")
		set_physics_process(false)
		set_process(false)
		add_water_credits.emit(value)
		
		
func remove():
	remove_from_group("enemy")
	removed.emit()
	queue_free()






