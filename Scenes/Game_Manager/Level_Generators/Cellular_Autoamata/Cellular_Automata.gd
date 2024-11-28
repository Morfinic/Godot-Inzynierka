extends Node
class_name CA


var size
var grid := []


func _init(_size) -> void:
	size = _size.size


func simulate():
	randomize()
	create_noise()
	generate_cave()

	return create_map()


func create_noise():
	for x in range(size.x):
		grid.append([])
		for y in range(size.y):
			grid[x].append(randf() < 0.45)


func generate_cave():
	var iter = 3
	for i in range(iter):
		var grid_copy = grid.duplicate(true)

		for y in range(size.y):
			for x in range(size.x):
				var wall_count = count_walls(x, y, 1)
				var flood_protocol = count_walls(x, y, 2)
				var cell_type = grid[x][y]

				if grid_copy[x][y]:
					if i == iter - 1:
						grid_copy[x][y] = wall_count >= 4 or flood_protocol <= 2
					else:
						grid_copy[x][y] = wall_count >= 4
				else:
					grid_copy[x][y] = wall_count >= 5
				#if wall_count >= 5 or flood_protocol <= 3:
					#grid_copy[x][y] = true
				#else:
					#grid_copy[x][y] = false

		grid = grid_copy


func count_walls(x, y, area):
	var cnt = 0

	for i in range(-area, area + 1):
		for j in range(-area, area + 1):
			if i == 0 and j == 0:
				continue

			var nx = x + i
			var ny = y + j

			if nx < 0 or nx >= size.x or ny < 0 or ny >= size.y:
				cnt += 1
			elif grid[nx][ny]:
				cnt += 1

	return cnt


func create_map():
	var map := []

	for x in range(size.x):
		for y in range(size.y):
			if !grid[x][y]:
				map.append(Vector2(x + 1, y + 1))

	return map
