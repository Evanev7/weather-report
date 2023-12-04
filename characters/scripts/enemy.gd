extends PathFollow2D
class_name Enemy

signal removed()
signal attack_greenhouse(damage)

@export var sprite: AnimatedSprite2D
@export var collision: CollisionShape2D
@export var hp_bar: ProgressBar
@export var animation_player: AnimationPlayer

@onready var path = get_parent()

var health: float
var speed: float
var damage: float
var move_direction = 0

func _ready():
	pass
	
func set_enemy_as_resource(resource: EnemyResource):
	animation_player.play("RESET")
	health = resource.MAX_HP
	hp_bar.max_value = health
	hp_bar.value = health
	speed = resource.SPEED
	damage = resource.DAMAGE
	sprite.sprite_frames = resource.ANIMATION
	sprite.flip_h = resource.FLIP_H
	collision.shape.radius = resource.HITBOX_RADIUS
	add_to_group("enemy")
	
func _physics_process(delta):
	var prepos = global_position
	move(delta)
	var pos = global_position
	move_direction = (pos.angle_to_point(prepos) / PI) * 180
	
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
		
func remove():
	remove_from_group("enemy")
	removed.emit()
	queue_free()


func _on_area_2d_area_entered(area):
	if area is Bullet:
		health -= area.damage
		animation_player.play("hurt")
		area.hit_success()
		update_health()
		
func update_health():
	hp_bar.value = health
	if health <= 0:
		remove()
