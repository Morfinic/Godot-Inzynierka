extends Node2D


@onready var weapon_anim_player: AnimationPlayer = $Weapon_Anim_Player


@export var can_attack: bool


func _ready() -> void:
	can_attack = true


func _input(event: InputEvent) -> void:
	if can_attack and event.is_action_pressed("Attack"):
		match $"../Sprite2D".flip_h:
			false:
				weapon_anim_player.play("attack_right")
			true:
				weapon_anim_player.play("attack_left")
