extends Node2D

@export var hp_bar: ProgressBar
@export var HP_MAX: float = 100

@onready var health: float = HP_MAX


# Called when the node enters the scene tree for the first time.
func _ready():
	hp_bar.max_value = HP_MAX
	hp_bar.value = health


func take_damage(damage):
	health -= damage
	hp_bar.value = health
	if health <= 0:
		game_over()
		
func game_over():
	print("ded")
