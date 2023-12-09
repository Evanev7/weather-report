extends CanvasLayer

signal next_wave()

@export var error_scene: PackedScene

@onready var error_location: Marker2D = $ErrorSpawner

@export var credits_label: RichTextLabel
@export var waves_label: RichTextLabel
@export var next_wave_button: TextureButton
@export var grid_container: GridContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.spawn_error.connect(show_error)
	
func show_error(error_msg):
	var new_error = error_scene.instantiate()
	error_location.add_child(new_error)
	new_error.set_text_and_animate(error_msg, error_location.global_position)
	
func _on_level_1_update_hud_credits(credits):
	credits_label.text = str(credits)

func set_thumbnails(plant_list):
	for i in range(plant_list.size()):
		grid_container.get_child(i).thumbnail = plant_list[i].ICON

func update_wave_label(wave):
	waves_label.text = "[center][wave]Wave " + str(wave + 1) + "[/wave][/center]"
	
func end_wave():
	next_wave_button.disabled = false
	
func start_wave():
	next_wave.emit()
	next_wave_button.disabled = true
