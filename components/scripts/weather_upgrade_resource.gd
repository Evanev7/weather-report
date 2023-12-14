extends Resource
class_name WeatherUpgrade

@export var name: String
@export var upgrade_script: Script

@export var credit_value: int = 10
@export var icon: CompressedTexture2D
@export_multiline var description: String = "Default Upgrade Description"

@export var displayed_stats: Dictionary
