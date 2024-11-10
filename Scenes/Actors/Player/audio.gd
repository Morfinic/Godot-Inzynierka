extends Node


func _ready() -> void:
	RunStats.connect("gold_picked", _gold_picked)


func _gold_picked():
	$Treasure_Pickup.play()
