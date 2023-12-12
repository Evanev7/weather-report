extends Resource
class_name PlantResource

enum BULLET_TYPE {Normal, AOE, ACTIVATED}

@export_category("Metadata")
@export var NAME: String
@export var ANIMATION: SpriteFrames
@export var ICON: Texture2D
@export var FLIP_H: bool

@export_category("Plant Stats")
@export var COST: int = 10
@export var DURABILITY: float = 100
@export var RANGE: float = 200
@export var FIRE_RATE: float = 10

@export_category("Weather Script")
@export var WEATHER_SCRIPT: Script

@export_category("Bullet Metadata")
@export var BULLET_ANIMATION: SpriteFrames
@export var TYPE: PlantResource.BULLET_TYPE = BULLET_TYPE.Normal
@export var COLLISION_RADIUS: float = 10
@export var BULLET_PARTICLES: ParticleProcessMaterial
@export var BULLET_PARTICLE_LIFETIME: float = 1
@export var BULLET_PARTICLE_TEXTURE: Texture

@export_category("Bullet Stats")
@export_group("Damage Types")
@export var DAMAGE: float = 5
@export var POISON_DAMAGE: float = 0
@export var POISON_DURATION: float = 0
@export var SLOW_AMOUNT: float = 0
@export var SLOW_DURATION: float = 0

@export_group("Other")
@export var STARTING_DISTANCE: float = 0
@export var SHOT_SPEED: float = 100
@export var ANGULAR_VELOCITY: float = 0
@export var SIZE: Vector2 = Vector2(1, 1)
@export var BULLET_LIFETIME: float = 1
@export var PIERCING_AMOUNT: int = 1
@export var PIERCING_COOLDOWN: float = 0
