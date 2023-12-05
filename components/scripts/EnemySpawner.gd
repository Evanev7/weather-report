extends Node
class_name EnemySpawner

signal attack_greenhouse(damage)
signal add_credits(value)

@export var enemy_resource_list: Array[EnemyResource]
@export var enemy_scene: PackedScene
enum ENEMY_TYPE {Dog, Rat, Sog, Mog}

@onready var path: Path2D = $EnemyPath

var current_level: int
################ enemy type, gap between spawns, quantity, gap between next wave #############
var wave_data = [
	[EnemyClump.new(ENEMY_TYPE.Dog, 1, 1, 0.5), EnemyClump.new(ENEMY_TYPE.Rat, 0.3, 1, 0.5)],
	[EnemyClump.new(ENEMY_TYPE.Rat, 1, 10, 0.5), EnemyClump.new(ENEMY_TYPE.Dog, 0.3, 20, 0.5)]
	]


# Called when the node enters the scene tree for the first time.
func _ready():
	reset()
	start_wave()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func reset():
	current_level = 0

func start_wave():
	if current_level < wave_data.size():
		spawn_enemies(wave_data[current_level])
	else:
		print("no more waves")
	
func spawn_enemies(wave):
	for i in range(wave.size()):
		for j in range(wave[i].quantity):
			var new_enemy = enemy_scene.instantiate()
			new_enemy.set_enemy_as_resource(enemy_resource_list[wave[i].enemy])
			await get_tree().create_timer(wave[i].spawn_gap).timeout
			new_enemy.attack_greenhouse.connect(damage_greenhouse)
			new_enemy.add_water_credits.connect(add_water_credits)
			path.add_child(new_enemy)
		await get_tree().create_timer(wave[i].end_delay).timeout
	await get_tree().create_timer(2.0).timeout
	end_wave()
	
	
func damage_greenhouse(damage):
	attack_greenhouse.emit(damage)
	
	
func add_water_credits(value):
	add_credits.emit(value)
	
func end_wave():
	current_level += 1
	await get_tree().create_timer(4.0).timeout
	start_wave()
	
