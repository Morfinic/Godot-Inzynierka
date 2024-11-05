extends Node2D


@onready var run_stats: Node = $Run_Stats
@onready var player := $Player


@export var walker: PackedScene


func _ready() -> void:
	init_level()


func init_level():
	var floor_id = run_stats.Floor % 1
	var level

	match floor_id:
		0:
			level = walker.instantiate()

	level.player = player
	level.z_index = -2
	add_child.call_deferred(level)


func _on_level_manager_child_exiting_tree(node: Node) -> void:
	if node.name.ends_with("_Level"):
		run_stats.Floor += 1
		init_level()
