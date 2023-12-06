extends AnimatedSprite2D
class_name Plant

signal remove_from_node_array(plant)

@export var durability_bar: ProgressBar
@export var animation_player: AnimationPlayer
@export var radius: CollisionShape2D
@export var fire_timer_max: float = 1000

## Bullet Stats
var fire_timer: float
var fire_rate: float
var wilting_rate: float = 1
var shot_speed: float
var damage: float
var bullet_animation: SpriteFrames
var bullet_type: PlantResource.BULLET_TYPE
var shot_size: Vector2
var lifetime: float
var piercing_amount: int
var piercing_cooldown: float
##

var enemy_array = []
var weather: GameState.WEATHER
var weather_script
var firing_enabled: bool = true
var can_fire: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_plant_as_resource(resource: PlantResource):
	weather_script = resource.WEATHER_SCRIPT.new()
	add_child(weather_script)
	set_weather()
	
	sprite_frames = resource.ANIMATION
	bullet_animation = resource.BULLET_ANIMATION
	bullet_type = resource.TYPE
	durability_bar.max_value = resource.DURABILITY
	durability_bar.value = resource.DURABILITY
	radius.shape.radius = resource.RANGE * 10
	fire_rate = resource.FIRE_RATE
	shot_speed = resource.SHOT_SPEED
	damage = resource.DAMAGE
	shot_size = resource.SIZE
	lifetime = resource.BULLET_LIFETIME
	piercing_amount = resource.PIERCING_AMOUNT
	piercing_cooldown = resource.PIERCING_COOLDOWN
	
func set_weather():
	weather = GameState.weather
	match weather:
		GameState.WEATHER.Summer:
			weather_script.modify_summer(self)
		GameState.WEATHER.Autumn:
			weather_script.modify_autumn(self)
		GameState.WEATHER.Winter:
			weather_script.modify_winter(self)
		GameState.WEATHER.Spring:
			weather_script.modify_spring(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	## Fire towards nearest enemy
	if fire_timer >= 0:
		#do we want to multiply this by delta?
		fire_timer -= fire_rate
	else:
		can_fire = true
		
	if enemy_array.size() != 0 and can_fire and firing_enabled:
		fire_bullet()
	
	
	## Health
	#do we want to multiply this by delta?
	# why?
	durability_bar.value -= 0.1 * wilting_rate
	if durability_bar.value <= 0:
		firing_enabled = false
		animation_player.play("wilt")

func fire_bullet():
	var targeted_enemy = select_enemy()
	var direction = targeted_enemy.global_position - global_position
	GameState.fire_from.emit(self, direction)
	can_fire = false
	fire_timer = fire_timer_max
	
	play("shooting_se")
	await get_tree().create_timer(10/fire_rate).timeout
	play("se")

func select_enemy() -> PathFollow2D:
	var enemy_progress_array = []
	#Should this be enemy_array? so it targets enemies in range?
	for enemy in enemy_array:
		enemy_progress_array.append(enemy.progress)
		enemy.removed.connect(func():
			enemy_progress_array.erase(enemy.progress))
	var max_offset = enemy_progress_array.max()
	var enemy_index = enemy_progress_array.find(max_offset)
	var enemy = enemy_array[enemy_index]
	if enemy:
		return enemy
	else:
		return null


func _on_range_area_entered(area):
	if area.get_parent() is Enemy:
		enemy_array.append(area.get_parent())
		var enemy = area.get_parent()
		enemy.removed.connect(func():
			enemy_array.erase(area.get_parent()))


func _on_range_area_exited(area):
	if area.get_parent() is Enemy:
		enemy_array.erase(area.get_parent())


func wilt():
	remove_from_node_array.emit(self)
	remove_from_group("plant")
	queue_free()



