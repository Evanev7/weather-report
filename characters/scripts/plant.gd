extends AnimatedSprite2D

@export var durability_bar: ProgressBar
@export var animation_player: AnimationPlayer
@export var range: CollisionShape2D
@export var fire_timer_max: float = 1000

var fire_timer: float
var fire_rate: float

var enemy_array = []
var can_fire: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_plant_as_resource(resource: PlantResource):
	sprite_frames = resource.ANIMATION
	durability_bar.max_value = resource.DURABILITY
	durability_bar.value = resource.DURABILITY
	range.shape.radius = resource.RANGE * 10
	fire_rate = resource.FIRE_RATE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	## Fire towards nearest enemy
	if fire_timer >= 0:
		#do we want to multiply this by delta?
		fire_timer -= fire_rate
	else:
		can_fire = true
	
	if enemy_array.size() != 0 and can_fire:
		var targeted_enemy = select_enemy()
		var direction = targeted_enemy.global_position - global_position
		GameState.fire_from.emit(position, direction)
		can_fire = false
		fire_timer = fire_timer_max
	
	
	## Health
	#do we want to multiply this by delta?
	durability_bar.value -= 0.1
	if durability_bar.value <= 0:
		animation_player.play("wilt")


func select_enemy() -> PathFollow2D:
	var enemy_progress_array = []
	#Should this be enemy_array? so it targets enemies in range?
	for enemy in get_tree().get_nodes_in_group("enemy"):
		enemy_progress_array.append(enemy.progress)
	var max_offset = enemy_progress_array.max()
	var enemy_index = enemy_progress_array.find(max_offset)
	var enemy = enemy_array[enemy_index]
	return enemy


func _on_area_2d_body_entered(body):
	enemy_array.append(body.get_parent())


func _on_area_2d_body_exited(body):
	enemy_array.remove_at(enemy_array.find(body.get_parent()))


func wilt():
	queue_free()



