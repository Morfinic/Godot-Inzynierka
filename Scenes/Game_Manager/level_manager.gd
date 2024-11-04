extends Node2D


@onready var run_stats: Node = $Run_Stats
@onready var player := $Player


@export var walker: PackedScene


func _ready() -> void:
	var floor_id = run_stats.Floor % 1
	init_level(floor_id)


func init_level(floor_id):
	var level

	match floor_id:
		0:
			level = walker.instantiate()

	level.player = player
	level.z_index = -2
	add_child(level)
