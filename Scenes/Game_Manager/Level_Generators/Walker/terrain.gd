extends Node2D


@onready var floor_tilemap: TileMapLayer = $Terrain/Level


var starting_position := Vector2(18, 9)
var borders := Rect2(1, 1, 38, 20)
var map: Array
var player: CharacterBody2D


func _ready() -> void:
	generate_level()
	place_player()

func generate_level():
	var walker = Walker.new(starting_position, borders)

	map = walker.walk(750)
	walker.queue_free()

	floor_tilemap.set_cells_terrain_connect(
		map, 0, 0
	)


func place_player():
	var player_spawn_position = Vector2(
		map[0].x * 32 + 16,
		map[0].y * 32 + 16
	)
	player.position = player_spawn_position
