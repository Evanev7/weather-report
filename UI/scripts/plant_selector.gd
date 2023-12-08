extends CanvasLayer

signal next_wave()

@export var credits_label: RichTextLabel
@export var waves_label: RichTextLabel
@export var next_wave_button: TextureButton
@export var grid_container: GridContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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
