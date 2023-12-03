extends Resource
class_name EnemyClump

@export var enemy: EnemySpawner.ENEMY_TYPE
@export var spawn_gap: float
@export var quantity: int
@export var end_delay: float

func _init(type, gap, number, delay):
	enemy = type
	spawn_gap = gap
	quantity = number
	end_delay = delay

