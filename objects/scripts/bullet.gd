extends Area2D

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
