extends CharacterBody2D
class_name Skeleton_Enemy


var player_body: CharacterBody2D
var move_direction = Vector2.ZERO


@export var move_speed = 35.0


func with_data(_player) -> Skeleton_Enemy:
	player_body = _player
	return self

func _ready() -> void:
	$Stats.connect("death", _death)
	$Attack_Area/CollisionShape2D.disabled = true


func _physics_process(delta: float) -> void:
	velocity = move_direction * move_speed
	move_and_slide()


func _death():
	$Terrain_Collision.disabled = true
	RunStats.EnemiesKilled += 1
	if $AnimationPlayer.is_playing():
		$AnimationPlayer.stop()
	$AnimationPlayer.play("death")

func _death_anim():
	queue_free()
