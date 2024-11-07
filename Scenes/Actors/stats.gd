extends Node


@export var gold: int = 0
@export var health: float = 100


func update_gold():
	gold += randi() % 5 + 5
	$"../Audio/Treasure_Pickup".play()
