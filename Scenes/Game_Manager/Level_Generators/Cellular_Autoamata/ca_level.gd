extends Node2D
class_name CA_Level


@onready var floor_tilemap: TileMapLayer = $Terrain/Terrain
@onready var background: TileMapLayer = $Terrain/Background
@onready var exit_finder: NavigationAgent2D = $Terrain/Terrain/Exit_Finder



@export var exit: PackedScene
@export var treasure: PackedScene
@export var enemy: PackedScene


var map := []
var borders: Rect2
var player: CharacterBody2D


func with_data(_borders, _player) -> CA_Level:
	borders = _borders
	player = _player
	return self


func _ready() -> void:
	background.set_size(borders.size)
	generate_level()
	place_player()
	place_exit()


func generate_level():
	var Cell_Aut = CA.new(borders)
	map = Cell_Aut.simulate()
	Cell_Aut.queue_free()

	floor_tilemap.set_cells_terrain_connect(
		map, 0, 0
	)


func place_player():
	var _spawn_tile = map.pick_random()
	var del_tiles = Utils.get_surrounding_tile_area(
		_spawn_tile, floor_tilemap, 5
	)
	for tile in del_tiles:
		map.erase(tile)

	var player_spawn_position = Vector2(
		_spawn_tile.x * 32 + 16,
		_spawn_tile.y * 32 + 16
	)
	player.position = player_spawn_position
	map.erase(_spawn_tile)


func place_exit():
	var exit_node = exit.instantiate()

	#var tmp_map = map.duplicate()
	#tmp_map.shuffle()
	#var exit_options = tmp_map.slice(0, 20)
	var _spawn_tile = find_exit_position(map)

	var del_tiles = Utils.get_surrounding_tile_area(
		_spawn_tile, floor_tilemap, 2
	)
	for tile in del_tiles:
		map.erase(tile)

	var exit_position = Vector2(
		_spawn_tile.x * 32 + 16,
		_spawn_tile.y * 32 + 16
	)

	exit_node.position = exit_position
	add_child(exit_node)
	exit_node.connect("level_finished", Callable(self, "finish_level"))
	map.erase(_spawn_tile)


func finish_level():
	queue_free()


func find_exit_position(exit_options):
	var first_pos = exit_options.pop_front()
	var exit_position = first_pos

	var distance_to_current_exit
	var distance_to_new_exit

	for option in exit_options:
		exit_finder.target_position = exit_position
		distance_to_current_exit = exit_finder.distance_to_target()

		exit_finder.target_position = option
		distance_to_new_exit = exit_finder.distance_to_target()

		if distance_to_new_exit > distance_to_current_exit:
			exit_position = option

	return exit_position
