extends Node


signal death


@export var treasure_audioPlayer: AudioStreamPlayer = null
@export var stun_timer: Timer = null


@export var gold: int = 0
@export var max_health: float
@export var base_damage: float
@export var damage_modifier: float


@onready var health: float = max_health
var damage


func _ready() -> void:
	update_damage()


func update_damage():
	if owner.is_in_group("Player"):
		damage = base_damage * (1 + damage_modifier)
	elif owner.is_in_group("Enemy"):
		var floor = owner.get_parent().get_parent().get_node("Run_Stats").Floor
		damage = base_damage * (1 + 0.1 * (floor - 1))



func update_gold():
	gold += randi() % 5 + 5
	if treasure_audioPlayer != null:
		treasure_audioPlayer.play()


func take_damage(damage):
	health -= damage

	if health <= 0:
		death.emit()

	if stun_timer != null:
		owner.process_mode = Node.PROCESS_MODE_DISABLED
		stun_timer.start(0.5)
