extends Node
class_name EnemySpawner


@export var enemy_resource_list: Array[EnemyResource]
@export var enemy_scene: PackedScene
enum ENEMY_TYPE {Dog, Rat}

var current_batch: int
var wave_data: Array[EnemyWave]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func reset(level_wave_data):
	current_batch = 0
	wave_data = level_wave_data
	start_wave()

func start_wave():
	owner.update_wave_label_on_hud(current_batch)
	if current_batch < wave_data.size():
		spawn_enemies(wave_data[current_batch].waves)
	else:
		GameState.show_error("No more waves to spawn!")
	
func spawn_enemies(wave):
	for clump in wave:
		for j in range(clump.quantity):
			var new_enemy = enemy_scene.instantiate()
			new_enemy.set_enemy_as_resource(enemy_resource_list[clump.enemy])
			new_enemy.attack_greenhouse.connect(owner.damage_greenhouse)
			new_enemy.add_water_credits.connect(owner.add_water_credits)
			new_enemy.add_to_group("enemy")
			add_child(new_enemy)
			await get_tree().create_timer(clump.spawn_gap).timeout
		await get_tree().create_timer(clump.end_delay).timeout
	await get_tree().create_timer(2.0).timeout
	end_wave()
	
	
	
func end_wave():
	current_batch += 1
	owner.end_wave()
	
