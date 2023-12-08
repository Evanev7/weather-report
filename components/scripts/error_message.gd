extends Node2D

@export var ap: AnimationPlayer
@export var label: RichTextLabel
@export var label_container: Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func set_text_and_animate(text: String, start_pos: Vector2) -> void:
	label.text = str(text)
	ap.play("rise_and_fade")
	
	var tween: Tween = create_tween()
	var end_pos = Vector2(0, randf_range(0, -5)) + start_pos
	var tween_length = ap.get_animation("rise_and_fade").length
	
	tween.tween_property(label_container, "global_position", end_pos, tween_length).from(start_pos)
	

func remove() -> void:
	ap.stop()
	if is_inside_tree():
		get_parent().remove_child(self)
