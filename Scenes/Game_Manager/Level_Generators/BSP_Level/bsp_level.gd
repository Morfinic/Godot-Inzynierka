extends Node2D
class_name BSP_Level


@export var exit: PackedScene
@export var treasure: PackedScene
@export var enemy: PackedScene


@onready var background: TileMapLayer = $Terrain/Background
@onready var floor_tilemap: TileMapLayer = $Terrain/Terrain
@onready var exit_finder: NavigationAgent2D = $Terrain/Terrain/Exit_Finder
@onready var treasure_holder: Node2D = $Treasure_Holder
@onready var enemies_holder: Node2D = $Enemies_Holder


var root_node: TreeNode

var borders: Rect2
var map: Array = []
var corridors: Array = []
var rooms: Array = []
var rooms_map: Array = []
var player: CharacterBody2D


func _ready() -> void:
	background.set_size(borders.size)
	generate_level()
	place_player()
	place_exit()
	place_treasure()
	place_enemies()


func with_data(_borders, _player) -> BSP_Level:
	borders = _borders
	player = _player
	return self


func generate_level():
	root_node = TreeNode.new(
		Vector2i(0, 0),
		borders.size
	)
	root_node.split(10)
	rooms = root_node.return_leaves()

	for room in rooms:
		var room_map: Array = []
		for x in range(room.size.x):
			for y in range(room.size.y):
				var tile = Vector2(x + room.position.x, y + room.position.y)
				room_map.append(tile)
				map.append(tile)
		rooms_map.append(room_map)

	for i in range(0, rooms.size() - 1):
		var path = get_corridor_path(rooms[i], rooms[i + 1])
		var walker = path[0]
		while walker != path[1]:
			if walker.y == path[1].y:
				walker.x += 1 * sign(path[1].x - path[0].x)
				if not corridors.has(walker):
					corridors.append(walker)
			else:
				walker.y += 1 * sign(path[1].y - path[0].y)
				if not corridors.has(walker):
					corridors.append(walker)

	floor_tilemap.set_cells_terrain_connect(
			map + corridors, 0, 0
		)


func get_corridor_path(room1, room2):
	return [
		get_room_center(room1),
		get_room_center(room2)
	]


func get_room_center(room):
	return Vector2i(room.position.x + room.size.x / 2, room.position.y + room.size.y / 2)


func place_player():
	var _spawn_room = rooms.pop_front()
	rooms_map.pop_front()
	var _spawn_tile = get_room_center(_spawn_room)

	var player_spawn_position = Vector2(
		_spawn_tile.x * 32 + 16,
		_spawn_tile.y * 32 + 16
	)
	player.position = player_spawn_position


func place_exit():
	var exit_node = exit.instantiate()
	var _spawn_tile = find_exit_position()

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


func find_exit_position():
	var rooms_dup = rooms.duplicate()
	var first_room = rooms_dup.pop_front()
	var exit_position = first_room.position
	var player_spawn = player.position
	var exit_room

	for room in rooms_dup:
		exit_finder.target_position = exit_position
		var distance_to_current_exit = exit_finder.distance_to_target()

		exit_finder.target_position = room.position
		var distance_to_new_exit = exit_finder.distance_to_target()

		if distance_to_new_exit > distance_to_current_exit:
			exit_position = room.position
			exit_room = room

	return get_room_center(exit_room)


func place_treasure():
	for room in rooms_map.duplicate():
		var treasure_amount = randi_range(1, 3)

		for i in treasure_amount:
			var _spawn_tile = room.pick_random()
			var del_tiles = Utils.get_surrounding_tile_area(
				_spawn_tile, floor_tilemap, 2
			)
			for tile in del_tiles:
				room.erase(tile)

			var treasure_position = Vector2(
				_spawn_tile.x * 32 + 16,
				_spawn_tile.y * 32 + 16
			)

			var treasure_node = treasure.instantiate()
			treasure_node.position = treasure_position
			treasure_holder.add_child(treasure_node)


func place_enemies():
	for room in rooms_map.duplicate():
		var enemy_amount = randi_range(1, 3)

		for i in enemy_amount:
			var _spawn_tile = room.pick_random()
			var del_tiles = Utils.get_surrounding_tile_area(
				_spawn_tile, floor_tilemap, 3
			)
			for tile in del_tiles:
				room.erase(tile)

			var enemy_position = Vector2(
				_spawn_tile.x * 32 + 16,
				_spawn_tile.y * 32 + 16
			)

			var enemy_node = enemy.instantiate().with_data(player)
			enemy_node.position = enemy_position
			enemies_holder.add_child(enemy_node)
