extends State
class_name AttackState


@export var self_charBody: CharacterBody2D
@export var stats: Node


@onready var player: CharacterBody2D = self_charBody.player_body
@onready var attack_coll: CollisionShape2D = $"../../Attack_Area/CollisionShape2D"


func enter():
	self_charBody.move_direction = Vector2.ZERO
	$"../../AnimationPlayer".play("attack")


func calculate_state():
	if self_charBody.position.distance_to(player.position) <= 32:
		change_state.emit(self, "attackstate")
	else:
		if $"../../Engage_Area".has_overlapping_bodies():
			change_state.emit(self, "followstate")
		else:
			change_state.emit(self, "idlestate")


func _on_attack_area_body_entered(body: Node2D) -> void:
	attack_coll.set_deferred("disabled", true)
	if body.is_in_group("Player"):
		body.get_node("Stats").take_damage(stats.damage)
