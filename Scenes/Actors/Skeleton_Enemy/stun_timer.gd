extends Timer


func _on_timeout() -> void:
	owner.process_mode = Node.PROCESS_MODE_INHERIT
