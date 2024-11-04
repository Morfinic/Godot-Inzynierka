extends Node
class_name Walker


const DIRECTION = [Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN]

var position = Vector2.ZERO
var direction = Vector2.UP
var border = Rect2()
var step_history: Array = []
var steps_since_turn = 0


func _init(starting_position, new_border: Rect2) -> void:
	assert(new_border.has_point(starting_position))
	position = starting_position
	step_history.append(position)
	border = new_border
	randomize()


func walk(steps):
	for step in steps:
		if randf() <= 0.15 or steps_since_turn >= 5:
			change_direction()

		if step():
			if not step_history.has(position):
				step_history.append(position)
		else:
			change_direction()

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
	steps_since_turn = 0
	var directions = DIRECTION.duplicate()
	directions.erase(direction)

	directions.shuffle()
	direction = directions.pop_front()
	while not border.has_point(position + direction):
		direction = directions.pop_front()
