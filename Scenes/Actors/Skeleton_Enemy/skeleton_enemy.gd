extends CharacterBody2D


var player_body: CharacterBody2D
var move_direction = Vector2.ZERO


@export var move_speed = 35.0


func _ready() -> void:
	$Stats.connect("death", _death)
	$Attack_Area/CollisionShape2D.disabled = true

func _physics_process(delta: float) -> void:
	velocity = move_direction * move_speed
	move_and_slide()


func _death():
	queue_free()
