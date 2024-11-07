extends State
class_name AttackState


@export var self_charBody: CharacterBody2D


@onready var player: CharacterBody2D = self_charBody.player_body


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
