extends Node
class_name Walker_Room

const DIRECTION = [Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN]

var position = Vector2.ZERO
var direction = Vector2.UP
var border = Rect2()
var step_history: Array = []
var steps_since_turn = 0
var rooms: Array = []


func _init(starting_position, new_border: Rect2) -> void:
	assert(new_border.has_point(starting_position))
	position = starting_position
	step_history.append(position)
	border = new_border
	randomize()


func walk(steps):
	place_room(position)

	for step in steps:
		if steps_since_turn >= 10:
			change_direction()

		if step():
			if not step_history.has(position):
				step_history.append(position)
		else:
			change_direction()

	place_room(position)

	return step_history


func step():
	var target_position = position + direction
	if border.has_point(target_position):
		steps_since_turn += 1
		position = target_position
		return true
	else:
		return false


func change_direction():
	place_room(position)
	steps_since_turn = 0
	var directions = DIRECTION.duplicate()
	directions.erase(direction)

	directions.shuffle()
	direction = directions.pop_front()
	while not border.has_point(position + direction):
		direction = directions.pop_front()


func place_room(spawn_pos):
	var size = Vector2(
		randi() % 4 + 2,
		randi() % 4 + 2
	)
	var room_top_left_corner = (position - size/2).ceil()

	rooms.append(create_room(position, size))

	for x in size.y:
		for y in size.y:
			var new_step = room_top_left_corner + Vector2(x, y)
			if border.has_point(new_step) and not step_history.has(new_step):
				step_history.append(new_step)


func create_room(position, size):
	return {
		position = position,
		size = size
	}
