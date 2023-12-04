extends Area2D
class_name Bullet

@export var sprite: AnimatedSprite2D

var damage: float
var direction: Vector2 = Vector2(0, 0)
var speed: float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	transport(delta)

func transport(delta) -> void:
	position += direction * speed * delta
	rotation = direction.angle()

func hit_success():
	remove()
	
func remove():
	queue_free()
