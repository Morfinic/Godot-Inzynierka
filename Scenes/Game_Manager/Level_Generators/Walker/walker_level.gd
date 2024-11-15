extends Node2D
class_name Walker_Level


@onready var floor_tilemap: TileMapLayer = $Terrain/Level
@onready var background: TileMapLayer = $Terrain/Background
@onready var treasure_holder: Node2D = $Treasure_Holder
@onready var enemies_holder: Node2D = $Enemies_Holder
@onready var exit_finder: NavigationAgent2D = $Terrain/Level/Exit_Finder


@export var exit: PackedScene
@export var treasure: PackedScene
@export var enemy: PackedScene


var starting_position: Vector2
var borders: Rect2
var map: Array
var player: CharacterBody2D


func with_data(_starting_position, _borders, _player) -> Walker_Level:
	starting_position = _starting_position
	borders = _borders
	player = _player
	return self


func _ready() -> void:
	background.set_size(borders.size)
	generate_level()
	place_player()
	place_exit()
	place_treasure()
	place_enemies()

func generate_level():
	var walker = Walker.new(starting_position, borders)
	var steps_amount = floor((borders.size.x * borders.size.y) * 0.75)

	map = walker.walk(steps_amount)
	walker.queue_free()

	floor_tilemap.set_cells_terrain_connect(
		map, 0, 0
	)


func place_player():
	var _spawn_tile = starting_position
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

	var tmp_map = map.duplicate()
	tmp_map.shuffle()
	var exit_options = tmp_map.slice(0, 20)
	var _spawn_tile = find_exit_position(exit_options)

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
	var player_spawn = player.position

	for option in map:
		exit_finder.target_position = exit_position
		var distance_to_current_exit = exit_finder.distance_to_target()

		exit_finder.target_position = option
		var distance_to_new_exit = exit_finder.distance_to_target()

		if distance_to_new_exit > distance_to_current_exit:
			exit_position = option

	return exit_position


func place_treasure():
	var treasure_amount = floor(map.size() / 30)

	for i in treasure_amount:
		var _spawn_tile = map.pick_random()
		var del_tiles = Utils.get_surrounding_tile_area(
			_spawn_tile, floor_tilemap, 2
		)
		for tile in del_tiles:
			map.erase(tile)

		var treasure_position = Vector2(
			_spawn_tile.x * 32 + 16,
			_spawn_tile.y * 32 + 16
		)

		var treasure_node = treasure.instantiate()
		treasure_node.position = treasure_position
		treasure_holder.add_child(treasure_node)


func place_enemies():
	var enemy_amount = floor(map.size() / 20)
	#var enemy_amount = 1

	for i in enemy_amount:
		var _spawn_tile = map.pick_random()
		var del_tiles = Utils.get_surrounding_tile_area(
			_spawn_tile, floor_tilemap, 4
		)
		for tile in del_tiles:
			map.erase(tile)

		var enemy_position = Vector2(
			_spawn_tile.x * 32 + 16,
			_spawn_tile.y * 32 + 16
		)

		var enemy_node = enemy.instantiate().with_data(player)
		enemy_node.position = enemy_position
		enemies_holder.add_child(enemy_node)
