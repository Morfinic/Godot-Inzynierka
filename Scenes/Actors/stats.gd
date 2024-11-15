extends Node


signal death
signal took_damage(health)
signal increased_max_health(health)
signal stun_state


@export var stun_timer: Timer = null


@export var max_health: float
@export var base_damage: float
@export var damage_modifier: float
@export var hurt_sound_player: AudioStreamPlayer


@onready var health: float = max_health
var damage
var dead: bool = false


func _ready() -> void:
	update_damage()


func update_damage():
	if owner.is_in_group("Player"):
		damage = base_damage * (1 + damage_modifier)
	elif owner.is_in_group("Enemy"):
		damage = base_damage * (1 + 0.1 * (RunStats.Floor - 1))


func take_damage(_damage):
	if !dead:
		health -= _damage
		took_damage.emit(health)

		if health <= 0:
			dead = true
			death.emit()
			return

		if health > 0 and hurt_sound_player.playing == false and !dead:
			hurt_sound_player.play()

		if stun_timer != null:
			#owner.process_mode = Node.PROCESS_MODE_DISABLED
			#stun_timer.start(0.5)
			stun_state.emit()


func increase_max_health(amount):
	max_health += amount
	increased_max_health.emit(max_health)
