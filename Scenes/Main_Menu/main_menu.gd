extends Control


@export var settings_scene: PackedScene
@export var game_manager: PackedScene


func _on_start_pressed() -> void:
	get_tree().change_scene_to_packed(game_manager)


func _on_settings_pressed() -> void:
	var sett_scene = settings_scene.instantiate()
	get_tree().paused = true
	add_child(sett_scene)


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_child_exiting_tree(node: Node) -> void:
	if node.name == "Settings":
		get_tree().paused = false
