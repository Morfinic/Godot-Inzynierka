extends Control


@export var settings_scene: PackedScene


func _on_start_pressed() -> void:
	pass # Replace with function body.


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_packed(settings_scene)


func _on_exit_pressed() -> void:
	get_tree().quit()
