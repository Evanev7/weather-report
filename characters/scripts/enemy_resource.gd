extends Resource
class_name EnemyResource

@export_category("Metadata")
@export var NAME: String
@export var ANIMATION: SpriteFrames
@export var FLIP_H: bool
@export var FLOATING: bool

@export_category("Stats")
@export var SPEED: float
@export var MAX_HP: float
@export var DAMAGE: float
@export var VALUE: float
@export var STRENGTH: float = 1

@export_category("Collision")
## Affects sprite and collision size
@export var SCALE: Vector2 = Vector2(1, 1)
@export var HITBOX_RADIUS: float = 50

@export_category("Multipliers")
@export var UNIQUE_MULTIPLIER: float = 1
@export var OVERALL_MULTIPLIER: float = 1
