extends Node2D


@onready var weapon_anim_player: AnimationPlayer = $Weapon_Anim_Player


@export var can_attack: bool
@export var stats: Node


func _ready() -> void:
	can_attack = true


func _input(event: InputEvent) -> void:
	if can_attack and %Stats.health > 0:
		if event.is_action_pressed("attack_left"):
			weapon_anim_player.play("attack_left")
		elif event.is_action_pressed("attack_right"):
			weapon_anim_player.play("attack_right")
		elif event.is_action_pressed("attack_up"):
			weapon_anim_player.play("attack_up")
		elif event.is_action_pressed("attack_down"):
			weapon_anim_player.play("attack_down")


func deal_damage():
	var bodies = $Sword_Attack_Collision.get_overlapping_bodies()
	for body: CharacterBody2D in bodies:
		body.get_node("Stats").take_damage(stats.damage)
