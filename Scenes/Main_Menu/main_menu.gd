extends Control


func _ready() -> void:
	$Background.set_size(Vector2(42, 24))


func _on_start_pressed() -> void:
	SceneChangerAnim.change_scene(Resources.level_manager)


func _on_settings_pressed() -> void:
	var sett_scene = Resources.settings_menu.instantiate()
	get_tree().paused = true
	add_child(sett_scene)


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_child_exiting_tree(node: Node) -> void:
	if node.name == "Settings":
		get_tree().paused = false
