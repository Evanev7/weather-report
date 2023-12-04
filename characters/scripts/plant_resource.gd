extends Resource
class_name PlantResource

@export_category("Metadata")
@export var NAME: String
@export var ANIMATION: SpriteFrames
@export var FLIP_H: bool

@export_category("Plant Stats")
@export var DURABILITY: float = 100
@export var RANGE: float = 500
@export var FIRE_RATE: float = 10

@export_category("Bullet Stats")
@export var DAMAGE: float = 5
@export var SHOT_SPEED: float = 100
@export var SIZE: Vector2 = Vector2(1, 1)
