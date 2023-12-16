extends VBoxContainer

signal display_resource(resource, weather, value)

@export var upgrade_group: UpgradeGroup = UpgradeGroup.new()
@export var upgrades_array_a: Array[WeatherUpgradeResource]
@export var upgrades_array_b: Array[WeatherUpgradeResource]
@export var icon: CompressedTexture2D

func _ready():
	for index in range(8):
		var button_a = get_node("%Button"+str(index)+"A")
		button_a.upgrade_resource = upgrades_array_a[index]
		button_a.index = index
		
		var button_b = get_node("%Button"+str(index)+"B")
		button_b.upgrade_resource = upgrades_array_b[index]
		button_b.index = index
		
		var button_group = ButtonGroup.new()
		button_group.allow_unpress = true
		button_a.button_group = button_group
		button_b.button_group = button_group
		button_a.parent_ready()
		button_b.parent_ready()
	if icon:
		%Display.texture = icon 


func _on_lock_shop():
	upgrade_group.locked_index = upgrade_group.size()
