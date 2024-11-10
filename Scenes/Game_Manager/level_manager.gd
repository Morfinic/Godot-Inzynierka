extends Node2D


@onready var player := $Player
@onready var level_transition: CanvasLayer = $"../Level_Transition"


func _ready() -> void:
	RunStats.new_run()
	init_level()


func init_level():
	var floor_id = RunStats.Floor % 1
	var level
	var level_size := Vector2i(38, 20)
	#38, 20

	match floor_id:
		0:
			level = Resources.walker_level.instantiate().with_data(
				level_size / 2, Rect2(Vector2(1, 1), level_size), player
			)

	level.z_index = -2
	add_child.call_deferred(level)


func _on_level_manager_child_exiting_tree(node: Node) -> void:
	if node.name.ends_with("_Level") and player.stats.health > 0:
		RunStats.Floor += 1
		$"../Level_Transition".change_level()
