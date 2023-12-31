extends Node2D

@export var snow: GPUParticles2D
@export var leaves: GPUParticles2D
@export var pollen: GPUParticles2D

func _ready():
	GameState.weather_changed.connect(update_weather)

func update_weather(weather):
	match weather:
		GameState.WEATHER.Summer:
			if not SoundManager.summer_ambience.playing:
				SoundManager.summer_ambience.play()
			stop_particles()
		GameState.WEATHER.Autumn:
			SoundManager.fade_out(SoundManager.summer_ambience)
			SoundManager.autumn_ambience.play()
			stop_particles()
			leaves.emitting = true
			for child in leaves.get_children():
				child.emitting = true
		GameState.WEATHER.Winter:
			SoundManager.fade_out(SoundManager.autumn_ambience)
			SoundManager.winter_ambience.play()
			stop_particles()
			snow.emitting = true
		GameState.WEATHER.Spring:
			SoundManager.fade_out(SoundManager.winter_ambience)
			SoundManager.summer_ambience.play()
			stop_particles()
			pollen.emitting = true
			
			
func stop_particles():
	snow.emitting = false
	pollen.emitting = false
	leaves.emitting = false
	for child in leaves.get_children():
		child.emitting = false
