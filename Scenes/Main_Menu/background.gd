extends TileMapLayer


func _ready() -> void:
	var background_rect: Vector2i = get_used_rect().size
	var background_position: Array[Vector2i]

	for x in range(-1, background_rect.x):
		for y in range(-1, background_rect.y):
			background_position.append(Vector2i(x, y))

	set_cells_terrain_connect(
		background_position, 0, 0
	)
