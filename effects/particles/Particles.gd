extends Node2D

@export var snow: GPUParticles2D
@export var leaves: GPUParticles2D

func _ready():
	GameState.weather_changed.connect(update_weather)

func update_weather(weather):
	match weather:
		GameState.WEATHER.Summer:
			stop_particles()
		GameState.WEATHER.Autumn:
			stop_particles()
			print(leaves)
			leaves.emitting = true
			for child in leaves.get_children():
				child.emitting = true
		GameState.WEATHER.Winter:
			stop_particles()
			snow.emitting = true
		GameState.WEATHER.Spring:
			stop_particles()
			
			
func stop_particles():
	snow.emitting = false
	leaves.emitting = false
	for child in leaves.get_children():
		child.emitting = false
