extends CharacterBody2D


const SPEED = 150.0


@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if direction.y >= 0.5:
		animation_player.play("run_down")
	elif direction.y <= -0.5:
		animation_player.play("run_up")
	elif direction.x >= 1:
		animation_player.play("run_right")
	elif direction.x <= -1:
		animation_player.play("run_left")
	else:
		animation_player.play("idle")

	velocity = direction * SPEED
	move_and_slide()
