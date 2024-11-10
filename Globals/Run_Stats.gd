extends Node


signal gold_picked
signal gold_changed
signal gold_spend


var Floor: int
var Gold: int
var EnemiesKilled: int


func update_gold():
	var gold_add = randi() % 5 + 5
	Gold += gold_add
	gold_picked.emit()
	gold_changed.emit(Gold)


func spend_gold(amount):
	Gold -= amount
	gold_spend.emit()
	gold_changed.emit()


func new_run():
	Floor = 1
	Gold = 0
	EnemiesKilled = 0
