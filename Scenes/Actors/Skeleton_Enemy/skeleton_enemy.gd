extends CharacterBody2D


var player_body: CharacterBody2D
var move_direction = Vector2.ZERO


@export var move_speed = 35.0


func _physics_process(delta: float) -> void:
	velocity = move_direction * move_speed
	move_and_slide()
