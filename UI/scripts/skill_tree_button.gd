extends TextureButton

@export var upgrade_resource: WeatherUpgradeResource
@export_range(0,10) var index: int = 0
@onready var upgrade_group: UpgradeGroup = owner.upgrade_group

func parent_ready():
	button_group.pressed.connect(_on_pressed)
	upgrade_group.active_resources_changed.connect(_on_active_resources_changed)
	_on_active_resources_changed()
	$Selector/Icon.texture = upgrade_resource.icon
	$Selector.self_modulate = float(button_pressed) * Color(1,1,1,1)

func _on_active_resources_changed():
	if not is_node_ready():
		return
	disabled = !can_select_script()

func can_select_script() -> bool:
	if index < upgrade_group.locked_index:
		return false
	
	if upgrade_group.size() not in [index, index+1]:
		return false
	
	if not GameState.level:
		return true
	
	var discount: int = 0
	var _pressed = button_group.get_pressed_button()
	if _pressed:
		discount = _pressed.upgrade_resource.credit_value
	
	if GameState.level.water_credits < upgrade_resource.credit_value - discount:
		return false
	
	return true


func _on_pressed(_who):
	$Selector.self_modulate = float(button_pressed) * Color(1,1,1,1)
	if button_pressed:
		SoundManager.small_select_button.play()
		upgrade_group.update_resources(index, upgrade_resource)
	if not button_group.get_pressed_button():
		upgrade_group.update_resources(index, null)


func _on_mouse_entered():
	if "2" in owner.name:
		owner.display_resource.emit(upgrade_resource, "Autumn")
	elif "3" in owner.name:
		owner.display_resource.emit(upgrade_resource, "Winter")
	elif "4" in owner.name:
		owner.display_resource.emit(upgrade_resource, "Spring")
	else:
		owner.display_resource.emit(upgrade_resource, "Summer")
	
