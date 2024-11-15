extends State
class_name  IdleState

@export var move_speed: float = 25.0
@export var self_charBody: CharacterBody2D

var move_direction: Vector2
var move_options: Array[Vector2] = [
		Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT
	]
var tmp_move_options: Array[Vector2]
var wander_cooldown: float
var idle_cooldown: float


func _ready() -> void:
	tmp_move_options = move_options.duplicate()
	tmp_move_options.shuffle()
	$"../../Stats".stun_state.connect(_switch_to_Stun)


func random_wander():
	if tmp_move_options.is_empty():
		tmp_move_options = move_options.duplicate()
		tmp_move_options.shuffle()
	move_direction = tmp_move_options.pick_random()
	tmp_move_options.erase(move_direction)
	wander_cooldown = randf_range(1, 5)
	$"../../AnimationPlayer".play("run")


func idle():
	move_direction = Vector2.ZERO
	wander_cooldown = 0.0
	idle_cooldown = 1.5
	$"../../AnimationPlayer".play("idle")


func enter():
	if $"../../Engage_Area".has_overlapping_bodies():
		change_state.emit(self, "followstate")
	idle()


func update(_delta: float):
	if idle_cooldown > 0:
		idle_cooldown -= _delta
	else:
		if wander_cooldown > 0:
			wander_cooldown -= _delta
			if wander_cooldown <= 0:
				idle()
		else:
			random_wander()


func physics_update(_delta: float):
	if self_charBody.get_slide_collision_count():
		tmp_move_options.erase(move_direction)

		self_charBody.position += move_direction * -5

		random_wander()

	self_charBody.move_direction = move_direction


func _on_engage_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		change_state.emit(self, "followstate")


func _switch_to_Stun():
	change_state.emit(self, "stunstate")
