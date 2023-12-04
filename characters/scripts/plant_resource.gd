extends Resource
class_name PlantResource

@export_category("Metadata")
@export var NAME: String
@export var ANIMATION: SpriteFrames
@export var FLIP_H: bool

@export_category("Plant Stats")
@export var DURABILITY: float
@export var RANGE: float = 500
@export var FIRE_RATE: float = 300

@export_category("Bullet Stats")
@export var DAMAGE: float
@export var SHOT_SPEED: float
@export var SIZE: Vector2 = Vector2(1, 1)
