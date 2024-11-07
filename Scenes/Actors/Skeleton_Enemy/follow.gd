extends State
class_name FollowState


@export var self_charBody: CharacterBody2D
@onready var player: CharacterBody2D = self_charBody.player_body
@onready var nav_agent: NavigationAgent2D = $"../../NavigationAgent2D"
var next_path_pos


func _ready() -> void:
	call_deferred("path_setup")


func enter():
	next_path_pos = Vector2.ZERO


func physics_update(_delta: float):
	if player:
		nav_agent.target_position = player.global_position

	if nav_agent.is_navigation_finished():
		change_state.emit(self, "attackstate")

	if next_path_pos == Vector2.ZERO or self_charBody.position.distance_to(next_path_pos) < 0.5:
		next_path_pos = nav_agent.get_next_path_position()
	else:
		if self_charBody.position.distance_to(player.position) < 32:
			nav_agent.target_position = self_charBody.global_position
		else:
			self_charBody.move_direction = self_charBody.global_position.direction_to(next_path_pos)
			$"../../AnimationPlayer".play("run")


func path_setup():
	await get_tree().physics_frame
	if player:
		nav_agent.target_position = player.global_position


func _on_engage_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		change_state.emit(self, "idlestate")
