extends AnimatedSprite2D
class_name Plant

signal remove_from_node_array(plant)

@export var durability_bar: ProgressBar
@export var animation_player: AnimationPlayer
@export var radius: CollisionPolygon2D
@export var fire_timer_max: float = 1000

var icon: CompressedTexture2D

var default_resource: PlantResource
var personal_weather: GameState.WEATHER

## Bullet Stats
var starting_distance: float
var bullet_collision_radius: float
var bullet_particles: ParticleProcessMaterial
var bullet_particle_lifetime: float
var bullet_particle_texture
var flying: bool
var fire_timer: float
var fire_rate: float
var wilting_rate: float = 1
var shot_speed: float
var angular_velocity: float
var damage: float
var poison_damage: float
var poison_duration: float
var slow_amount: float
var slow_duration: float
var bullet_animation: SpriteFrames
var bullet_type: PlantResource.BULLET_TYPE
var shot_size: Vector2
var lifetime: float
var piercing_amount: int
var piercing_cooldown: float
##

var enemy_array = []
var weather_script
var firing_enabled: bool = true
var wilting_enabled: bool = true
var can_fire: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.weather_changed.connect(set_weather)

func set_plant_as_resource(_resource: PlantResource):
	weather_script = _resource.WEATHER_SCRIPT.new()
	add_child(weather_script)
	
	default_resource = _resource
	reset_resource(default_resource)
	
	personal_weather = -1
	set_weather(GameState.weather)
	
func set_weather(weather):
	reset_resource(default_resource)
	while (personal_weather % 4) != weather:
		personal_weather += 1
		modify_weather(personal_weather)

func modify_weather(_weather = GameState.weather):
	match (_weather % 4):
		GameState.WEATHER.Summer:
			weather_script.modify_summer(self)
		GameState.WEATHER.Autumn:
			weather_script.modify_autumn(self)
		GameState.WEATHER.Winter:
			weather_script.modify_winter(self)
		GameState.WEATHER.Spring:
			weather_script.modify_spring(self)

func reset_resource(resource = default_resource):
	sprite_frames = resource.ANIMATION
	flip_h = resource.FLIP_H
	icon = resource.ICON
	durability_bar.max_value = resource.DURABILITY
	durability_bar.value = resource.DURABILITY
	radius.scale *= resource.RANGE
	radius.position.y += (1 / (resource.RANGE ** 8))
	
	starting_distance = resource.STARTING_DISTANCE
	bullet_collision_radius = resource.COLLISION_RADIUS
	bullet_animation = resource.BULLET_ANIMATION
	bullet_particles = resource.BULLET_PARTICLES
	bullet_particle_lifetime = resource.BULLET_PARTICLE_LIFETIME
	bullet_particle_texture = resource.BULLET_PARTICLE_TEXTURE
	bullet_type = resource.TYPE
	flying = resource.FLYING
	fire_rate = resource.FIRE_RATE
	shot_speed = resource.SHOT_SPEED
	angular_velocity = resource.ANGULAR_VELOCITY
	damage = resource.DAMAGE
	poison_damage = resource.POISON_DAMAGE
	poison_duration = resource.POISON_DURATION
	slow_amount = resource.SLOW_AMOUNT
	slow_duration = resource.SLOW_DURATION
	shot_size = resource.SIZE
	lifetime = resource.BULLET_LIFETIME
	piercing_amount = resource.PIERCING_AMOUNT
	piercing_cooldown = resource.PIERCING_COOLDOWN

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
	
	if get_tree().get_nodes_in_group("enemy").size() == 0:
		wilting_enabled = false
	else:
		wilting_enabled = true
	
	## Health
	#do we want to multiply this by delta?
	# why?
	if wilting_enabled:
		durability_bar.value -= 0.05 * wilting_rate
		
	if durability_bar.value <= 0:
		firing_enabled = false
		animation_player.play("wilt")

func fire_bullet():
	var targeted_enemy = select_enemy()
	var direction = targeted_enemy.global_position - global_position
	if not targeted_enemy.flying or (targeted_enemy.flying and flying):
		GameState.fire_from.emit(self, direction)
		can_fire = false
		fire_timer = fire_timer_max
		
		if sprite_frames.has_animation("shooting_se"):
			play("shooting_se")
		await get_tree().create_timer(10/fire_rate).timeout
		if sprite_frames.has_animation("se"):
			play("se")

func select_enemy() -> Enemy:
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



