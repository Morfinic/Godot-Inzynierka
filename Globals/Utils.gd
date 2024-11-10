extends Node


func get_surrounding_tile_area(current_tile, tilemap: TileMapLayer, area: int):
	var surrounding_tiles := []
	var target_tile

	for x in range(-area, area):
		for y in range(-area, area):
			target_tile = current_tile + Vector2(x, y)

			if current_tile == target_tile:
				continue

			surrounding_tiles.append(target_tile)

	return surrounding_tiles
