extends TileMapLayer


func set_size(size: Vector2):
	var background_rect = size
	var background_position: Array[Vector2i]

	for x in range(-5, background_rect.x + 5):
		for y in range(-5, background_rect.y + 5):
			background_position.append(Vector2i(x, y))

	set_cells_terrain_connect(
		background_position, 0, 0
	)
