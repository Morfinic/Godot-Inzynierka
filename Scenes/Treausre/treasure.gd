extends Sprite2D


signal treasure_collected(body)


func _ready() -> void:
	self.connect("treasure_collected", _treasure_collected)


func _on_pickup_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var tween = get_tree().create_tween()
		tween.tween_method(
			func(progress):
				self.position = lerp(self.position, body.position, progress)
				if(self.position.distance_to(body.position) <= 1):
					treasure_collected.emit(body)
					tween.kill(),
			0.0,
			1.0,
			1
		)


func _treasure_collected(body):
	RunStats.update_gold()
	queue_free()
