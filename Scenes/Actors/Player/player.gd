extends CharacterBody2D


@export_category("Movement")
@export var SPEED = 100
@export var can_walk: bool = true


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var stats: Node = $Stats


func _ready() -> void:
	stats.connect("death", _death)


func _physics_process(delta: float) -> void:
	if can_walk and %"Stats".health > 0:
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
	else:
		velocity = Vector2.ZERO

	move_and_slide()


func _death():
	if animation_player.is_playing():
		animation_player.stop()
	animation_player.play("death")


func _death_screen():
	SceneChangerAnim.change_scene(Resources.death_screen)
