extends MarginContainer

var stats_to_display: Dictionary = {"hi": "ho", "let's": "go"}:
	set(val):
		stats_to_display = val
		refresh_labels()

@export var label_scene: PackedScene

func _ready():
	refresh_labels()

func refresh_labels():
	var num_needed_label_pairs = stats_to_display.size()
	while $VBoxContainer.get_child_count()/2.0 < num_needed_label_pairs:
		var label_pair: Array[Label] = [label_scene.instantiate(), label_scene.instantiate()]
		label_pair[1].horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		$VBoxContainer.add_child(label_pair[0])
		$VBoxContainer.add_child(label_pair[1])
	var active_labels = $VBoxContainer.get_children()
	for label_index in range(active_labels.size()):
		var label: Label = active_labels[label_index]
		if label_index < num_needed_label_pairs * 2:
			label.visible = true
		else:
			label.visible = false
	for label in active_labels:
		if label.visible == false:
			active_labels.erase(label)
	
	
	
	for index in range(num_needed_label_pairs):
		var key = stats_to_display.keys()[index]
		var value = stats_to_display[key]
		active_labels[2*index].text = key
		active_labels[2*index + 1].text = value


func _on_visibility_changed():
	Stats.display_stats.emit(self)
