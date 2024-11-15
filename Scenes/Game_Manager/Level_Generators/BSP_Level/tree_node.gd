extends Node
class_name TreeNode


var left_child: TreeNode
var right_child: TreeNode
var position: Vector2i
var size: Vector2i


func _init(position, size) -> void:
	self.position = position
	self.size = size


func return_leaves():
	if not (left_child && right_child):
		return [self]
	else:
		return left_child.return_leaves() + right_child.return_leaves()


func split(remaining):
	var randomizer = RandomNumberGenerator.new()
	var split_percent = randomizer.randf_range(0.3,  0.7)
	var min_size := Vector2i(2, 2)
	var split := false
	var new_size

	if size.x > min_size.x and size.y > min_size.y:
		split = true
	else:
		return

	if split:
		if size.x < size.y:
			var left_child_height = int(size.y * split_percent)
			new_size = Vector2i(size.x, left_child_height)

			if new_size.x <= min_size.x or new_size.y <= min_size.y:
				return
			else:
				left_child = TreeNode.new(
					Vector2i(position.x + 1, position.y + 1),
					Vector2i(size.x - 1, left_child_height - 1)
				)
				right_child = TreeNode.new(
					Vector2i(position.x + 1, position.y + left_child_height + 1),
					Vector2i(size.x - 1, size.y - left_child_height - 1)
				)
		else:
			var left_child_width = int(size.x * split_percent)
			new_size = Vector2i(size.y, left_child_width)

			if new_size.x <= min_size.x or new_size.y <= min_size.y:
				return
			else:
				left_child = TreeNode.new(
					Vector2i(position.x + 1, position.y + 1),
					Vector2i(left_child_width - 1, size.y - 1)
				)
				right_child = TreeNode.new(
					Vector2i(position.x + left_child_width + 1, position.y + 1),
					Vector2i(size.x - left_child_width - 1, size.y - 1)
				)

	if remaining > 0:
		left_child.split(remaining - 1)
		right_child.split(remaining - 1)
