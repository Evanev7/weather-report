extends Node
class_name EnemySpawner

@export var enemy_resource_list: Array[EnemyResource]
@export var enemy_scene: PackedScene
enum ENEMY_TYPE {Dog, Blog, Sog, Mog}

@onready var path: Path2D = $EnemyPath

var current_wave: int
var wave_data = [EnemyClump.new(ENEMY_TYPE.Dog, 1, 10, 0.5), EnemyClump.new(ENEMY_TYPE.Dog, 0.1, 5, 0.5)]


# Called when the node enters the scene tree for the first time.
func _ready():
	reset()
	start_wave()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func reset():
	current_wave = -1

func start_wave():
	current_wave += 1
	spawn_enemies(wave_data)
	
func spawn_enemies(wave):
	for i in range(wave[current_wave].quantity):
		var new_enemy = enemy_scene.instantiate()
		new_enemy.set_enemy_as_resource(enemy_resource_list[wave[current_wave].enemy])
		await get_tree().create_timer(wave[current_wave].spawn_gap).timeout
		path.add_child(new_enemy)
	await get_tree().create_timer(wave[current_wave].end_delay).timeout
	end_wave()
	
func end_wave():
	print("ended")
	
