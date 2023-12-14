extends TextureButton

@export var upgrade_resource: WeatherUpgradeResource
@export_range(0,10) var index: int = 0
@onready var upgrade_group: UpgradeGroup = owner.upgrade_group

func parent_ready():
	button_group.pressed.connect(_on_pressed)
	upgrade_group.active_resources_changed.connect(_on_active_resources_changed)
	_on_active_resources_changed()

func _on_active_resources_changed():
	disabled = !can_select_script()

func can_select_script() -> bool:
	print(index, upgrade_group.size())
	if index < upgrade_group.locked_index:
		return false
	
	if upgrade_group.size() not in [index, index+1]:
		return false
	
	if not GameState.level1:
		print("ello")
		return true
	
	if GameState.level1.water_credits < upgrade_resource.credit_value:
		return false
	
	return true


func _on_pressed(_who):
	$Selector.visible = button_pressed
	print(upgrade_group.active_resources)
	if button_pressed:
		print("helllo", upgrade_resource)
		upgrade_group.update_resources(index, upgrade_resource)
	if not button_group.get_pressed_button():
		upgrade_group.update_resources(index, null)
