extends Resource
class_name UpgradeGroup

signal active_resources_changed

var active_resources: Dictionary = {}
var locked_index: int = 0

func update_resources(index: int,resource):
	var credits_diff: int
	if resource:
		credits_diff -= resource.credit_value
	if active_resources.has(index) and active_resources[index]:
		credits_diff += active_resources[index].credit_value
	if GameState.level:
		GameState.level.water_credits += credits_diff
	active_resources[index] = resource
	active_resources_changed.emit()

func size() -> int:
	var count: int = 0
	for script in active_resources.values():
		if script:
			count += 1
	return count
